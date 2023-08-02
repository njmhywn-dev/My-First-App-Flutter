import 'dart:io';

import 'package:flutter_application_001/models/Transactions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB{

    String dbName;

    TransactionDB({required this.dbName});

    Future<Database> openDatabase() async{
      Directory appDirectory = await getApplicationDocumentsDirectory();
      String dbLocation = join(appDirectory.path,dbName);

      DatabaseFactory dbFactory = databaseFactoryIo;
      Database db = await dbFactory.openDatabase(dbLocation);
      return db;
    }

    Future<int> insertData(Transactions statement) async {
    //ฐานข้อมูล => Store
    // transaction.db => expense
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");

    // json
    var keyID = await store.add(db, {
      
    });
    
    await store.record(keyID).put(db, {
      "id": keyID, 
      "name": statement.name,
      "date": statement.dates,
      "date2": statement.dates2,
    });
    db.close();
    //print(keyID);
    return keyID;
  }

  Future deleteData(statement) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");
    await store.record(statement).delete(db);
  }

  Future<List> loadAllData() async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(
      db,finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    List transactionList = <Transactions>[];
    //ดึงมาทีละแถว
    for (dynamic record in snapshot) {
      transactionList.add(
        Transactions(
          id: record["id"]!=null? record["id"]:"",
          name: record["name"]!=null? record["name"]:"",
          dates: record["date"]!=null? record["date"]:"",
          dates2: record["date2"]!=null? record["date2"]:"",
          ));
    }
    return transactionList;
  }

  
}
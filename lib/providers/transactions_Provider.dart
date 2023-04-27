// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter_application_001/databases/tranaction_databases.dart';
import 'package:flutter_application_001/models/Transactions.dart';

class TransactionProvider with ChangeNotifier{

    List<Transactions> transactions = [];

    List<Transactions> getTransaction(){
      return transactions;
    }

    void initData() async {
      dynamic db = TransactionDB(dbName: "transactions.db");
      transactions = await db.loadAllData();
      notifyListeners();
    }

    void delete(id) async{
      dynamic db = TransactionDB(dbName: "transactions.db");
      await db.deleteData(id);
      transactions = await db.loadAllData();
      notifyListeners();
    }

    void addTransaction(Transactions statement) async{
      //var db = await TransactionDB(dbName: "transactions.db").openDatabase();
      dynamic db = TransactionDB(dbName: "transactions.db");
      await db.insertData(statement);
      transactions = await db.loadAllData();
      notifyListeners();
    }
}
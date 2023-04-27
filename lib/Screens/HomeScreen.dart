// ignore_for_file: file_names
//import 'package:qrscan/qrscan.dart' as scanner;

import 'package:flutter/material.dart';
import 'package:flutter_application_001/providers/transactions_Provider.dart';
import 'package:provider/provider.dart';
import 'FromWidget.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_001/models/Transactions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


 
  //const _HomeScreenState({Key? key}) : super(key: key);
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  
  @override
  Widget build(BuildContext context) {
    final now = DateFormat('ddMMyyyy').format(DateTime.now());
    int? now2 = int.tryParse(now);
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        toolbarHeight: 70,
        titleSpacing: 10,
        shadowColor: Colors.transparent,
        title: const Text(
          'แอพเตือนยาหมดอายุ',
          style: TextStyle(
              fontSize: 24, color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'รายการแจ้งเตือน!',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 25, color: Colors.grey[600]),
            ),
          ),
          Expanded(child: Consumer(
            builder: (context, TransactionProvider provider, child) {
              var count = provider.transactions.length;
              if (count <= 0) {
                return Center(
                  child: Text(
                    "ไม่มีรายการที่แจ้งเตือน!",
                    style: TextStyle(fontSize: 24, color: Colors.grey[400]),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: count,
                    itemBuilder: (context, int index) {
                      Transactions data = provider.transactions[index];
                      return Card(
                          elevation: 10,
                          margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                            SizedBox(height: 20,),      
                            ListTile(
                            leading: const CircleAvatar(radius: 30,
                            child: FittedBox(child: Icon(Icons.local_hospital)),),
                            title: Text("ชื่อยา: ${data.name}"),
                            subtitle: Text("วันหมดอายุ : ${data.dates}"),
                            trailing: InkWell(
                              onTap: (){
                                provider.delete(data.id);
                              },
                              child: Icon(Icons.cancel_sharp, color: Colors.red,size: 36,),
                            ),
                            ),
                            // Icon(Icons.verified_user, color: this.iconName=='green'? Colors.green : Colors.blueAccent),
                            
                            if(int.tryParse(data.dates2)! <= now2!)
                              Text("[ หมดอายุแล้ว ]", style: TextStyle(fontSize: 16,color: Colors.red)),

                             if(int.tryParse(data.dates2)! > now2!)
                              Text("[ ยังไม่หมดอายุ ]", style: TextStyle(fontSize: 16,color: Colors.green)),
                               SizedBox(height: 10,),
                            ],
                          ),
                        );
                    });
              }
            },
          )
          
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async{
            // String? cameraScanResult = await scanner.scan();
            // if(cameraScanResult != "ssd"){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const FormWidget();
             }));
      }
      // }      
      ), 
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

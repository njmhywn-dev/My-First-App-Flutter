// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_001/models/Transactions.dart';
import 'package:flutter_application_001/providers/transactions_Provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override

  FormScreenState createState() => FormScreenState();
}

class FormScreenState extends State<FormWidget> {
  final formkey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final dateController2 = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("เพิ่มรายการ"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.medical_services_outlined),
                      labelText: "ชื่อยา",
                    ),
                    autofocus: false,
                    validator: (String? namem) {
                      if (namem!.isEmpty) {
                        return "กรุณาป้อนชื่อรายการ";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "วันหมดอายุของยา",
                    ),
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickeddate != null) {
                        setState(() {
                          //dynamic dateController = pickeddate;
                          dateController.text = DateFormat('dd-MM-yyyy').format(pickeddate);
                          dateController2.text = DateFormat('ddMMyyyy').format(pickeddate);
                        });
                      }
                    },
                  ),
                  TextButton(
                      child: const Text("ตกลง"),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          var name = nameController.text;
                          var date = dateController.text;
                          var date2 = dateController2.text;

                          Transactions statement = Transactions(
                              name: name,
                              dates: date,
                              dates2: date2,
                              );

                          var provider = Provider.of<TransactionProvider>(context,listen: false);

                          provider.addTransaction(statement);

                          Navigator.pop(context);
                        }
                      })
                ],
              ),
            )));
  }
}

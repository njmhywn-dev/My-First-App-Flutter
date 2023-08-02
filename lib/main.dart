import 'package:flutter/material.dart';
import 'package:flutter_application_001/Screens/HomeScreen.dart';
import 'package:flutter_application_001/providers/transactions_Provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: const HomeScreen(),
      ),
    );
  }
}

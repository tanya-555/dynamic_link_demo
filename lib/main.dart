import 'package:dynamic_link_demo/home_screen.dart';
import 'package:dynamic_link_demo/card_statement_screen.dart';
import 'package:dynamic_link_demo/payment_history_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void initialiseFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initialiseFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Links Example',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => HomeScreen(), // Default
        '/cardStatement': (BuildContext context) => CardStatementScreen(),
        '/paymentHistory': (BuildContext context) => PaymentHistoryScreen(),
      },
    );
  }
}
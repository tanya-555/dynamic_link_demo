import 'package:dynamic_link_demo/home_screen.dart';
import 'package:dynamic_link_demo/landing.dart';
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

  Future<void> createFirstPostLink(String title) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://tanya.page.link',
      link: Uri.parse('https://dynamiclinkdemo.com/landing?title=$title'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.dynamic_link_demo',
      ),
    );
    await parameters.buildUrl();
  }

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
        '/': (BuildContext context) => HomeScreen(), // Default home route
        '/landing': (BuildContext context) => LandingScreen(),
      },
    );
  }
}
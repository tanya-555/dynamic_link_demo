import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void _initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          final Uri deepLink = dynamicLink?.link;

          if (deepLink != null) {
            _handleDeeplinks(deepLink);
          }
        },
        onError: (OnLinkErrorException e) async {
          print('onLinkError');
          print(e.message);
        }
    );
  }

  void _handleDeeplinks(Uri deeplink) {
    switch(deeplink.path) {
      case '/cardStatement' : Navigator.pushNamed(context, deeplink.path, arguments:
        {'cardNumber' : deeplink.queryParameters['cardNumber']});  break;

      case '/paymentHistory' : Navigator.pushNamed(context, deeplink.path, arguments:
      {'cardNumber' : deeplink.queryParameters['cardNumber'], 'cardType' : deeplink.queryParameters['cardType']});  break;
    }
  }

  @override
  void initState() {
    super.initState();
    _initDynamicLinks();
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
              ),
              padding: EdgeInsets.all(5.0),
              height: 50.0,
              child: Center(
                child: Text('Card Statement', style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
                ),
              ),
            ),
            onTap: () {
              _launchCardStatementScreen();
            },
          ),
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
              ),
              padding: EdgeInsets.all(5.0),
              height: 50.0,
              child: Center(
                child: Text('Payment History', style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
                ),
              ),
            ),
            onTap: () {
              _launchPaymentHistoryScreen();
            },
          ),
        ],
      ),
    );
  }

  void _launchCardStatementScreen() async {
    String url = await _createDeeplinkUri('https://dynamiclinkdemo.com/cardStatement?cardNumber=67');
    _launchUrl(url);
  }

  void _launchPaymentHistoryScreen() async {
    String url = await _createDeeplinkUri('https://dynamiclinkdemo.com/paymentHistory?cardNumber=67&cardType=primary');
    _launchUrl(url);
  }

  Future<String> _createDeeplinkUri(String deeplink) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://tanya.page.link',
      link: Uri.parse(deeplink),
      androidParameters: AndroidParameters(
        packageName: 'com.example.dynamic_link_demo',
      ),
    );
    Uri uri = await parameters.buildUrl();
    return uri.toString();
  }
}


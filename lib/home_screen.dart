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

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          final Uri deepLink = dynamicLink?.link;

          if (deepLink != null) {
            var args = {};

            Navigator.pushNamed(context, deepLink.path, arguments:
            {'title' : deepLink.queryParameters['title']});
          }
        },
        onError: (OnLinkErrorException e) async {
          print('onLinkError');
          print(e.message);
        }
    );
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      Navigator.pushNamed(context, deepLink.path);
    }
  }

  Future<String> createFirstPostLink(String title) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://tanya.page.link',
      link: Uri.parse('https://dynamiclinkdemo.com/landing?title=$title'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.dynamic_link_demo',
      ),
    );
    Uri uri = await parameters.buildUrl();
    return uri.toString();
  }

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
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
      body: InkWell(
        child: Text('Landing Screen'),
        onTap: () {
          _launchLanding();
        },
      ),
    );
  }

  void _launchLanding() async {
    String url = await createFirstPostLink('this');
    _launchUrl(url);
  }
}


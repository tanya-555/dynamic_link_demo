import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardStatementScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text('Card Statement'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('card number : ', style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),),
            Text(arguments['cardNumber'], style: TextStyle(
              fontSize: 30.0,
            ),),
          ],
        ),
      ),
    );
  }
}


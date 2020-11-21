import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('card type : ', style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),),
                Text(arguments['cardType'], style: TextStyle(
                  fontSize: 30.0,
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
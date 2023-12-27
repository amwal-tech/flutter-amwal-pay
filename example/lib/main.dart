import 'package:flutter/material.dart';
import 'package:amwal_pay/amwal_pay.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // create a double state variable to hold the amount
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: AmwalPayWidget(
            merchantId: "merchantId",
            amount: 10.0,
            onPaymentFinished: (String value) {
              print(value);
            },
          ),
        ),
      ),
    );
  }
}

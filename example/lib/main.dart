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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AmwalPay amwalPay = AmwalPayBuilder("sandbox-amwal-e53fe88e-0896-4f57-98b4-a8907f73c0c6")
        .countryCode("countryCode")
        .phoneNumber("phoneNumber")
        .build();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton( onPressed: () async {
            await amwalPay.start(100.0);
          },child: const Text("run"),),
        ),
      ),
    );
  }
}

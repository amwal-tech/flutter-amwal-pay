import 'package:flutter/material.dart';
import 'package:amwal_pay/amwal_pay.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // arabic
      ],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: AmwalPayWidget(
            merchantId: "sandbox-amwal-e53fe88e-0896-4f57-98b4-a8907f73c0c6",
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

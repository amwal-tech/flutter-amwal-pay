import 'package:flutter/material.dart';
import 'package:amwal_pay/amwal_pay.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
            text: AppLocalizations.of(context)?.quickCheckoutByAmwal ?? "Quick Checkout By Amwal",
            merchantId: "merchantId",
            amount: 10.0,
            phoneNumber: "phoneNumber",// has to be full phone number with country code ex +201234567890
            countryCode: "countryCode",// has to be country code ex +20
            language: AmwalPayLanguage.Arabic,
            onPaymentFinished: (String value) {
              print(value);
            },
          ),
        ),
      ),
    );
  }
}

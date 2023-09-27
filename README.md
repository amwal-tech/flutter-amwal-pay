# AmwalPay Flutter SDK 

The AmwalPay Flutter SDK provides a convenient way to integrate AmwalPay payment functionality into your Flutter applications. This documentation will guide you through the process of setting up and using the `AmwalPay` class.

## Prerequisites

Before using the AmwalPay Flutter SDK, make sure you have the following:

- Flutter SDK installed on your development machine
- A Flutter project set up and configured

## Installation

To use the AmwalPay Flutter SDK, add the following dependency to your project's `pubspec.yaml` file:

```yaml
dependencies:
  AmwalPayPlugin: ^1.0.0
```

## iOS pod install

Follow these steps to install the necessary dependencies for iOS:

1 Open the ios directory in your Flutter project.

2 Open the Podfile in a text editor.

3 Locate the line that specifies the platform and version, and set it to the minimum supported version:

```
platform :ios, '16.0'
```
4 Save the changes to the Podfile.

5 Open a terminal and navigate to the ios directory of your Flutter project:

```
cd ios
```
6 Run the following command to deintegrate any existing CocoaPods dependencies:

```
pod deintegrate
```

7 Once the deintegration is complete, run the following command to install the dependencies:
```
pod install
```

This command will download and install the necessary CocoaPods dependencies for your iOS project.

## Android Install

Follow these steps to install the necessary dependencies for Android:

1. Install Amwal Payment SDK in Android

Add the following lines to the dependencies section in app/build.gradle

```
apply plugin: 'com.android.application'

android { ... }

dependencies {
  // ...

  // Amwal Payment SDK
implementation "tech.amwal.payment:payment:1.0.0-beta07"
}
```

2. Associate your app with [Amwal's Digital Asset Links.](https://docs.amwal.tech/docs/setup)

3. Set minSdkVersion 23

```
defaultConfig {
        applicationId "com.example.amwal_example"
        minSdkVersion 23
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
```

4. Lastly, update the MainActivity class in your Android project for the Flutter plugin

In the file `app/src/main/kotlin/../MainActivity`, update the import statement & class declaration :


```
// Before:
import io.flutter.embedding.android.FlutterActivity

// After:
import io.flutter.embedding.android.FlutterFragmentActivity
```

Update the class declaration to extend FlutterFragmentActivity:
kotlin

```
// Before:
class MainActivity: FlutterActivity() {
}

// After:
class MainActivity: FlutterFragmentActivity() {
}
```

   
   
## Usage

import necessary package.

```
import import 'package:amwal_pay/amwal_pay.dart';
```
Create an instance of the AmwalPay class, providing the required parameters:

```
AmwalPay amwalPay = AmwalPayBuilder('your_merchant_id')
    .countryCode('your_country_code')
    .phoneNumber('your_phone_number')
    .build();
```

Start a payment transaction by calling the startPayment method with the desired amount:

```
String paymentResult = (await amwal.startPayment(amount))!;
```

The startPayment method returns a Future that resolves to a String representing the payment result. You can handle the result according to your application's needs.

### Example

```
import 'package:flutter/material.dart';
import 'package:amwal_pay/amwal_pay_method_channel.dart';

class AmwalPayScreen extends StatelessWidget {
  final AmwalPay amwalPay;

  const AmwalPayScreen(this.amwalPay);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AmwalPay'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            String? paymentResult = await amwalPay.startPayment(100.0);
            // Handle the payment result here
          },
          child: Text('Pay Now'),
        ),
      ),
    );
  }
}

void main() {
  AmwalPay amwalPay = AmwalPayBuilder('your_merchant_id')
    .countryCode('your_country_code')
    .phoneNumber('your_phone_number')
    .build();

  runApp(MaterialApp(
    home: AmwalPayScreen(amwalPay),
  ));
}

```

### Conclusion

Congratulations! You have successfully integrated the AmwalPay Flutter SDK into your Flutter application. You can now accept payments using AmwalPay in your app. For more information and advanced usage, refer to the AmwalPay SDK documentation.

If you encounter any issues or have further questions, please refer to the official AmwalPay support for assistance.

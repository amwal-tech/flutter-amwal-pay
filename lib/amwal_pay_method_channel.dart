import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'amwal_pay.dart';
import 'amwal_pay_platform_interface.dart';

/// An implementation of [AmwalPayPlatform] that uses method channels.
class MethodChannelAmwalPay extends AmwalPayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('amwal_pay');

  @override
  Future<TransactionStatus> startPayment(Map<String, dynamic> args) async {
    final String result = await methodChannel.invokeMethod('startPayment', args);
    // parse the result and return the appropriate TransactionStatus
    // result should be on of these strings
    // "code:0, error:Payment Canceled by the user"
    // "code:1, transactionId:${transactionId}"
    // "code:-1, error:${error.message}"
    TransactionStatus type;
    if (result.startsWith("code:1")) {
      type = TransactionSuccess(result.split(":")[2]);
    } else if (result.startsWith("code:0")) {
      type = TransactionCancel();
    } else {
      type = TransactionFailure(result.split(":")[2]);
    }
    if (kDebugMode) {
      print("Transaction Status: $type");
    }
    return type;
  }
}

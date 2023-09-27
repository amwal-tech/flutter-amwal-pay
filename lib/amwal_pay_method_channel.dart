import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'amwal_pay_platform_interface.dart';

/// An implementation of [AmwalPayPlatform] that uses method channels.
class MethodChannelAmwalPay extends AmwalPayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('amwal_pay');

  @override
  Future<String?> startPayment(Map<String, dynamic> args) async {
    final String result = await methodChannel.invokeMethod('startPayment', args);
    return result;
  }
}

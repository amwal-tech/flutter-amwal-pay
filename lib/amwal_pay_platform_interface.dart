import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'amwal_pay.dart';
import 'amwal_pay_method_channel.dart';

abstract class AmwalPayPlatform extends PlatformInterface {
  /// Constructs a AmwalPayPlatform.
  AmwalPayPlatform() : super(token: _token);

  static final Object _token = Object();

  static AmwalPayPlatform _instance = MethodChannelAmwalPay();

  /// The default instance of [AmwalPayPlatform] to use.
  ///
  /// Defaults to [MethodChannelAmwalPay].
  static AmwalPayPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AmwalPayPlatform] when
  /// they register themselves.
  static set instance(AmwalPayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<TransactionStatus> startPayment(Map<String, dynamic> args) {
    throw UnimplementedError('startPayment() has not been implemented.');
  }
}

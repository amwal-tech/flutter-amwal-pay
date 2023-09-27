import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:amwal_pay/amwal_pay_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelAmwalPay platform = MethodChannelAmwalPay();
  const MethodChannel channel = MethodChannel('amwal_pay');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.startPayment({}), '42');
  });
}

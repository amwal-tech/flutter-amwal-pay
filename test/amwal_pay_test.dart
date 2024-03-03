import 'package:flutter_test/flutter_test.dart';
import 'package:amwal_pay/amwal_pay.dart';
import 'package:amwal_pay/amwal_pay_platform_interface.dart';
import 'package:amwal_pay/amwal_pay_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAmwalPayPlatform
    with MockPlatformInterfaceMixin
    implements AmwalPayPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<TransactionStatus> startPayment(Map<String, dynamic> args) => Future.value(TransactionSuccess("42"));

  void main() {
    final AmwalPayPlatform initialPlatform = AmwalPayPlatform.instance;

    test('$MethodChannelAmwalPay is the default instance', () {
      expect(initialPlatform, isInstanceOf<MethodChannelAmwalPay>());
    });

    test('getPlatformVersion', () async {
      AmwalPay amwalPayPlugin = AmwalPayBuilder("").build();
      MockAmwalPayPlatform fakePlatform = MockAmwalPayPlatform();
      AmwalPayPlatform.instance = fakePlatform;
      expect(await amwalPayPlugin.start(20), '42');
    });
  }
}

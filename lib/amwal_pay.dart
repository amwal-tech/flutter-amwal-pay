
import 'amwal_pay_method_channel.dart';


class AmwalPay {
  final String _merchantId;
  final String _countryCode;
  final String _phoneNumber;

  final MethodChannelAmwalPay _methodChannel = MethodChannelAmwalPay();

  AmwalPay(this._merchantId, this._countryCode, this._phoneNumber);

  Future<String?> start(double amount) async {
    return await _methodChannel.startPayment(_argumentAdapter(amount));
  }

  Map<String, dynamic> _argumentAdapter(double amount) {
    return {
      'merchantId': _merchantId,
      'countryCode': _countryCode,
      'phoneNumber': _phoneNumber,
      'amount': amount,
    };
  }
}

class AmwalPayBuilder {
  final String _merchantId;
  String _countryCode = "";
  String _phoneNumber = "";

  AmwalPayBuilder(this._merchantId);

  AmwalPayBuilder countryCode(String countryCode) {
    _countryCode = countryCode;
    return this;
  }

  AmwalPayBuilder phoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    return this;
  }

  AmwalPay build() {
    if (_merchantId.isEmpty) {
      throw Exception("Merchant Id has to be provided");
    }
    return AmwalPay(_merchantId, _countryCode, _phoneNumber);
  }
}

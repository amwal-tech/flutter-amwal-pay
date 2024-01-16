import 'package:flutter/material.dart';
import 'amwal_pay_method_channel.dart';

enum AmwalPayLanguage { English, Arabic }

String? mapLanguage(AmwalPayLanguage? language) {
  switch (language) {
    case AmwalPayLanguage.English:
      return "English";
    case AmwalPayLanguage.Arabic:
      return "Arabic";
    default:
      return null;
  }
}

class AmwalPay {
  final String _merchantId;
  final String? _countryCode;
  final String? _phoneNumber;
  final String? _refId;
  final String? _orderId;
  final AmwalPayLanguage? _language;

  final MethodChannelAmwalPay _methodChannel = MethodChannelAmwalPay();

  AmwalPay(this._merchantId, this._countryCode, this._phoneNumber, this._refId,
      this._orderId, this._language);

  Future<String?> start(double amount) async {
    return await _methodChannel.startPayment(_argumentAdapter(amount));
  }

  Map<String, dynamic> _argumentAdapter(double amount) {
    return {
      'merchantId': _merchantId,
      'countryCode': _countryCode,
      'phoneNumber': _phoneNumber,
      'amount': amount,
      'refId': _refId,
      'orderId': _orderId,
      'language': mapLanguage(_language)
    };
  }
}

class AmwalPayBuilder {
  final String _merchantId;
  String? _countryCode;
  String? _phoneNumber;
  String? _refId;
  String? _orderId;
  AmwalPayLanguage? _language;

  AmwalPayBuilder(this._merchantId);

  AmwalPayBuilder countryCode(String? countryCode) {
    _countryCode = countryCode;
    return this;
  }

  AmwalPayBuilder phoneNumber(String? phoneNumber) {
    _phoneNumber = phoneNumber;
    return this;
  }

  AmwalPayBuilder refId(String? refId) {
    _refId = refId;
    return this;
  }

  AmwalPayBuilder orderId(String? orderId) {
    _orderId = orderId;
    return this;
  }

  AmwalPayBuilder language(AmwalPayLanguage? language) {
    _language = language;
    return this;
  }

  AmwalPay build() {
    if (_merchantId.isEmpty) {
      throw Exception("Merchant Id has to be provided");
    }
    return AmwalPay(
        _merchantId, _countryCode, _phoneNumber, _refId, _orderId, _language);
  }
}

/// AmwalPayWidget is a widget that can be used to start the payment process
/// without the need to create an instance of AmwalPay class.
class AmwalPayWidget extends StatefulWidget {
  final String text;
  final String merchantId;
  final double amount;
  final String? phoneNumber;
  final String? countryCode;
  final String? refId;
  final String? orderId;
  final AmwalPayLanguage? language;

  final ValueChanged<String> onPaymentFinished;

  AmwalPayWidget(
      {Key? key,
      required this.text,
      required this.merchantId,
      required this.amount,
      this.phoneNumber,
      this.countryCode,
      this.refId,
      this.orderId,
      this.language,
      required this.onPaymentFinished})
      : super(key: key);

  @override
  State<AmwalPayWidget> createState() => _AmwalPayWidgetState();
}

class _AmwalPayWidgetState extends State<AmwalPayWidget> {
  late AmwalPay _amwalPay;

  @override
  void initState() {
    super.initState();
    _amwalPay = AmwalPayBuilder(widget.merchantId)
        .phoneNumber(widget.phoneNumber)
        .countryCode(widget.countryCode)
        .refId(widget.refId)
        .orderId(widget.orderId)
        .language(widget.language)
        .build();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      onPressed: () async {
        _amwalPay.start(widget.amount).then((value) {
          widget.onPaymentFinished(value!);
        });
      },
      child: Text(widget.text),
    );
  }
}

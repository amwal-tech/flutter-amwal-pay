import Flutter
import UIKit
import AmwalPay
import SwiftUI

public class AmwalPayPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "amwal_pay", binaryMessenger: registrar.messenger())
    let instance = AmwalPayPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
            if call.method == "startPayment" {
                let vat = 0.0
                guard let arguments = call.arguments as? [String: Any],
                  let amount = arguments["amount"] as? Double,
                  let phoneNumber = arguments["phoneNumber"] as? String,
                  let merchantId = arguments["merchantId"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
                return
            }
                let paymentView = AmwalPaymentView(
                    currency: .SAR,
                    amount: Double(amount),
                    vat: Double(vat),
                    merchantId: merchantId) {transactionId in
                    // Payment completion block
                    result("Payment completed successfully. \(transactionId)")
                }

                    // Present the payment view
                    let paymentViewController = UIHostingController(rootView: paymentView)
                    let rootViewController = UIApplication.shared.keyWindow?.rootViewController
                    rootViewController?.present(paymentViewController, animated: true, completion: nil)
                
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
}

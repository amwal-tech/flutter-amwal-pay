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
            guard let arguments = call.arguments as? [String: Any] else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
                return
            }
            
            guard let amount = arguments["amount"] as? Double else {
                result(FlutterError(code: "INVALID_amount", message: "Invalid amount", details: nil))
                
                return
            }
            
            let refId = arguments["refId"] as? String
            let orderId = arguments["orderId"] as? String
            let language = arguments["language"] as? String
            let phoneNumber = arguments["phoneNumber"] as? String
            let countryCode = arguments["countryCode"] as? String
            let languageOption: Language? = {
                switch language {
                case "Arabic":
                    return Language.arabic
                case "English":
                    return Language.english
                default:
                    return nil
                }
            }()
            
            guard let merchantId = arguments["merchantId"] as? String else {
                result(FlutterError(code: "INVALID_merchantId", message: "Invalid merchantId", details: nil))
                return
            }
            let rootViewController = UIApplication.shared.keyWindow?.rootViewController
            var builder: PaymentRequestBuilder {
                    let builder: PaymentRequestBuilder = .init()
                        .setCurrency(.SAR)
                        .setAmount(Double(amount) ?? 0.0)
                        .setVat(Double(vat) ?? 0.0)
                        .setMerchantId(merchantId)
                        .setOrderId(orderId)
                        .setReferenceId(refId)
                        .setLanguage(languageOption)
                        .setUserInfo(
                            .init(
                                phoneNumber: phoneNumber,
                                email: nil
                            )
                        )
                        .setCompletion { status in
                         // Payment completion block
                         switch status {
                         case let .success(transactionId):
                             result("code:1, transactionId:" + transactionId)
                         case let .fail(error , id):
                             result("code:-1, werror:" + error)
                             print(error)
                         @unknown default:
                             result("code:-1, error:Unknown issue happened")
                         }
                         rootViewController?.dismiss(animated: true)
                        }
                    return builder
                }
            let paymentView = AmwalPaymentView(paymentRequestBuilder: builder)
            let paymentViewController = UIHostingController(rootView: paymentView)
            // Present the payment view
            rootViewController?.present(paymentViewController, animated: true, completion: nil)
            
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}

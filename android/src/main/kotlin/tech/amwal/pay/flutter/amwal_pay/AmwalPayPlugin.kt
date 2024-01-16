package tech.amwal.pay.flutter.amwal_pay

import android.app.Application.ActivityLifecycleCallbacks
import androidx.activity.ComponentActivity
import androidx.annotation.NonNull
import androidx.fragment.app.FragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import tech.amwal.payment.PaymentSheet
import tech.amwal.payment.PaymentSheetResult
import tech.amwal.payment.dsl.paymentSheet

class AmwalPayPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private var activity: ComponentActivity? = null
    private lateinit var payment: PaymentSheet
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "amwal_pay")
        channel.setMethodCallHandler(this)
    }


    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method.equals("startPayment")) {
            val merchantId = call.argument<String>("merchantId");
            val phoneNumber = call.argument<String?>("phoneNumber") ?: "";
            val countryCode = call.argument<String?>("countryCode") ?: "";
            val refId = call.argument<String?>("refId") ?: "";
            val orderId = call.argument<String?>("orderId") ?: "";
            val language = call.argument<String?>("language") ?: "";
            val amount = call.argument<Double>("amount");
            if (merchantId != null &&
                    amount != null &&
                    activity != null
            ) {
                val builder = PaymentSheet.Config.Builder()
                if (phoneNumber.isNotEmpty()) {
                    builder.phoneNumber(phoneNumber)
                }
                if (countryCode.isNotEmpty()) {
                    builder.countryCode(countryCode)
                }
                if (refId.isNotEmpty()) {
                    builder.refId(refId)
                }
                if (orderId.isNotEmpty()) {
                    builder.orderId(orderId)
                }
                if (language.isNotEmpty()) {
                    when(language){
                        "Arabic" -> builder.language(PaymentSheet.Language.Arabic)
                        "English" -> builder.language(PaymentSheet.Language.English)
                        else -> builder.language(PaymentSheet.Language.English)
                    }
                }
                payment = PaymentSheet(
                        activity = activity!!,
                        merchantId = merchantId,
                        config = builder
                                .build()
                ) {
                    when (it) {
                        PaymentSheetResult.Canceled -> result.error("1", "Payment Canceled", "Canceled by the user")
                        is PaymentSheetResult.Failed -> result.error(
                                "2",
                                it.error.message,
                                it.toString()
                        )

                        is PaymentSheetResult.Success -> result.success(it.transactionId)
                    }
                }
                payment.show(PaymentSheet.Amount(total = amount.toFloat()))
            }
        } else {
            result.notImplemented();
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activity = binding.activity as ComponentActivity
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.activity = binding.activity as ComponentActivity
    }

    override fun onDetachedFromActivity() {

    }
}

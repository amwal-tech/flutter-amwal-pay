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
      val phoneNumber = call.argument<String>("phoneNumber");
      val countryCode = call.argument<String>("countryCode");
      val amount = call.argument<Double>("amount");
      if (merchantId != null &&
        phoneNumber != null &&
        countryCode != null &&
        amount != null &&
        activity != null
      ) {
        payment = PaymentSheet(
          activity = activity!!,
          merchantId = merchantId,
          config = PaymentSheet.Config.Builder().build()
        ) {
          when (it) {
            PaymentSheetResult.Canceled -> result.error("1", "Payment Canceled", "")
            PaymentSheetResult.Completed -> result.success("")
            is PaymentSheetResult.Failed -> result.error(
              "2",
              it.error.message,
              it.toString()
            )
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

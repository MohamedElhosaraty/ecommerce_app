
import 'package:dio/dio.dart';
import 'package:ecommerce_app/stripe_payment/stripe_keys.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


abstract class PaymentManager{

  static Future<String?>makePayment(int amount,String currency)async{
    try {
      String clientSecret=await _getClientSecret((amount*100).toString(), currency);
      await _initializePaymentSheet(clientSecret);
      await Stripe.instance.presentPaymentSheet();
    } catch (err) {
      if (err is DioError) {
        print('Dio error: ${err.response?.data}');
        print('Dio error status: ${err.response?.statusCode}');
        print('Dio error message: ${err.message}');
      } else {
        print('Error: $err');
      }
    }
    return null;
  }

  static Future<void>_initializePaymentSheet(String clientSecret)async{
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "Basel",
      ),
    );
  }

  static Future<String> _getClientSecret(String amount,String currency)async{
    Dio dio=Dio();
    var response= await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      ),
      data: {
        'amount': amount.toString(),
        'currency': currency,
      },
    );
    if(response.statusCode == 200){
      print('Response data: ${response.data["client_secret"]}');
      return response.data["client_secret"];
    }
    return response.data["client_secret"];
  }

}
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tsofie/app/utils/logger_utils.dart';
import 'package:tsofie/app/widgets/primary_button.dart';

class RazorPayTesting extends StatefulWidget {
  const RazorPayTesting({Key? key}) : super(key: key);

  @override
  State<RazorPayTesting> createState() => _RazorPayTestingState();
}

class _RazorPayTestingState extends State<RazorPayTesting> {
  final _razorPay = Razorpay();

  @override
  void initState() {
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _razorPay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: primaryButton(
              onPress: () async{
                var options = {
                  'key': 'rzp_test_Z4INNZAPxTeSvC',
                  'amount': 100,
                  'name': 'Test',
                  'description': 'Test Payment',
                  'prefill': {
                    'contact': '8888888888',
                    'email': 'test@razorpay.com'
                  }
                };
                try {
                  _razorPay.open(options);
                } catch (e) {
                  LoggerUtils.logException('RazorPay Error : ', e);
                }
              },
              buttonTxt: 'PayNow'),
        ),
      ),
    );
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(
        'Payment Success : ${response.paymentId} - ${response.orderId} - ${response.signature}');
  }

  _handlePaymentError(PaymentFailureResponse response) {
    print('Payment Error : ${response.code} - ${response.message}');
  }

  _handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet : ${response.walletName}');
  }
}

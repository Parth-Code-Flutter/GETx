import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/authentication/buyer_auth/otp_buyer/controller/otp_verification_controller_buyer.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/primary_button.dart';
import 'package:tsofie/app/widgets/while_top_widget.dart';

class OtpVerificationBuyerScreen
    extends GetView<OtpVerificationControllerBuyer> {
  OtpVerificationBuyerScreen({Key? key}) : super(key: key) {
    final arg = Get.arguments;
    controller.setIntData(arg);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kColorBackground,
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: SizedBox(
              height: Get.height * 0.94,
              child: Column(
                children: [
                  whiteTopWidget(txt: kLabelGetOTP),
                  Padding(
                    padding: const EdgeInsets.only(top: 46),
                    child:
                        Text(kLabelOtpText, style: TextStyles.kH14BlackBold400),
                  ),
                  Text(kLabelNumber + controller.mobileNo.value,
                      style: TextStyles.kH14BlackBold400),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.asset(kImgOtpScreen),
                  ),
                  otpTextFields(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 34, vertical: 24),
                    child: primaryButton(
                        buttonTxt: kLabelSubmit,
                        onPress: () {
                          controller.validatedUserInput();
                        }),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      controller.bResendOTPAPICall();
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: kLabelDidntReceiveOtp,
                              style: TextStyles.kH12HintTextBold400),
                          TextSpan(
                              text: ' $kLabelResend',
                              style: TextStyles.kH12PrimaryTextBold400)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget otpTextFields() {
    return Padding(
      padding: const EdgeInsets.only(left: 34, right: 34, top: 58),
      child: PinCodeTextField(
        appContext: Get.context!,
        controller: controller.otpController,
        length: 6,
        onChanged: (String value) {},
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 46,
          fieldWidth: 40,
          activeFillColor: kColorWhite,
          inactiveFillColor: kColorWhite,
          inactiveColor: kColorBlack,
          disabledColor: Colors.black,
          activeColor: kColorPrimary,
          selectedFillColor: kColorPrimary,
          selectedColor: kColorPrimary,
        ),
        cursorColor: Colors.black,
        onCompleted: (v) {
          controller.isOtpEntered.value = true;
          controller.otpText.value = v;
        },
        validator: (v) {
          if (v!.length < 3) {
            return "";
          } else {
            return null;
          }
        },
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/authentication/seller_auth/login_as_seller/controller/login_as_seller_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_textfield.dart';
import 'package:tsofie/app/widgets/primary_button.dart';
import 'package:tsofie/app/widgets/while_top_widget.dart';

class LoginAsSellerScreen extends GetView<LoginAsSellerController> {
  const LoginAsSellerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: kColorBackground,
          body: SingleChildScrollView(
            child: SizedBox(
              height: Get.height * 0.94,
              child: Column(
                children: [
                  whiteTopWidget(txt: kLabelWelcomeToTSOFIE + '- Seller'),
                  const Padding(
                    padding: EdgeInsets.only(top: 46, bottom: 40),
                    child: Text(
                      kLabelSignInToContinue,
                      style: TextStyles.kH16BlackBold400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 64),
                    child: Image.asset(kImgLoginProfile),
                  ),
                  mobileNumberTextField(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 34, vertical: 26),
                    child: primaryButton(
                      onPress: () {
                        controller.checkValidation();
                      },
                      buttonTxt: kLabelGetOTP,
                    ),
                  ),
                  const Spacer(),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                            text: kLabelDontHaveAnAccount,
                            style: TextStyles.kH12HintTextBold400),
                        TextSpan(
                          text: ' $kLabelRegister',
                          style: TextStyles.kH12PrimaryTextBold400,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              controller.navigateToRegistrationScreen();
                            },
                        )
                      ],
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

  Widget mobileNumberTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextField(
              controller: controller.mobileNumberController,
              hintText: kLabelYourMobileNumber,
              preFixIcon: Padding(
                padding: const EdgeInsets.only(top: 18,bottom: 18),
                child: SvgPicture.asset(
                  kIconPhone,

                  // color: controller.fNode.value.hasFocus
                  //     ? kColorPrimary
                  //     :
                  color: kColorGrey9098B1,
                ),
              ),
              keyboardType: TextInputType.phone,
              maxLength: 10),
          Obx(
            () => Visibility(
              visible: controller.isValidMobileNumber.value == false &&
                  controller.errorMobileStr.trim().isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 4),
                child: Text(controller.errorMobileStr.value,
                    style: TextStyles.kH14RedBold400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

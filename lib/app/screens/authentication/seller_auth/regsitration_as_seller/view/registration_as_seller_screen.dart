import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/authentication/seller_auth/regsitration_as_seller/controller/registration_as_seller_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_textfield.dart';
import 'package:tsofie/app/widgets/primary_button.dart';
import 'package:tsofie/app/widgets/profile_yello_bg.dart';
import 'package:tsofie/app/widgets/while_top_widget.dart';

import '../../../../../utils/alert_message_utils.dart';

class RegistrationAsSellerScreen
    extends GetView<RegistrationAsSellerController> {
  const RegistrationAsSellerScreen({Key? key}) : super(key: key);

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
            child: Column(
              children: [
                whiteTopWidget(txt: kLabelSellerRegistration),
                profileImageContainer(),
                userNameTextField(),
                mobileNumberTextField(),
                companyNameTextField(),
                gstNumberTextField(),
                termsAndPrivacyContainer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
                  child: primaryButton(
                      onPress: () {
                        // if( controller.isGstNumberValidate.value == true){
                        controller.validateUserInput();
                        // }
                        // else{
                        //   Get.find<AlertMessageUtils>().showSnackBar(
                        //       message: 'Invalid GST Number');
                        // }
                      },
                      buttonTxt: kLabelSignUp),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: kLabelAlreadyHaveAnAccount,
                        style: TextStyles.kH12HintTextBold400,
                      ),
                      TextSpan(
                          text: ' $kLabelSignIp',
                          style: TextStyles.kH12PrimaryTextBold400,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              controller.navigateToLoginScreen();
                            }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileImageContainer() {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          openBottomSheet();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 46, bottom: 40),
          child: controller.selectedProfileImage.value.path.isNotEmpty
              ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    profileYellowBG(),
                    Container(
                      height: 95,
                      width: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: kColorBlack, width: 4),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.file(
                          File(controller.selectedProfileImage.value.path),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ],
                )
              : Image.asset(kImgProfilePlaceholder),
        ),
      );
    });
  }

  Widget userNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextField(
            controller: controller.userNameController,
            hintText: kLabelUserName,
            preFixIcon: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              child: SvgPicture.asset(
                kIconUser,
                // color: controller.fNode.value.hasFocus
                //     ? kColorPrimary
                //     :
                color: kColorGrey9098B1,
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isUserNameValidate.value == false,
              child: controller.userNameStr.value == ''
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.userNameStr.value,
                          style: TextStyles.kH14RedBold400),
                    ),
            );
          }),
        ],
      ),
    );
  }

  Widget mobileNumberTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextField(
            controller: controller.mobileController,
            hintText: kLabelYourMobileNumber,
            maxLength: 10,
            keyboardType: TextInputType.number,
            preFixIcon: Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 18),
              child: SvgPicture.asset(
                kIconPhone,
                // color: controller.fNode.value.hasFocus
                //     ? kColorPrimary
                //     :
                color: kColorGrey9098B1,
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isMobileNoValidate.value == false,
              child: controller.mobileNoStr.value == ''
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.mobileNoStr.value,
                          style: TextStyles.kH14RedBold400),
                    ),
            );
          }),
        ],
      ),
    );
  }

  Widget companyNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextField(
            controller: controller.companyNameController,
            hintText: kLabelCompanyName,
            preFixIcon: Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 18),
              child: SvgPicture.asset(
                kIconCompany,
                // color: controller.fNode.value.hasFocus
                //     ? kColorPrimary
                //     :
                color: kColorGrey9098B1,
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isCompanyNameValidate.value == false,
              child: controller.companyNameStr.value == ''
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.companyNameStr.value,
                          style: TextStyles.kH14RedBold400),
                    ),
            );
          }),
        ],
      ),
    );
  }

  Widget gstNumberTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Focus(
            onFocusChange: (value) {
              if (value == false &&
                  controller.gstNumberController.text.trim().isNotEmpty) {
                // controller.sellerGstNumberAPICall();
              }
            },
            child: commonTextField(
              controller: controller.gstNumberController,
              hintText: kLabelGSTNumber,
              maxLength: 15,
              preFixIcon: Padding(
                padding: const EdgeInsets.only(top: 18, bottom: 18),
                child: SvgPicture.asset(
                  kIconGst,
                  // color: controller.fNode.value.hasFocus
                  //     ? kColorPrimary
                  //     :
                  color: kColorGrey9098B1,
                ),
              ),
            ),
          ),
          // Obx(() {
          //   return
          Visibility(
            visible: false,
            // visible: controller.isGstNumberValidate.value == false,
            child: controller.gstNumberStr.value == ''
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(controller.gstNumberStr.value,
                        style: TextStyles.kH14RedBold400),
                  ),
          ),
          // ;
          //       }),
        ],
      ),
    );
  }

  Widget termsAndPrivacyContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  color: kColorWhite,
                  child: Theme(
                    data: ThemeData(unselectedWidgetColor: kColorD8D8D8),
                    child: Checkbox(
                      value: controller.isPrivacyPolicySelected.value,
                      onChanged: (value) {
                        controller.isPrivacyPolicySelected.value =
                            !controller.isPrivacyPolicySelected.value;
                      },
                      activeColor: kColorPrimary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity:
                          VisualDensity(vertical: -4, horizontal: -4),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'I agree to the ',
                        style: TextStyles.kH10HintBold400,
                      ),
                      TextSpan(
                        text: 'Terms of Services',
                        style: TextStyles.kH10PrimaryUnderLineBold400,
                      ),
                      TextSpan(
                        text: ' and ',
                        style: TextStyles.kH10HintBold400,
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyles.kH10PrimaryUnderLineBold400,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
          Obx(() {
            return Visibility(
              visible: controller.isPrivacyPolicySelected.value == false,
              child: controller.privacyPolicyStr.value == ''
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 0),
                      child: Text(controller.privacyPolicyStr.value,
                          style: TextStyles.kH12RedBold400),
                    ),
            );
          }),
        ],
      ),
    );
  }

  openBottomSheet() {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) {
        return Dialog(
          clipBehavior: Clip.none,
          child: Container(
            height: 100,
            width: Get.width,
            padding: EdgeInsets.only(left: 18, top: 18),
            decoration: BoxDecoration(
                color: kColorWhite, borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.imagePicker(ImageSource.gallery);
                    Get.back();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      SizedBox(width: 6),
                      Text(
                        'Select from gallery',
                        style: TextStyles.kH14BlackBold400,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: Get.width,
                  color: kColorD8D8D8,
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
                GestureDetector(
                  onTap: () {
                    controller.imagePicker(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera),
                      SizedBox(width: 6),
                      Text(
                        'Take a new photo',
                        style: TextStyles.kH14BlackBold400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

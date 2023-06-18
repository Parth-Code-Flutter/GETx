import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/repositories/auth_repo.dart';
import 'package:tsofie/app/screens/authentication/buyer_auth/registration_as_buyer/model/request/buyer_reg_requset_model.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

import '../../../../../common/app_constants.dart';
import '../../../../../common/routing_constants.dart';
import '../../../../../utils/alert_message_utils.dart';
import '../../../../../utils/regex_data.dart';
import '../model/response/buyer_reg_response_model.dart';

class RegistrationASBuyerController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  RxBool isPrivacyPolicySelected = false.obs;
  RxBool isMobileNoValidate = false.obs;
  RxBool isUserNameValidate = false.obs;
  RxBool isUserEmailValidate = false.obs;

  RxString mobileNoStr = ''.obs;
  RxString userNameStr = ''.obs;
  RxString userEmailStr = ''.obs;

  Rx<XFile> selectedProfileImage = XFile('').obs;

  Rx<Color> mobileFieldColor = kColorGrey9098B1.obs;
  Rx<Color> userNameFieldColor = kColorGrey9098B1.obs;
  Rx<Color> userEmailFieldColor = kColorGrey9098B1.obs;

  RxString privacyPolicyStr = ''.obs;

  @override
  void onInit() {
    Get.lazyPut(() => AuthRepo(), fenix: true);
    super.onInit();
  }

  imagePicker(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedProfileImage.value = pickedFile;
    }
  }

  void validateUserInput() {
    mobileNumberValidation();
    userNameValidation();
    if (userNameController.text.trim().isEmpty &&
        mobileController.text.trim().isEmpty &&
        emailController.text.trim().isEmpty) {
      userNameStr.value = kErrorEUsername;
      mobileNoStr.value = kErrorEMobileNumber;
      userEmailStr.value = kErrorUserEmailId;
    }
    if (mobileController.text.trim().isNotEmpty &&
        userNameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty) {
      isUserNameValidate.value = true;
      isMobileNoValidate.value = true;
      isUserEmailValidate.value = true;
    }
    if (isUserNameValidate.value &&
        isMobileNoValidate.value &&
        isUserEmailValidate.value &&
        mobileController.text.trim().length == 10) {
      if (isPrivacyPolicySelected.value == false) {
        privacyPolicyStr.value = kErrorPleaseSelectPrivacyPolicy;
      } else {
        buyerRegAPICall();
      }
      // navigateToSellerHomeScreen();
    } else {
      mobileNumberValidation();
      userEmailValidation();
    }
  }

  bool mobileNumberValidation() {
    isMobileNoValidate.value = false;
    if (mobileController.text.trim().isEmpty) {
      mobileNoStr.value = kErrorEMobileNumber;
      isMobileNoValidate.value = false;
    } else {
      if (RegexData.mobileNumberRegex.hasMatch(mobileController.text.trim())) {
        mobileNoStr.value = '';
        isMobileNoValidate.value = true;
      } else {
        mobileNoStr.value = kErrorMobileNumber;
        isMobileNoValidate.value = false;
      }
    }
    return isMobileNoValidate.value;
  }

  bool userNameValidation() {
    isUserNameValidate.value = false;
    if (userNameController.text.trim().isEmpty) {
      userNameStr.value = kErrorUsername;
      isUserNameValidate.value = false;
    } else {
      userNameStr.value = '';
      isUserNameValidate.value = true;
    }
    return isUserNameValidate.value;
  }

  void userEmailValidation() {
    isUserEmailValidate.value = false;
    if (emailController.text.trim().isEmpty) {
      userEmailStr.value = kErrorUserEmailId;
      isUserEmailValidate.value = false;
    } else if (!RegexData.emailNumberRegex
        .hasMatch(emailController.text.trim())) {
      userEmailStr.value = kErrorUserEmailIdValid;
      isUserEmailValidate.value = false;
    } else {
      userEmailStr.value = '';
      isUserEmailValidate.value = true;
    }

    if (isUserNameValidate.value &&
        isMobileNoValidate.value &&
        isUserEmailValidate.value) {
      validateUserInput();
    }
  }

  Future<void> buyerRegAPICall() async {
    try {
      var requestModel = BuyerRegRequestModel(
        name: userNameController.text.trim(),
        mobileCode: '91',
        mobileNumber: mobileController.text.trim(),
        email: emailController.text.trim(),
      );
      var response =
          await Get.find<AuthRepo>().buyerRegApi(requestModel: requestModel);
      if (response != null) {
        Get.find<AlertMessageUtils>()
            .showSnackBar(message: response.responseMessage.toString());
        BuyerRegData decodeResponse = response.responseData!;
        print('decodeResponse ::: ${decodeResponse.otp}');
        navigateToOtpScreen(decodeResponse.otp ?? 0);
      }
    } catch (e) {
      LoggerUtils.logException('buyerRegAPICall', e);
    }
  }

  //
  // void navigateToSellerHomeScreen() {
  //   Get.toNamed(kRouteSellerBottomNavScreen);
  // }
  void navigateToOtpScreen(int otp) {
    Get.toNamed(kRouteOtpVerificationBuyerScreen,
        arguments: [mobileController.text, otp]);
  }

  void navigateToLoginScreen() {
    Get.back();
  }
}

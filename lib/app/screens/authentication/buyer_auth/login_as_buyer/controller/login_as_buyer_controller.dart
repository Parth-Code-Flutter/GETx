import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/local_storage_constants.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/utils/local_storage.dart';

import '../../../../../common/app_constants.dart';
import '../../../../../repositories/auth_repo.dart';
import '../../../../../utils/alert_message_utils.dart';
import '../../../../../utils/logger_utils.dart';
import '../../../../../utils/regex_data.dart';
import '../model/request/buyer_login_req_model.dart';
import '../model/response/buyer_login_response_model.dart';

class LoginAsBuyerController extends GetxController {
  TextEditingController mobileNumberController = TextEditingController();

  RxBool isValidMobileNumber = true.obs;
  RxString errorMobileStr = ''.obs;

  Rx<Color> mobileFieldColor = kColorGrey9098B1.obs;

  @override
  void onInit() {
    Get.lazyPut(() => AuthRepo(), fenix: true);
    super.onInit();
  }

  void checkValidation() {
    if (isValidMobileNumber.value &&
        mobileNumberController.text.trim().isNotEmpty  &&  mobileNumberController.text.trim().length == 10) {
      buyerLoginAPICall();
      //navigateToOtpScreen();
    } else {
      mobileNumberValidation();
    }
  }

  mobileNumberValidation() {
    isValidMobileNumber.value = false;
    if (mobileNumberController.text.isEmpty) {
      errorMobileStr.value = kErrorEMobileNumber;
      isValidMobileNumber.value = false;
    }else if (!RegexData.mobileNumberRegex
        .hasMatch(mobileNumberController.text.trim()) ||
        mobileNumberController.text.trim().length < 10) {
      errorMobileStr.value = kErrorMobileNumber;
      isValidMobileNumber.value = false;

    }
    else if (RegexData.mobileNumberRegex
        .hasMatch(mobileNumberController.text.trim())) {
      errorMobileStr.value = '';
      isValidMobileNumber.value = true;
      buyerLoginAPICall();
     // navigateToOtpScreen();
    }  else {
      errorMobileStr.value = kRequired;
      isValidMobileNumber.value = false;
    }
    return false;
  }
  Future<void> buyerLoginAPICall() async {
    try {
      var requestModel = BuyerLoginRequestModel(
        mobileCode: '91',
        mobileNumber: mobileNumberController.text.trim(),
        role: kSelectedRoleAsBuyer,
      );
      var response =
      await Get.find<AuthRepo>().buyerLoginApi(requestModel: requestModel);
      if(response!=null){
        Get.find<AlertMessageUtils>().showSnackBar(message: response.responseMessage.toString());
        ResponseData decodeResponse = response.responseData!;
        print('decodeResponse ::: ${decodeResponse.otp}');

        navigateToOtpScreen(decodeResponse.otp ?? 0);
      }
    } catch (e) {
      LoggerUtils.logException('buyerLoginAPICall', e);
    }
  }
  void navigateToOtpScreen(int otp) {
    Get.find<LocalStorage>().writeBoolToStorage(kStorageIsLoggedIn, true);
    Get.find<LocalStorage>()
        .writeStringToStorage(kStorageSelectedRole, kSelectedRoleAsBuyer);

    Get.toNamed(kRouteOtpVerificationBuyerScreen,
        arguments: [mobileNumberController.text,otp]);
  }

  void navigateToRegistrationScreen() {
    Get.toNamed(kRouteRegistrationAsBuyerScreen);
  }
}

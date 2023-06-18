import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/local_storage_constants.dart';
import 'package:tsofie/app/common/model/user_pref_data.dart';
import 'package:tsofie/app/common/routing_constants.dart';

import '../../../../../common/app_constants.dart';
import '../../../../../repositories/auth_repo.dart';
import '../../../../../utils/alert_message_utils.dart';
import '../../../../../utils/local_storage.dart';
import '../../../../../utils/logger_utils.dart';
import '../../../seller_auth/otp_seller/model/request/s_otp_verification_request_model.dart';

class OtpVerificationControllerBuyer extends GetxController {
  TextEditingController otpController = TextEditingController();
  RxString otpText = ''.obs;
  RxString mobileNo = ''.obs;
  RxString otp = ''.obs;

  //RxString resendOtp=''.obs;
  RxBool isOtpEntered = false.obs;

  @override
  void onInit() {
    Get.lazyPut(() => AuthRepo(), fenix: true);
    super.onInit();
  }

  void setIntData(dynamic intentData) {
    mobileNo.value = intentData[0];
    int iOtp = intentData[1];
    otp.value = iOtp.toString();
    otpController.text = otp.value;
    isOtpEntered.value = true;
  }

  void validatedUserInput() {
    if (isOtpEntered.value == false) {
      Get.find<AlertMessageUtils>().showSnackBar(message: kErrorPleaseEnterOTP);
    } else {
      bOTPAPICall();
      //navigateToBuyerHomeScreen();
    }
  }

  Future<void> bOTPAPICall() async {
    try {
      var requestModel = SellerOTPRequestModel(
          mobileCode: '91',
          mobileNumber: mobileNo.value,
          role: kSelectedRoleAsBuyer,
          otp: otp.value);
      var response = await Get.find<AuthRepo>()
          .bOtpVerificationApi(requestModel: requestModel);
      if (response != null) {
        Get.find<AlertMessageUtils>()
            .showSnackBar(message: response.responseMessage.toString());
        Get.find<LocalStorage>().writeStringToStorage(
            kStorageToken, response.responseData?.token ?? '');
        // Get.find<LocalStorage>().writeStringToStorage(
        //     kStorageName, response.responseData?.name ?? '');
        // Get.find<LocalStorage>().writeStringToStorage(
        //     kStorageMobileNumber, response.responseData?.mobileNumber ?? '');

        /// store user data into sharedPref
        String userData = jsonEncode(response.responseData);
        // Get.find<LocalStorage>()
        //     .writeStringToStorage(kStorageUserData, userData);

        navigateToBuyerHomeScreen();
      }
    } catch (e) {
      LoggerUtils.logException('BuyerAPICall', e);
    }
  }

  Future<void> bResendOTPAPICall() async {
    otpController.text = '';
    try {
      var requestModel = SellerOTPRequestModel(
        mobileCode: '91',
        mobileNumber: mobileNo.value,
        role: kSelectedRoleAsBuyer,
      );
      var response =
          await Get.find<AuthRepo>().bResendOTPapi(requestModel: requestModel);
      if (response != null) {
        Get.find<AlertMessageUtils>()
            .showSnackBar(message: response.responseMessage.toString());
        otpController.text = response.responseData?.otp.toString() ?? '';
        otp.value = response.responseData?.otp.toString() ?? '';
        // navigateToBuyerHomeScreen();
      }
    } catch (e) {
      LoggerUtils.logException('BuyerResendOtpAPICall', e);
    }
  }

  void navigateToBuyerHomeScreen() {
    Get.offAllNamed(kRouteBuyerBottomNavScreen);
  }
}

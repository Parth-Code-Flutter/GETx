import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/screens/authentication/seller_auth/otp_seller/model/request/s_otp_verification_request_model.dart';

import '../../../../../common/app_constants.dart';
import '../../../../../common/local_storage_constants.dart';
import '../../../../../common/routing_constants.dart';
import '../../../../../repositories/auth_repo.dart';
import '../../../../../utils/alert_message_utils.dart';
import '../../../../../utils/local_storage.dart';
import '../../../../../utils/logger_utils.dart';
import '../model/response/s_otp_verification_response_model.dart';

class OtpVerificationSellerController extends GetxController {
  TextEditingController otpController = TextEditingController();
  RxString otpText = ''.obs;
  RxBool isOtpEntered = false.obs;
  RxString mobileNo = ''.obs;
  RxString otp = ''.obs;

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
      isOtpEntered.value = true;
      sellerOTPAPICall();
      // navigateToSellerHomeScreen();
    }
  }

  Future<void> sellerOTPAPICall() async {
    try {
      var requestModel = SellerOTPRequestModel(
          mobileCode: '91',
          mobileNumber: mobileNo.value,
          role: kSelectedRoleAsSeller,
          otp: otp.value);
      var response = await Get.find<AuthRepo>()
          .sOtpVerificationApi(requestModel: requestModel);
      if (response != null) {
        Get.find<AlertMessageUtils>()
            .showSnackBar(message: response.responseMessage.toString());
        // Get.find<LocalStorage>().writeStringToStorage(
        //     kStorageToken, response.responseData?.token ?? '');
        // Get.find<LocalStorage>().writeStringToStorage(
        //     kStorageName, response.responseData?.name ?? '');
        // Get.find<LocalStorage>().writeStringToStorage(
        //     kStorageMobileNumber, response.responseData?.mobileNumber ?? '');
        // Get.find<LocalStorage>().writeStringToStorage(
        //     kStorageMobileNumber, response.responseData?.companyName ?? '');
        // Get.find<LocalStorage>().writeStringToStorage(
        //     kStorageMobileNumber, response.responseData?.gstNumber ?? '');
        // Get.find<AlertMessageUtils>().showSnackBar(message: response.responseMessage.toString());
        // Get.find<LocalStorage>()
        //     .writeStringToStorage(kStorageName, response.responseData?.name??'');
        // Get.find<LocalStorage>()
        //     .writeStringToStorage(kStorageMobileNumber,response.responseData?.mobileNumber??'' );
        Get.find<LocalStorage>().writeStringToStorage(
            kStorageToken, response.responseData?.token ?? '');
        if (response.responseData?.isProfileUpdated == false) {
          navigateToSellerProfileScreen();
        } else {
          navigateToSellerHomeScreen();
        }
        //  navigateToSellerProfileScreen();
      }
    } catch (e) {
      LoggerUtils.logException('sellerOTPAPICall', e);
    }
  }

  Future<void> sResendOTPAPICall() async {
    otpController.text = '';
    try {
      var requestModel = SellerOTPRequestModel(
        mobileCode: '91',
        mobileNumber: mobileNo.value,
        role: kSelectedRoleAsSeller,
      );
      var response =
          await Get.find<AuthRepo>().sResendOtpApi(requestModel: requestModel);
      if (response != null) {
        Get.find<AlertMessageUtils>()
            .showSnackBar(message: response.responseMessage.toString());
        otpController.text = response.responseData?.otp.toString() ?? '';
        otp.value = response.responseData?.otp.toString() ?? '';
      }
    } catch (e) {
      LoggerUtils.logException('sellerResendAPICall', e);
    }
  }

  void navigateToSellerProfileScreen() {
    Get.offAllNamed(kRouteSEditProfileScreen, arguments: true);
  }

  void navigateToSellerHomeScreen() {;
    Get.find<LocalStorage>().writeBoolToStorage(kStorageIsLoggedIn, true);
    Get.find<LocalStorage>()
        .writeStringToStorage(kStorageSelectedRole, kSelectedRoleAsSeller);
    Get.offAllNamed(kRouteSellerBottomNavScreen);
  }
}

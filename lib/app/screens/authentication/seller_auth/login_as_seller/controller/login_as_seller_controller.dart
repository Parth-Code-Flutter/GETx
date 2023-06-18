import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/screens/authentication/seller_auth/login_as_seller/model/request/seller_login_req_model.dart';
import 'package:tsofie/app/screens/authentication/seller_auth/login_as_seller/model/response/seller_login_response_model.dart';
import 'package:tsofie/app/utils/regex_data.dart';

import '../../../../../common/local_storage_constants.dart';
import '../../../../../repositories/auth_repo.dart';
import '../../../../../utils/alert_message_utils.dart';
import '../../../../../utils/local_storage.dart';
import '../../../../../utils/logger_utils.dart';

class LoginAsSellerController extends GetxController {
  TextEditingController mobileNumberController = TextEditingController();

  RxBool isValidMobileNumber = true.obs;
  RxString errorMobileStr = ''.obs;

  @override
  void onInit() {
    Get.lazyPut(() => AuthRepo(), fenix: true);
    super.onInit();
  }

  void checkValidation() {
    if (isValidMobileNumber.value &&
        mobileNumberController.text.trim().isNotEmpty &&  mobileNumberController.text.trim().length == 10) {
      //navigateToOtpScreen();
      sellerLoginAPICall();
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
      sellerLoginAPICall();
      // navigateToOtpScreen();
    }  else {
      errorMobileStr.value = kErrorEMobileNumber;
      isValidMobileNumber.value = false;
    }
    return false;
  }
  // mobileNumberValidation() {
  //   if (mobileNumberController.text.isEmpty) {
  //     errorMobileStr.value = kErrorEMobileNumber;
  //     isValidMobileNumber.value = false;
  //   } else if (!RegexData.mobileNumberRegex
  //       .hasMatch(mobileNumberController.text.trim()) ||
  //       mobileNumberController.text.trim().length < 10) {
  //     errorMobileStr.value = kErrorMobileNumber;
  //     isValidMobileNumber.value = false;
  //   } else if (RegexData.mobileNumberRegex
  //       .hasMatch(mobileNumberController.text.trim())) {
  //     errorMobileStr.value = '';
  //     isValidMobileNumber.value = true;
  //     // navigateToOtpScreen();
  //     sellerLoginAPICall();
  //   } else {
  //     errorMobileStr.value = kErrorEMobileNumber;
  //     isValidMobileNumber.value = false;
  //   }
  //   return false;
  // }

  Future<void> sellerLoginAPICall() async {
    try {
      var requestModel = SellerLoginRequestModel(
        mobileCode: '91',
        mobileNumber: mobileNumberController.text.trim(),
        role: kSelectedRoleAsSeller,
      );
      var response =
          await Get.find<AuthRepo>().sellerLoginApi(requestModel: requestModel);
      if (response != null) {
        Get.find<AlertMessageUtils>().showSnackBar(message: response.responseMessage.toString());
        ResponseData decodeResponse = response.responseData!;
        print('decodeResponse ::: ${decodeResponse.otp}');
        navigateToOtpScreen(decodeResponse.otp ?? 0);
      }
    } catch (e) {
      LoggerUtils.logException('sellerLoginAPICall', e);
    }
  }

  void navigateToSellerHomeScreen() {
    Get.toNamed(kRouteOtpVerificationSellerScreen);
  }

  void navigateToOtpScreen(int otp) {
    // Get.find<LocalStorage>().writeBoolToStorage(kStorageIsLoggedIn, true);
    // Get.find<LocalStorage>()
    //     .writeStringToStorage(kStorageSelectedRole, kSelectedRoleAsSeller);
    Get.toNamed(kRouteOtpVerificationSellerScreen,
        arguments:[ mobileNumberController.text,otp]);
  }

  void navigateToRegistrationScreen() {
    Get.toNamed(kRouteRegistrationAsSellerScreen);
  }
}

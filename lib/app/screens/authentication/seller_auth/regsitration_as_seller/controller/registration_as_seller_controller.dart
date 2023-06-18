import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../common/app_constants.dart';
import '../../../../../common/local_storage_constants.dart';
import '../../../../../common/model/request/GSTnumberRequestModel.dart';
import '../../../../../common/routing_constants.dart';
import '../../../../../repositories/auth_repo.dart';
import '../../../../../utils/alert_message_utils.dart';
import '../../../../../utils/local_storage.dart';
import '../../../../../utils/logger_utils.dart';
import '../../../../../utils/regex_data.dart';
import '../model/request/seller_reg_request_model.dart';
import '../model/response/seller_reg_response_model.dart';

class RegistrationAsSellerController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  LocalStorage localStorage = Get.put(LocalStorage());

  RxBool isPrivacyPolicySelected = false.obs;

  RxBool isMobileNoValidate = false.obs;
  RxBool isUserNameValidate = false.obs;
  RxBool isCompanyNameValidate = false.obs;
  RxBool isGstNumberValidate = false.obs;

  // RxBool isGstNumberValidateAPI = false.obs;

  RxString mobileNoStr = ''.obs;
  RxString userNameStr = ''.obs;
  RxString companyNameStr = ''.obs;
  RxString gstNumberStr = ''.obs;
  RxString privacyPolicyStr = ''.obs;

  Rx<XFile> selectedProfileImage = XFile('').obs;

  @override
  void onInit() {
    privacyPolicyStr.value = '';
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
    print('isPrivacyPolicySelected ::: ${isPrivacyPolicySelected.value}');
    if (userNameValidation() == true &&
        mobileNumberValidation() == true &&
        companyNameValidation() == true &&
        gstNumberValidation() == false) {
      /// till gst api working make flag as false else true
      // gstNumberValidation() == true) {
      if (isPrivacyPolicySelected.value == false) {
        privacyPolicyStr.value = kErrorPleaseSelectPrivacyPolicy;
      } else {
        sellerRegAPICall();
      }
    } else {
      userNameValidation();
      mobileNumberValidation();
      companyNameValidation();
      gstNumberValidation();
    }
    // if (userNameController.text.trim().isEmpty && mobileController.text.trim().isEmpty &&
    //     companyNameController.text.trim().isNotEmpty && gstNumberController.text.trim().isNotEmpty
    // ) {
    //   userNameStr.value=kErrorEUsername;
    //   mobileNoStr.value = kErrorEMobileNumber;
    //   companyNameStr.value=kErrorECompanyname;
    //   gstNumberStr.value=kErrorEGstNo;
    // }
    // if ((mobileController.text.trim().isNotEmpty &&
    //     userNameController.text.trim().isNotEmpty &&companyNameController.text.trim().isNotEmpty
    //     && gstNumberController.text.trim().isNotEmpty )) {
    //   isUserNameValidate.value=true;
    //   isMobileNoValidate.value = true;
    //   isCompanyNameValidate.value=true;
    //   isGstNumberValidate.value=true;
    // }
    // if ( isUserNameValidate.value&&
    //     isMobileNoValidate.value && isCompanyNameValidate.value && isGstNumberValidate.value && mobileController.text.trim().length == 10 && gstNumberController.text.trim().length == 15) {
    //   sellerRegAPICall();
    //  // navigateToSellerHomeScreen();
    //
    // }
  }

  bool userNameValidation() {
    isUserNameValidate.value = false;
    if (userNameController.text.trim().isEmpty) {
      userNameStr.value = kErrorEUsername;
      isUserNameValidate.value = false;
    } else {
      userNameStr.value = '';
      isUserNameValidate.value = true;
    }
    return isUserNameValidate.value;
  }

  bool mobileNumberValidation() {
    isMobileNoValidate.value = false;
    if (mobileController.text.trim().isEmpty) {
      mobileNoStr.value = kErrorEMobileNumber;
      isMobileNoValidate.value = false;
    } else {
      if (RegexData.mobileNumberRegex.hasMatch(mobileController.text.trim()) &&
          mobileController.text.trim().length == 10) {
        // } else {
        //   if (RegexData.mobileNumberRegex
        //       .hasMatch(mobileController.text.trim() || mobileController.text.trim().length < 10)) {
        mobileNoStr.value = '';
        isMobileNoValidate.value = true;
      } else {
        mobileNoStr.value = kErrorMobileNumber;
        isMobileNoValidate.value = false;
      }
    }
    return isMobileNoValidate.value;
  }

  bool companyNameValidation() {
    isCompanyNameValidate.value = false;
    if (companyNameController.text.trim().isEmpty) {
      companyNameStr.value = kErrorECompanyname;
      isCompanyNameValidate.value = false;
    } else {
      companyNameStr.value = '';
      isCompanyNameValidate.value = true;
    }
    return isCompanyNameValidate.value;
  }

  bool gstNumberValidation() {
    if (isGstNumberValidate.value == false) {
      gstNumberStr.value = kErrorEGstNo;
    }

    // isGstNumberValidate.value = false;
    // if (gstNumberController.text.trim().isEmpty) {
    //   gstNumberStr.value = kErrorEGstNo;
    //   isGstNumberValidate.value = false;
    // } else if (gstNumberController.text.trim().isNotEmpty
    //   // && gstNumberController.text.trim().length == 15
    // ) {
    //   gstNumberStr.value = '';
    //   isGstNumberValidate.value = true;
    // } else {
    //   gstNumberStr.value = kErrorEGstNo;
    //   isGstNumberValidate.value = false;
    // }
    return isGstNumberValidate.value;
  }

  Future<void> sellerGstNumberAPICall() async {
    try {
      var requestModel = SellerGstNumberRequestModel(
        gst_number: gstNumberController.text.trim(),
      );
      var response =
          await Get.find<AuthRepo>().gSTNumberApi(requestModel: requestModel);
      if (response != null) {
        isGstNumberValidate.value = response.flag ?? false;
        if (response.flag == true) {
          // Get.find<AlertMessageUtils>().showSnackBar(
          //     message: 'Valid GST Number');

          // ResponseData decodeResponse = response.flag!;
          print('decodeResponse ::: ${response.responseMessage.toString()}');
        } else {
          // Get.find<AlertMessageUtils>().showSnackBar(
          //     message: 'Invalid GST Number');
          // ResponseData decodeResponse = response.flag!;
          print('decodeResponse ::: ${response.responseMessage.toString()}');
        }
      }
    } catch (e) {
      LoggerUtils.logException('sellerGstAPICall', e);
    }
  }

  Future<void> sellerRegAPICall() async {
    try {
      String fileName = selectedProfileImage.value.path.split("/").last;
      String imgExtension = fileName.split(".").last;
      var requestModel = SellerRegRequestModel(
        name: userNameController.text.trim(),
        mobileCode: '91',
        mobileNumber: mobileController.text.trim(),
        companyName: companyNameController.text.trim(),
        gstNumber: gstNumberController.text.trim(),
        //gstNumber: '18AABCU9603R1ZM',
      );
      var response = await Get.find<AuthRepo>().sellerRegApi(
        requestModel: requestModel,
        imagePath: selectedProfileImage.value.path ?? '',
        imgExtension: imgExtension,
      );
      if (response != null) {
        Get.find<AlertMessageUtils>()
            .showSnackBar(message: response.responseMessage.toString());
        ResponseData decodeResponse = response.responseData!;
        print('decodeResponse ::: ${decodeResponse.otp}');

        navigateToOtpScreen(decodeResponse.otp ?? 0);
      }
    } catch (e) {
      LoggerUtils.logException('sellerRegAPICall', e);
    }
  }

  void navigateToOtpScreen(int otp) {
    Get.toNamed(kRouteOtpVerificationSellerScreen,
        arguments: [mobileController.text, otp]);
  }

  void navigateToLoginScreen() {
    Get.back();
  }
// void navigateToSellerOtpScreen() {
//   Get.toNamed(kRouteOtpVerificationSellerScreen);
// }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/model/user_pref_data.dart';
import 'package:tsofie/app/repositories/user_repo.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/edit_profile/model/request/edit_profile_request_model.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/edit_profile/model/response/edit_profile_response_model.dart';
import 'package:tsofie/app/utils/regex_data.dart';

import '../../../../../../common/common_header.dart';
import '../../../../../../common/local_storage_constants.dart';
import '../../../../../../repositories/auth_repo.dart';
import '../../../../../../utils/alert_message_utils.dart';
import '../../../../../../utils/local_storage.dart';
import '../../../../../../utils/logger_utils.dart';

class BEditProfileController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? getToken;
  String? getName;
  String? getMobileNumber;

  RxBool isSelected = false.obs;
  RxBool isMobileNoValidate = false.obs;
  RxBool isUserNameValidate = false.obs;
  RxBool isUserEmailValidate = false.obs;

  RxString mobileNoStr = ''.obs;
  RxString userNameStr = ''.obs;
  RxString userEmailStr = ''.obs;

  Rx<XFile> selectedProfileImage = XFile('').obs;
  Rx<UserPrefData> userPrefData = UserPrefData().obs;

  @override
  Future<void> onInit() async {
    Get.lazyPut(() => AuthRepo(), fenix: true);
    Get.lazyPut(() => UserRepository(), fenix: true);
    // getToken = await localStorage.getStringFromStorage(kStorageToken);
    // getName = await localStorage.getStringFromStorage(kStorageName);
    // getMobileNumber =
    //     await localStorage.getStringFromStorage(kStorageMobileNumber);
    //
    // userNameController.text = getName.toString();
    // mobileController.text = getMobileNumber.toString();
    var userData =
        await Get.find<LocalStorage>().getStringFromStorage(kStorageUserData);
    Map decodedData = jsonDecode(userData);
    userPrefData.value =
        UserPrefData.fromJson(decodedData as Map<String, dynamic>);

    userNameController.text = userPrefData.value.userName ?? '';
    mobileController.text = userPrefData.value.mobileNumber ?? '';
    emailController.text  = userPrefData.value.email??'';
    // String getToken= await localStorage.getStringFromStorage(kStorageToken);
    super.onInit();
  }

  imagePicker(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        selectedProfileImage.value = pickedFile;
      }
    } catch (e) {
      LoggerUtils.logException('imagePicker', e);
    }
  }

  void validateUserInput() {

    if(isUserNameValidate.value && isUserEmailValidate.value && isMobileNoValidate.value){
      editProfileAPICall();
    }else{
      mobileNumberValidation();
      userNameValidation();
      userEmailValidation();
    }
/*    mobileNumberValidation();
    userNameValidation();
    userEmailValidation();
    if (userNameController.text.trim().isEmpty &&
        mobileController.text.trim().isEmpty &&
        emailController.text.trim().isEmpty) {
      userNameStr.value = kRequired;
      mobileNoStr.value = kRequired;
      userEmailStr.value = kRequired;
    }
    if (mobileController.text.trim().isNotEmpty &&
        userNameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty) {
      isUserNameValidate.value = true;
      isMobileNoValidate.value = true;
      isUserEmailValidate.value = true;
      editProfileAPICall();
    }
    if (isUserNameValidate.value && isMobileNoValidate.value) {
      // Get.back();
    }*/
  }

  bool mobileNumberValidation() {
    isMobileNoValidate.value = false;
    if (mobileController.text.trim().isEmpty) {
      mobileNoStr.value = kRequired;
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
      userNameStr.value = kRequired;
      isUserNameValidate.value = false;
    }else{
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

  // Future<int> callUpdateProfilePicApi() async {
  //   try {
  //     String fileName = selectedProfileImage.value.path.split("/").last;
  //     String imgExtension = fileName.split(".").last;
  //
  //     var domainUrl = ApiConstants.baseUrl;
  //     var url = Uri.parse(
  //         '$domainUrl${ApiConstants.userProfile}/$userId${ApiConstants.userProfilePic}');
  //
  //     var request = http.MultipartRequest('PUT', url);
  //     request.files.add(await http.MultipartFile.fromPath(
  //         'Image', userProfileLogo.value.path,
  //         contentType: MediaType('image', imgExtension)));
  //     var res = await request.send();
  //     print('status code ::: ${res.statusCode}');
  //     return res.statusCode;
  //   } catch (e) {
  //     LoggerUtils.logException('callUpdateProfilePicApi', e);
  //   }
  //   return  0;
  // }

  Future<void> editProfileAPICall() async {
    try {
    String fileName = selectedProfileImage.value.path.split("/").last;
    String imgExtension = fileName.split(".").last;
    var requestModel = EditProfileRequestModel(
      name: userNameController.text.trim(),
      mobileCode: '91',
      mobileNumber: mobileController.text.trim(),
      email: emailController.text.trim(),
      // profilePic: selectedProfileImage.value.path ?? '',
    );
    // var response = await Get.find<AuthRepo>()
    //     .editProfileBuyerApi(requestModel: requestModel);
    var response =
        await Get.find<UserRepository>().editUserProfileWithMultiPart(
      requestModel: requestModel,
      imagePath: selectedProfileImage.value.path ?? '',
      imgExtension: imgExtension,
    );
    if (response != null) {
      /// store user data into sharedPref
      String userData = jsonEncode(response.responseData);
      Get.find<LocalStorage>().writeStringToStorage(kStorageUserData, userData);
      Get.back(result: true);
      Get.back(result: true);
    }
    // if (response != null && response.responseCode == 200) {
    //   Get.find<AlertMessageUtils>()
    //       .showSnackBar(message: response.responseMessage.toString());
    //   EditProfileResponseData decodeResponse = response.responseData!;
    //   Get.find<LocalStorage>()
    //       .writeStringToStorage(kStorageToken, decodeResponse.token ?? '');
    //   Get.find<LocalStorage>()
    //       .writeStringToStorage(kStorageName, decodeResponse.name ?? '');
    //   Get.find<LocalStorage>().writeStringToStorage(
    //       kStorageMobileNumber, decodeResponse.mobileNumber ?? '');
    //   print('decodeResponse ::: ${decodeResponse.otp}');
    //   // navigateToOtpScreen(decodeResponse.otp ?? 0);
    // }
    } catch (e) {
      LoggerUtils.logException('EditProfileAPICall', e);
    }
  }
}

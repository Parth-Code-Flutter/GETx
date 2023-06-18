import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/model/response/city_response_model.dart';
import 'package:tsofie/app/common/model/response/state_response_model.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/utils/regex_data.dart';

import '../../../../../../common/local_storage_constants.dart';
import '../../../../../../common/model/user_pref_data.dart';
import '../../../../../../repositories/user_repo.dart';
import '../../../../../../utils/local_storage.dart';
import '../../../../../../utils/logger_utils.dart';
import '../../../../../buyer/dashboard/more/edit_profile/model/request/edit_profile_request_model.dart';
import '../../get_profile_seller/response/get_profile_response_model.dart';

class SEditProfileController extends GetxController {
  RxList<StateData> stateList = List<StateData>.empty(growable: true).obs;
  RxList<CityData> cityList = List<CityData>.empty(growable: true).obs;

  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController officeNumberController = TextEditingController();
  TextEditingController cellNumberController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();

  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController iFSCnoController = TextEditingController();

  RxBool isSelected = false.obs;

  Rx<StateData> selectedState = StateData().obs;
  Rx<CityData> selectedCity = CityData().obs;
  RxBool isStateSelected = false.obs;
  RxBool isCitySelected = false.obs;

  /// validations variables
  RxBool isCompanyNameValidate = false.obs;
  RxBool isCompanyAddressValidate = false.obs;
  RxBool isCityValidate = false.obs;
  RxBool isStateValidate = false.obs;
  RxBool isPinCodeValidate = false.obs;
  RxBool isContactPersonValidate = false.obs;
  RxBool isOfficeNoValidate = false.obs;
  RxBool isCellNoValidate = false.obs;
  RxBool isEmailIdValidate = false.obs;

  RxBool isAccountNoValidate = false.obs;
  RxBool isBankNameValidate = false.obs;
  RxBool isIFSCNoValidate = false.obs;

  RxString mobileNoStr = ''.obs;
  RxString userNameStr = ''.obs;
  RxString companyNameStr = ''.obs;
  RxString companyAddressStr = ''.obs;
  RxString cityStr = ''.obs;
  RxString stateStr = ''.obs;
  RxString pinCodeStr = ''.obs;
  RxString contactPersonStr = ''.obs;
  RxString officeNoStr = ''.obs;
  RxString cellNoStr = ''.obs;
  RxString emailIdStr = ''.obs;

  RxString accountNoStr = ''.obs;
  RxString bankNameStr = ''.obs;
  RxString ifscNoStr = ''.obs;

  Rx<XFile> selectedProfileImage = XFile('').obs;
  Rx<UserPrefData> userPrefData = UserPrefData().obs;

  Rx<GetProfileResponseData> getProfileData = GetProfileResponseData().obs;
  RxList<GetProfileResponseData> getProfileDataList =
      List<GetProfileResponseData>.empty(growable: true).obs;

  String? getUserName;
  String? getMobileNumber;

  RxBool isFromOtpScreen = false.obs;

  @override
  Future<void> onInit() async {
    Get.lazyPut(() => UserRepository(), fenix: true);
    super.onInit();
  }

  Future<void> setIntentData({required dynamic intentData}) async {
    try {
      isFromOtpScreen.value = (intentData as bool);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        cityList.add(
          CityData(cityName: kHintSelectCity),
        );
        selectedCity.value = cityList[0];
        if (isFromOtpScreen.value) {
          await getProfileFromServer();
        } else {
          getDataFromLocalStorage();
        }
        await getStateDataFromServer();
      });
    } catch (e) {
      LoggerUtils.logException('setIntentData', e);
    }
  }

  getStateDataFromServer() async {
    try {
      var response = await Get.find<UserRepository>()
          .getStateDataApi(countryCode: AppConstants.countryCode);
      if (response != null && response.responseData != null) {
        stateList.addAll(response.responseData?.states ?? []);
        if (stateList.isNotEmpty) {
          stateList.insert(
            0,
            StateData(stateCode: '0', stateName: kHintSelectState),
          );
          if (selectedState.value.stateName == kHintSelectState ||
              selectedState.value.stateName == '' ||
              selectedState.value.stateName == null) {
            selectedState.value = stateList[0];
          }
          int i = stateList.indexWhere(
              (element) => element.stateName == selectedState.value.stateName);
          if (i != -1) {
            selectedState.value = stateList[i];
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('getStateDataFromServer', e);
    }
  }

  Future<void> getCityDataFromServer() async {
    try {
      cityList.clear();
      var response = await Get.find<UserRepository>().getCityDataApi(
          countryCode: AppConstants.countryCode,
          stateCode: selectedState.value.stateCode ?? '');
      if (response != null && response.responseData != null) {
        cityList.addAll(response.responseData?.cities ?? []);

        isCitySelected.value = false;
        // if (cityList.isNotEmpty) {
        cityList.insert(
          0,
          CityData(cityName: kHintSelectCity),
        );
        selectedCity.value = cityList[0];
        // }
      }
    } catch (e) {
      LoggerUtils.logException('getCityDataFromServer', e);
    }
  }

  getDataFromLocalStorage() async {
    // try {
      accountNumberController.text =
          await Get.find<LocalStorage>().getStringFromStorage(kStorageAccount);
      bankNameController.text =
          await Get.find<LocalStorage>().getStringFromStorage(kStorageBank);
      iFSCnoController.text =
          await Get.find<LocalStorage>().getStringFromStorage(kStorageifsc);

      var userData =
          await Get.find<LocalStorage>().getStringFromStorage(kStorageUserData);
      print('userData ::: $userData');
      Map decodedData = jsonDecode(userData);
      userPrefData.value =
          UserPrefData.fromJson(decodedData as Map<String, dynamic>);
      // getUserName = userPrefData.value.userName ?? '';
      getMobileNumber = userPrefData.value.mobileNumber ?? '';
      companyNameController.text = userPrefData.value.companyName ?? '';
      gstController.text = userPrefData.value.gstNumber ?? '';
      companyAddressController.text = userPrefData.value.companyAddress ?? '';
      cityController.text = userPrefData.value.city ?? '';
      stateController.text = userPrefData.value.state ?? '';
      pinCodeController.text = userPrefData.value.zipCode ?? '';
      contactPersonController.text = userPrefData.value.contactPerson ?? '';
      officeNumberController.text = userPrefData.value.officeNumber ?? '';
      cellNumberController.text = userPrefData.value.cellNumber ?? '';
      emailIdController.text = userPrefData.value.email ?? '';

      // accountNumberController.text = userPrefData.value.accountNumber ?? '';
      // bankNameController.text = userPrefData.value.bankName ?? '';
      // iFSCnoController.text = userPrefData.value.ifscNumber ?? '';

      selectedCity.value.cityName = userPrefData.value.city ?? kHintSelectCity;
      selectedState.value.stateName =
          userPrefData.value.state ?? kHintSelectState;
      isStateSelected.value = true;
      isCitySelected.value = true;
    // } catch (e) {
    //   LoggerUtils.logException('getDataFromLocalStorage', e);
    // }
  }

  imagePicker(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedProfileImage.value = pickedFile;
    }
  }

  Future<void> getProfileFromServer() async {
    try {
      var response = await Get.find<UserRepository>().getProfile();
      if (response != null && response.responseData != null) {
        getProfileData.value = response.responseData!;

        // store user data into sharedPref
        // String userData = jsonEncode(response.responseData);
        //z
        // Get.find<LocalStorage>()
        //     .writeStringToStorage(kStorageUserData,userData);

        getProfileData.value = response.responseData!;
        getMobileNumber = getProfileData.value.mobileNumber ?? '';
        companyNameController.text = getProfileData.value.companyName ?? '';
        gstController.text = getProfileData.value.gstNumber ?? '';
        contactPersonController.text = getProfileData.value.name ?? '';
        userPrefData.value.userProfilePic =
            getProfileData.value.profilePic ?? '';

        // selectedCity.value.cityName =
        //     getProfileData.value.city ?? kHintSelectCity;
        // selectedState.value.stateName =
        //     getProfileData.value.state ?? kHintSelectState;
        // isStateSelected.value = true;
        // isCitySelected.value = true;

        // getProfileDataList.addAll(getProfileData.value.categories ?? []);
      }
    } catch (e) {
      LoggerUtils.logException('getProfileFromServer', e);
    }
  }

  void validateUserInput() {
    if (isCompanyNameValidate.value &&
        isCompanyAddressValidate.value &&
        isPinCodeValidate.value &&
        isContactPersonValidate.value &&
        isOfficeNoValidate.value &&
        isCellNoValidate.value &&
        isEmailIdValidate.value &&
        isAccountNoValidate.value &&
        isBankNameValidate.value &&
        isIFSCNoValidate.value &&
        isCitySelected.value &&
        isStateSelected.value) {
      editProfileAPICall();
    } else {
      companyNameValidation();
      companyAddressValidation();
      pinCodeValidation();
      contactPersonValidation();
      officeNumberValidation();
      cellNumberValidation();
      emailIdValidation();
      cityAndStateValidation();
      accountNumberValidation();
      bankNameValidation();
      ifscValidation();
    }
  }

  companyNameValidation() {
    isCompanyNameValidate.value = false;
    if (companyNameController.text.trim().isEmpty) {
      companyNameStr.value = kErrorCompanyName;
      isCompanyNameValidate.value = false;
    } else {
      companyNameStr.value = '';
      isCompanyNameValidate.value = true;
    }
  }

  companyAddressValidation() {
    isCompanyAddressValidate.value = false;
    if (companyAddressController.text.trim().isEmpty) {
      companyAddressStr.value = kErrorCompanyName;
      isCompanyAddressValidate.value = false;
    } else {
      companyAddressStr.value = '';
      isCompanyAddressValidate.value = true;
    }
  }

  pinCodeValidation() {
    isPinCodeValidate.value = false;
    if (pinCodeController.text.trim().isEmpty) {
      pinCodeStr.value = kErrorPinCode;
      isPinCodeValidate.value = false;
    } else {
      pinCodeStr.value = '';
      isPinCodeValidate.value = true;
    }
  }

  contactPersonValidation() {
    isContactPersonValidate.value = false;
    if (contactPersonController.text.trim().isEmpty) {
      contactPersonStr.value = kErrorContactPerson;
      isContactPersonValidate.value = false;
    } else {
      contactPersonStr.value = '';
      isContactPersonValidate.value = true;
    }
  }

  void officeNumberValidation() {
    isOfficeNoValidate.value = false;
    if (officeNumberController.text.trim().isEmpty) {
      officeNoStr.value = kErrorOfficeNumber;
      isOfficeNoValidate.value = false;
    } else {
      if (RegexData.mobileNumberRegex
          .hasMatch(officeNumberController.text.trim())) {
        officeNoStr.value = '';
        isOfficeNoValidate.value = true;
      } else {
        officeNoStr.value = kErrorMobileNumber;
        isOfficeNoValidate.value = false;
      }
    }
  }

  void cellNumberValidation() {
    isCellNoValidate.value = false;
    if (cellNumberController.text.trim().isEmpty) {
      cellNoStr.value = kErrorCellNumber;
      isCellNoValidate.value = false;
    } else {
      if (RegexData.mobileNumberRegex
          .hasMatch(cellNumberController.text.trim())) {
        cellNoStr.value = '';
        isCellNoValidate.value = true;
      } else {
        cellNoStr.value = kErrorMobileNumber;
        isCellNoValidate.value = false;
      }
    }
  }
  void emailIdValidation() {
    isEmailIdValidate.value = false;
    if (emailIdController.text
        .trim()
        .isEmpty) {
      emailIdStr.value = kErrorUserEmailId;
      isEmailIdValidate.value = false;
    } else if (!RegexData.emailNumberRegex
        .hasMatch(emailIdController.text.trim())) {
      emailIdStr.value = kErrorUserEmailIdValid;
      isEmailIdValidate.value = false;
    } else {
      emailIdStr.value = '';
      isEmailIdValidate.value = true;
    }
  }
  // emailIdValidation() {
  //   isEmailIdValidate.value = false;
  //   if (emailIdController.text.trim().isEmpty) {
  //     emailIdStr.value = kErrorEmailId;
  //     isEmailIdValidate.value = false;
  //   } else {
  //     emailIdStr.value = '';
  //     isEmailIdValidate.value = true;
  //   }
  // }

  cityAndStateValidation() {
    isStateSelected.value = false;
    isCitySelected.value = false;
    if (selectedState.value.stateName == kHintSelectState) {
      stateStr.value = kErrorState;
      isStateSelected.value = false;
    } else {
      stateStr.value = '';
      isStateSelected.value = true;
    }
    if (selectedCity.value.cityName == kHintSelectCity) {
      cityStr.value = kErrorCity;
      isCitySelected.value = false;
    } else {
      cityStr.value = '';
      isCitySelected.value = true;
    }
  }

  accountNumberValidation() {
    isAccountNoValidate.value = false;
    if (accountNumberController.text.trim().isEmpty) {
      accountNoStr.value = kErrorAccountNo;
      isAccountNoValidate.value = false;
    } else {
      accountNoStr.value = '';
      isAccountNoValidate.value = true;
    }
  }

  bankNameValidation() {
    isBankNameValidate.value = false;
    if (bankNameController.text.trim().isEmpty) {
      bankNameStr.value = kErrorBankName;
      isBankNameValidate.value = false;
    } else {
      bankNameStr.value = '';
      isBankNameValidate.value = true;
    }
  }

  ifscValidation() {
    isIFSCNoValidate.value = false;
    if (iFSCnoController.text.trim().isEmpty) {
      ifscNoStr.value = kErrorIFSCNo;
      isIFSCNoValidate.value = false;
    } else {
      ifscNoStr.value = '';
      isIFSCNoValidate.value = true;
    }
    if (isCompanyNameValidate.value &&
        isCompanyAddressValidate.value &&
        isPinCodeValidate.value &&
        isContactPersonValidate.value &&
        isOfficeNoValidate.value &&
        isCellNoValidate.value &&
        isEmailIdValidate.value &&
        isAccountNoValidate.value &&
        isBankNameValidate.value &&
        isIFSCNoValidate.value &&
        isCitySelected.value &&
        isStateSelected.value) {
      validateUserInput();
    }
  }

  Future<void> editProfileAPICall() async {
    // try {
    String fileName = selectedProfileImage.value.path.split("/").last;
    String imgExtension = fileName.split(".").last;

    var requestModel = EditProfileRequestModel(
      mobileCode: '91',
      // mobileNumber: getProfileData.value.mobileNumber ?? '',
      mobileNumber: getMobileNumber,
      // name: getUserName,
      // id: null,
      name: contactPersonController.text.trim(),
      companyName: companyNameController.text.trim() ?? '',
      gstNumber: gstController.text.trim(),
      companyAddress: companyAddressController.text.trim(),
      city: selectedCity.value.cityName ?? kHintSelectCity,
      state: selectedState.value.stateName ?? kHintSelectState,
      // city: cityController.text.trim(),
      // state: stateController.text.trim(),
      zipCode: pinCodeController.text.trim(),
      contactPerson: contactPersonController.text.trim(),
      officeNumber: officeNumberController.text.trim(),
      cellNumber: cellNumberController.text.trim(),
      email: emailIdController.text.trim(),
      accountNumber: accountNumberController.text.trim(),
      bankName: bankNameController.text.trim(),
      ifscNumber: iFSCnoController.text.trim(),
      //token: getToken,
      //profilePic: selectedProfileImage.value.path ?? '',
    );

    var response = await Get.find<UserRepository>()
        .editUserProfileWithMultiPart(
            requestModel: requestModel,
            imagePath: selectedProfileImage.value.path ?? '',
            imgExtension: imgExtension,
            isBuyerProfileUpdate: false);
    if (response != null) {
      /// store user data into sharedPref
      String userData = jsonEncode(response.responseData);
      Get.find<LocalStorage>().writeStringToStorage(kStorageUserData, userData);
      Get.find<LocalStorage>().writeStringToStorage(kStorageAccount,
          response.responseData?.bankDetailsData?.bankNumber ?? '');
      Get.find<LocalStorage>().writeStringToStorage(
          kStorageBank, response.responseData?.bankDetailsData?.bankName ?? '');
      Get.find<LocalStorage>().writeStringToStorage(kStorageifsc,
          response.responseData?.bankDetailsData?.ifscNumber ?? '');
      if (isFromOtpScreen.value) {
        Get.find<LocalStorage>().writeBoolToStorage(kStorageIsLoggedIn, true);
        Get.find<LocalStorage>()
            .writeStringToStorage(kStorageSelectedRole, kSelectedRoleAsSeller);
        Get.offAllNamed(kRouteSellerBottomNavScreen);
      } else {
        Get.back(result: true);
        Get.back(result: true);
      }
      // Get.back();
      // Get.back();
    }
    // } catch (e) {
    //   LoggerUtils.logException('EditProfileSellerAPICall', e);
    // }
  }
// void validateUserInput() {
//   mobileNumberValidation();
//   userNameValidation();
//   if (userNameController.text.trim().isEmpty && mobileController.text.trim().isEmpty
//   ) {
//     userNameStr.value=kRequired;
//     mobileNoStr.value = kRequired;
//   }
//   if ((mobileController.text.trim().isNotEmpty &&
//       userNameController.text.trim().isNotEmpty)) {
//     isUserNameValidate.value=true;
//     isMobileNoValidate.value = true;
//   }
//   if ( isUserNameValidate.value&&
//       isMobileNoValidate.value) {
//  Get.back();
//
//   }
// }
// bool mobileNumberValidation() {
//   isMobileNoValidate.value = false;
//   if (cellNumberController.text.trim().isEmpty) {
//     mobileNoStr.value = kRequired;
//     isMobileNoValidate.value = false;
//   } else {
//     if (RegexData.mobileNumberRegex
//         .hasMatch(cellNumberController.text.trim())) {
//       mobileNoStr.value = '';
//       isMobileNoValidate.value = true;
//     } else {
//       mobileNoStr.value = kErrorMobileNumber;
//       isMobileNoValidate.value = false;
//     }
//   }
//   return isMobileNoValidate.value;
// }
// bool userNameValidation(){
//   isUserNameValidate.value = false;
//   if (userNameController.text.trim().isEmpty) {
//     userNameStr.value = kRequired;
//     isUserNameValidate.value = false;
//   }
//   return isUserNameValidate.value;
// }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/auth_repo.dart';
import 'package:tsofie/app/repositories/user_repo.dart';
import 'package:tsofie/app/screens/buyer/bottom_nav_screens/controller/bottom_nav_controller.dart';
import 'package:tsofie/app/screens/seller/dashboard/more/get_profile_seller/response/get_profile_response_model.dart';
import 'package:tsofie/app/utils/local_storage.dart';

import '../../../../../../common/color_constants.dart';
import '../../../../../../common/local_storage_constants.dart';
import '../../../../../../common/model/user_pref_data.dart';
import '../../../../../../utils/logger_utils.dart';
import '../../../../../../utils/text_styles.dart';

class SMoreBaseController extends GetxController {

  RxBool isEngSelected = false.obs;
  RxBool isHindiSelected = false.obs;
  LocalStorage localStorage = Get.put(LocalStorage());

  // String? getToken;
  Rx<XFile> selectedProfileImage = XFile('').obs;
  RxList<SettingsData> settingsDataList =
      List<SettingsData>.empty(growable: true).obs;
  // Rx<GetProfileResponseData> getProfileData =
  //     GetProfileResponseData().obs;
  // RxList<GetProfileResponseData> getProfileDataList =
  //     List<GetProfileResponseData>.empty(growable: true).obs;
  Rx<UserPrefData> userPrefData = UserPrefData().obs;
  RxBool isDataLoading = true.obs;
  @override
  Future<void> onInit() async {
    Get.lazyPut(() => UserRepository(), fenix: true);
    addSettingsDataIntoList();
    await getUserDataFromPref();

    super.onInit();
  }

  // @override
  // Future<void> onInit() async {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     getProfileFromServer();
  //   });
  //
  //   addSettingsDataIntoList();
  //   Get.lazyPut(() => UserRepository(), fenix: true);
  //
  //   super.onInit();
  // }

  void addSettingsDataIntoList() {
    settingsDataList.add(SettingsData(kLabelEditProfile, kIconEditProfile));
    settingsDataList.add(SettingsData(kLabelViewAllCategory, kIconViewAllCat));
    settingsDataList
        .add(SettingsData(kLabelHelpAndSupport, kIconHelpAndSupport));
    settingsDataList.add(SettingsData(kLabelLanguage, kIconLanguage));
    settingsDataList.add(SettingsData(kLabelShare, kIconShare));
    settingsDataList.add(SettingsData(kLabelAboutUs, kIconAbout));
    settingsDataList.add(SettingsData(kLabelLogout, kIconLogout));
  }

  void changeLanguage(int i) {
    /// 0 = english , 1 = hindi
    if (i == 0) {
      isEngSelected.value = !isEngSelected.value;
      isHindiSelected.value = false;
    } else {
      isHindiSelected.value = !isHindiSelected.value;
      isEngSelected.value = false;
    }
  }

  imagePicker(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedProfileImage.value = pickedFile;
    }
  }

  Future<void> manageNavigation(int index) async {
    if (index == 0) {
      bool isUpdated = await Get.toNamed(kRouteSEditProfileScreen,arguments: false);
      if (isUpdated) {
       // isDataLoading.value = true;
        await getUserProfileFromServer();
        // getUserDataFromPref();
      }
      // Get.toNamed(kRouteSEditProfileScreen,arguments: false);
      // getProfileFromServer();
    } else if (index == 1) {
      Get.toNamed(kRouteSAllCategoryListing);
    }
  }
  getUserDataFromPref() async {
    try {
      var userData =
      await Get.find<LocalStorage>().getStringFromStorage(kStorageUserData);
      if (userData.isNotEmpty) {
        Map decodedData = jsonDecode(userData);
        userPrefData.value =
            UserPrefData.fromJson(decodedData as Map<String, dynamic>);
        AppConstants.userId = userPrefData.value.id??0;
      } else {
        await getUserProfileFromServer();
      }
      isDataLoading.value = false;
    } catch (e) {
      LoggerUtils.logException('getUserDataFromPref', e);
      isDataLoading.value = false;
    }
  }

  getUserProfileFromServer() async {
    try {
      var response = await Get.find<UserRepository>().getProfile();
      if (response != null && response.responseData != null) {
        /// store user data into sharedPref
        print('response.responseData :;; ${response.responseData}');
        String userData = jsonEncode(response.responseData); /// it will convert jsonResponse to String
        print('userData :;; ${userData.toString()}');
        Get.find<LocalStorage>()
            .writeStringToStorage(kStorageUserData, userData);
        Get.find<LocalStorage>().writeStringToStorage(kStorageSellerId,
            response.responseData?.sellerId.toString() ?? '');
        Get.find<LocalStorage>().writeStringToStorage(kStorageAccount,
            response.responseData?.bankDetailsData?.bankNumber ?? '');
        Get.find<LocalStorage>().writeStringToStorage(
            kStorageBank, response.responseData?.bankDetailsData?.bankName ?? '');
        Get.find<LocalStorage>().writeStringToStorage(kStorageifsc,
            response.responseData?.bankDetailsData?.ifscNumber ?? '');
        getUserDataFromPref();
      }
    } catch (e) {
      LoggerUtils.logException('getUserProfileFromServer', e);
    }
  }
  void clearAllStorageData() {
    Get.find<LocalStorage>().clearAllStorageData();
    Get.offAllNamed(kRouteSelectRoleScreen);
  }

  // Future<void> getProfileFromServer() async {
  //   try {
  //     var response =
  //     await Get.find<UserRepository>().getProfile();
  //     if (response != null && response.responseData != null) {
  //       getProfileData.value = response.responseData!;
  //       // store user data into sharedPref
  //       String userData = jsonEncode(response.responseData);
  //
  //       Get.find<LocalStorage>()
  //           .writeStringToStorage(kStorageUserData,userData);
  //
  //       // getProfileData.value = response.responseData!;
  //       // getProfileDataList.addAll(getProfileData.value.categories ?? []);
  //     }
  //   } catch (e) {
  //     LoggerUtils.logException('getProfileFromServer', e);
  //   }
  // }
}


class SettingsData {
  String name;
  String icon;

  SettingsData(this.name, this.icon);
}

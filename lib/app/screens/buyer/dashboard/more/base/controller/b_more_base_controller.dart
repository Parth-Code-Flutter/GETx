import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/common/local_storage_constants.dart';
import 'package:tsofie/app/common/model/user_pref_data.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/user_repo.dart';
import 'package:tsofie/app/screens/buyer/bottom_nav_screens/controller/bottom_nav_controller.dart';
import 'package:tsofie/app/utils/local_storage.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class BMoreBaseController extends GetxController {
  RxBool isEngSelected = false.obs;
  RxBool isHindiSelected = false.obs;

  Rx<XFile> selectedProfileImage = XFile('').obs;
  RxList<SettingsData> settingsDataList =
      List<SettingsData>.empty(growable: true).obs;
  Rx<UserPrefData> userPrefData = UserPrefData().obs;

  RxBool isDataLoading = true.obs;

  @override
  Future<void> onInit() async {
    Get.lazyPut(() => UserRepository(), fenix: true);
    addSettingsDataIntoList();
    await getUserDataFromPref();

    super.onInit();
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
      var response = await Get.find<UserRepository>().getUserProfileApi();
      if (response != null && response.responseData != null) {
        /// store user data into sharedPref
        String userData = jsonEncode(response.responseData);
        Get.find<LocalStorage>()
            .writeStringToStorage(kStorageUserData, userData);
        getUserDataFromPref();
      }
    } catch (e) {
      LoggerUtils.logException('getUserProfileFromServer', e);
    }
  }

  void addSettingsDataIntoList() {
    settingsDataList.add(SettingsData(kLabelEditProfile, kIconEditProfile));
    settingsDataList.add(SettingsData(kLabelViewAllCategory, kIconViewAllCat));
    settingsDataList.add(SettingsData(kLabelMyOrders, kIconMyOrder));
    settingsDataList.add(SettingsData(kLabelFavourite, kIconUnFavGrey));
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
      bool isUpdated = await Get.toNamed(kRouteBEditProfileScreen);
      if (isUpdated) {
        isDataLoading.value = true;
        getUserProfileFromServer();
        // getUserDataFromPref();
      }
    } else if (index == 1) {
      Get.toNamed(kRouteBAllCategoryListing);
    } else if (index == 2) {
      Get.find<BuyerBottomNavController>().index.value = 2;
    } else if (index == 3) {
      Get.toNamed(kRouteBFavScreen);
    }
  }

  void clearAllStorageData() {
    Get.find<LocalStorage>().clearAllStorageData();
    Get.offAllNamed(kRouteSelectRoleScreen);
  }
}

class SettingsData {
  String name;
  String icon;

  SettingsData(this.name, this.icon);
}

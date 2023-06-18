import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/model/response/state_response_model.dart';
import 'package:tsofie/app/repositories/location_repo.dart';
import 'package:tsofie/app/repositories/user_repo.dart';
import 'package:tsofie/app/screens/buyer/location/base/model/response/location_response_model.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class BSearchLocationController extends GetxController {
  TextEditingController searchController = TextEditingController();

  Rx<LocationResponseData> locationData = LocationResponseData().obs;

  RxList<LocationData> locationDataList =
      List<LocationData>.empty(growable: true).obs;
  RxList<LocationData> searchLocationDataList =
      List<LocationData>.empty(growable: true).obs;

  RxList<StateData> stateList = List<StateData>.empty(growable: true).obs;

  Rx<LocationData> selectedLocationData = LocationData().obs;

  RxString searchLocationText = ''.obs;

  @override
  void onInit() {
    Get.lazyPut(() => LocationRepo(), fenix: true);
    Get.lazyPut(() => UserRepository(), fenix: true);

    super.onInit();
  }

  setIntentData({required dynamic intentData}) async {
    try {
      selectedLocationData.value = intentData;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await getLocationListFromServer();
      });
    } catch (e) {
      LoggerUtils.logException('setIntentData', e);
    }
  }

  Future<void> getLocationListFromServer() async {
    try {
      var response = await Get.find<UserRepository>()
          .getStateDataApi(countryCode: AppConstants.countryCode);
      if (response != null && response.responseData != null) {
        stateList.addAll(response.responseData?.states ?? []);
        if (stateList.isNotEmpty) {
          stateList.forEach((element) {
            locationDataList.add(LocationData(state: element.stateName ?? ''));
          });
        }
      }

      /// location list api is delete. So, getting all state from state api and parsing to locationList
      // var response = await Get.find<LocationRepo>().getLocationList(page: 1);
      // if (response != null && response.responseData != null) {
      //   locationData.value = response.responseData!;
      //   locationDataList.addAll(locationData.value.locations ?? []);
      // }

      if (selectedLocationData.value.state != null &&
          (selectedLocationData.value.state ?? '').isNotEmpty) {
        int i = locationDataList.indexWhere((element) =>
            element.state == (selectedLocationData.value.state ?? ''));
        if (i != -1) {
          locationDataList[i].isDefault = true;
        }
      }
    } catch (e) {
      LoggerUtils.logException('getLocationListFromServer', e);
    }
  }

  /// navigate to back screen with selected location
  void navigateToBackScreen(int index) {
    if (searchLocationDataList.isNotEmpty) {
      selectedLocationData.value = searchLocationDataList[index];
    } else {
      selectedLocationData.value = locationDataList[index];
    }
    Get.back(result: selectedLocationData.value);
  }

  /// clear all location filer and navigate to back screen
  void clearAllLocationFilter() {
    selectedLocationData.value.state = null;
    Get.back(result: selectedLocationData.value);
  }

  /// onSearch value changes add search data into searchLocationDataList
  void onSearchValueChange() {
    try {
      searchLocationDataList.clear();
      if (searchLocationText.trim().isNotEmpty) {
        for (var element in locationDataList) {
          if ((element.state ?? '')
              .isCaseInsensitiveContainsAny(searchLocationText.value)) {
            searchLocationDataList.add(element);
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('onSearchValueChange', e);
    }
  }
}

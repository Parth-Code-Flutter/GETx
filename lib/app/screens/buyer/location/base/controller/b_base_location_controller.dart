import 'package:get/get.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/location_repo.dart';
import 'package:tsofie/app/screens/buyer/location/base/model/response/location_response_model.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class BBaseLocationController extends GetxController {
  double popupMenuItemWidth = 120;

  RxList<TempLocationData> tempLocationList =
      List<TempLocationData>.empty(growable: true).obs;

  Rx<LocationResponseData> locationData = LocationResponseData().obs;

  RxList<LocationData> locationDataList =
      List<LocationData>.empty(growable: true).obs;

  @override
  Future<void> onInit() async {
    tempLocationList.add(TempLocationData('Gujarat', 'Rajkot', false));
    tempLocationList.add(TempLocationData('Gujarat', 'Surat', false));
    tempLocationList.add(TempLocationData('Gujarat', 'Junagadh', false));
    tempLocationList.add(TempLocationData('Gujarat', 'Ahmedabad', false));
    tempLocationList.add(TempLocationData('Gujarat', 'Baroda', false));
    tempLocationList.add(TempLocationData('Gujarat', 'Kutch', false));
    tempLocationList.add(TempLocationData('Gujarat', 'Gondal', false));
    tempLocationList.add(TempLocationData('Gujarat', 'Gandhinagar', false));
    tempLocationList.add(TempLocationData('Gujarat', 'Gandhidham', false));
    Get.lazyPut(() => LocationRepo(), fenix: true);
    await getLocationListFromServer();
    super.onInit();
  }

  Future<void> getLocationListFromServer() async {
    try {
      var response = await Get.find<LocationRepo>().getLocationList(page: 1);
      if (response != null && response.responseData != null) {
        locationData.value = response.responseData!;
        locationDataList.addAll(locationData.value.locations ?? []);
      }
    } catch (e) {
      LoggerUtils.logException('getLocationListFromServer', e);
    }
  }

  void navigateToAddLocationScreen() {
    Get.toNamed(kRouteBAddLocationScreen);
  }

  void deleteLocation() {}

  void updateDefaultLocation(int index) {
    try {
      int i =
          tempLocationList.indexWhere((element) => element.isDefault == true);
      if (i != -1) {
        tempLocationList[i].isDefault = false;
      }
      tempLocationList[index].isDefault = true;
      tempLocationList.refresh();
    } catch (e) {
      LoggerUtils.logException('updateDefaultLocation', e);
    }
  }

  void navigateToSearchLocationScreen() {
    Get.toNamed(kRouteBSearchLocationScreen);
  }
}

class TempLocationData {
  String state;
  String city;
  bool isDefault;

  TempLocationData(
    this.state,
    this.city,
    this.isDefault,
  );
}

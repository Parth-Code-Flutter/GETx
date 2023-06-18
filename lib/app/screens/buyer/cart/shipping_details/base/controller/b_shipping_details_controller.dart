import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/model/response/city_response_model.dart';
import 'package:tsofie/app/common/model/response/state_response_model.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/shipping_repo.dart';
import 'package:tsofie/app/repositories/user_repo.dart';
import 'package:tsofie/app/screens/buyer/cart/shipping_details/shipping_addresses/model/request/add_shipping_address_request_model.dart';
import 'package:tsofie/app/screens/buyer/cart/shipping_details/shipping_addresses/model/response/shipping_address_response_model.dart';
import 'package:tsofie/app/utils/alert_message_utils.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class BShippingDetailsController extends GetxController {
  Rx<ShippingAddressData> previousScreenShippingData =
      ShippingAddressData().obs;

  RxList<StateData> stateList = List<StateData>.empty(growable: true).obs;
  RxList<CityData> cityList = List<CityData>.empty(growable: true).obs;

  TextEditingController pinCodeController = TextEditingController();
  TextEditingController shippingAddressController = TextEditingController();

  Rx<StateData> selectedState = StateData().obs;
  Rx<CityData> selectedCity = CityData().obs;

  RxBool isStateSelected = false.obs;
  RxBool isCitySelected = false.obs;

  RxBool isPinCodeValidate = false.obs;
  RxBool isShippingAddressValidate = false.obs;

  RxString cityStr = ''.obs;
  RxString stateStr = ''.obs;
  RxString pinCodeStr = ''.obs;
  RxString shippingAddressStr = ''.obs;

  RxBool isForEdit = false.obs;

  @override
  void onInit() {
    Get.lazyPut(() => UserRepository(), fenix: true);
    Get.lazyPut(() => ShippingRepo(), fenix: true);
    super.onInit();
  }

  void setIntentData({required dynamic intentData}) {
    try {
      isForEdit.value = (intentData[0] as bool);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        cityList.add(
          CityData(cityName: kHintSelectCity),
        );
        selectedCity.value = cityList[0];
        await getStateDataFromServer();
      });
      if (isForEdit.value) {
        previousScreenShippingData.value =
            (intentData[1] as ShippingAddressData);
        // shippingAddressController.text = previousScreenShippingData.value.streetAddress??'';
        // shippingAddressController.text = previousScreenShippingData.value.streetAddress??'';
        shippingAddressController.text =
            previousScreenShippingData.value.streetAddress ?? '';
        pinCodeController.text = previousScreenShippingData.value.pincode ?? '';
      }
    } catch (e) {
      LoggerUtils.logException('setIntentData', e);
    }
  }

  Future<void> getStateDataFromServer() async {
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
          // int i = stateList.indexWhere(
          //     (element) => element.stateName == selectedState.value.stateName);
          int i = stateList.indexWhere((element) =>
              element.stateName ==
              (previousScreenShippingData.value.state ?? ''));
          if (i != -1) {
            selectedState.value = stateList[i];
          }

          if (isForEdit.value) {
            await getCityDataFromServer();
            int i = cityList.indexWhere((element) =>
            element.cityName ==
                (previousScreenShippingData.value.city ?? ''));
            if (i != -1) {
              selectedCity.value = cityList[i];
            }
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

  void validateUserInputs() {
    if (isStateSelected.value &&
        isCitySelected.value &&
        isPinCodeValidate.value &&
        isShippingAddressValidate.value) {
      if (isForEdit.value) {
        updateShippingAddressApiCall();
      } else {
        addShippingAddressApiCall();
      }
      // Get.toNamed(kRouteBOrderSummaryScreen);
    } else {
      pinCodeValidation();
      addressValidation();
      cityAndStateValidation();
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

  addressValidation() {
    isShippingAddressValidate.value = false;
    if (shippingAddressController.text.trim().isEmpty) {
      shippingAddressStr.value = kErrorShippingAddress;
      isShippingAddressValidate.value = false;
    } else {
      shippingAddressStr.value = '';
      isShippingAddressValidate.value = true;
    }
  }

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
    if (isStateSelected.value &&
        isCitySelected.value &&
        isPinCodeValidate.value &&
        isShippingAddressValidate.value) {
      if (isForEdit.value) {
        updateShippingAddressApiCall();
      } else {
        addShippingAddressApiCall();
      }
      // Get.toNamed(kRouteBOrderSummaryScreen);
    }
  }

  /// add shipping address api call
  Future<void> addShippingAddressApiCall() async {
    try {
      var requestModel = AddShippingAddressRequestModel(
        city: selectedCity.value.cityName ?? '',
        state: selectedState.value.stateName ?? '',
        streetAddress: shippingAddressController.text.trim(),
        pincode: pinCodeController.text.trim(),
      );
      var response = await Get.find<ShippingRepo>()
          .addShippingAddressApi(requestModel: requestModel);

      if (response != null && response == true) {
        Get.back(result: true);
      }
    } catch (e) {
      LoggerUtils.logException('addShippingAddressApiCall', e);
    }
  }

  /// update shipping address api call
  Future<void> updateShippingAddressApiCall() async {
    try {
      var requestModel = AddShippingAddressRequestModel(
        city: selectedCity.value.cityName ?? '',
        state: selectedState.value.stateName ?? '',
        streetAddress: shippingAddressController.text.trim(),
        pincode: pinCodeController.text.trim(),
      );
      var response = await Get.find<ShippingRepo>().updateShippingAddressApi(
          id: previousScreenShippingData.value.id ?? 0,
          requestModel: requestModel);

      if (response != null && response == true) {
        Get.back(result: true);
      }
    } catch (e) {
      LoggerUtils.logException('addShippingAddressApiCall', e);
    }
  }
}

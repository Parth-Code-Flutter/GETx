import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/shipping_repo.dart';
import 'package:tsofie/app/screens/buyer/cart/my_cart/controller/b_my_cart_controller.dart';
import 'package:tsofie/app/screens/buyer/cart/my_cart/model/response/cart_items_response_model.dart';
import 'package:tsofie/app/screens/buyer/cart/shipping_details/shipping_addresses/model/response/shipping_address_response_model.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class BShippingAddressesController extends GetxController {
  RxList<ShippingAddressData> shippingAddressList =
      List<ShippingAddressData>.empty(growable: true).obs;
  Rx<CartResponseData> cartData = CartResponseData().obs;
  RxList<GSTData> gstDataList = List<GSTData>.empty(growable: true).obs;

  List<CartData> cartItemsList = [];

  @override
  void onInit() {
    Get.lazyPut(() => ShippingRepo(), fenix: true);

    super.onInit();
  }

  void setIntentData({required dynamic intentData}) {
    try {
      List<CartData> tempCartList = (intentData[0] as List<CartData>);
      cartItemsList.addAll(tempCartList);
      cartData.value = (intentData[1] as CartResponseData);
      gstDataList.addAll(intentData[2] as List<GSTData>);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await getShippingAddressFromServer();
      });
    } catch (e) {
      LoggerUtils.logException('setIntentData', e);
    }
  }

  Future<void> navigateToAddShippingDetailsScreen(
      {bool isForEditAddress = false,
      ShippingAddressData? shippingData}) async {
    bool isUpdate = await Get.toNamed(kRouteBShippingDetailsScreen,
        arguments: [isForEditAddress, shippingData]);
    if (isUpdate) {
      shippingAddressList.clear();
      await getShippingAddressFromServer();
    }
  }

  /// get shipping address list from server
  Future<void> getShippingAddressFromServer() async {
    try {
      var response = await Get.find<ShippingRepo>().getShippingAddressApi();

      if (response != null && response.responseData != null) {
        shippingAddressList.addAll(response.responseData?.addresses ?? []);
        if (shippingAddressList.isNotEmpty) {
          shippingAddressList[0].isDefault = true;
        }
      }
    } catch (e) {
      LoggerUtils.logException('getShippingAddressFromServer', e);
    }
  }

  /// update isDefault shipping address value based on selection
  void updateDefaultShippingAddress(int index) {
    int i =
        shippingAddressList.indexWhere((element) => element.isDefault == true);

    if (i != -1) {
      shippingAddressList[i].isDefault = false;
    }
    shippingAddressList[index].isDefault = true;
    shippingAddressList.refresh();
  }

  void navigateToOrderSummaryScreen() {
    int i =
        shippingAddressList.indexWhere((element) => element.isDefault == true);
    Get.toNamed(kRouteBOrderSummaryScreen,
        arguments: [shippingAddressList[i], cartItemsList, cartData.value,gstDataList]);
  }
}

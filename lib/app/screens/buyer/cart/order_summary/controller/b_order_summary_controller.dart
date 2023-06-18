import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/order_repo.dart';
import 'package:tsofie/app/screens/buyer/bottom_nav_screens/controller/bottom_nav_controller.dart';
import 'package:tsofie/app/screens/buyer/cart/my_cart/controller/b_my_cart_controller.dart';
import 'package:tsofie/app/screens/buyer/cart/my_cart/model/response/cart_items_response_model.dart';
import 'package:tsofie/app/screens/buyer/cart/order_summary/model/request/create_order_request_model.dart';
import 'package:tsofie/app/screens/buyer/cart/shipping_details/shipping_addresses/model/response/shipping_address_response_model.dart';
import 'package:tsofie/app/utils/alert_message_utils.dart';
import 'package:tsofie/app/utils/local_storage.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class BOrderSummaryController extends GetxController {
  ShippingAddressData shippingAddressData = ShippingAddressData();
  Rx<CartResponseData> cartData = CartResponseData().obs;
  RxList<CartData> cartItemsList = List<CartData>.empty(growable: true).obs;
  RxList<GSTData> gstDataList = List<GSTData>.empty(growable: true).obs;

  @override
  void onInit() {
    Get.lazyPut(() => OrderRepo(), fenix: true);
    super.onInit();
  }

  void setIntentData({required dynamic intentData}) {
    try {
      shippingAddressData = (intentData[0] as ShippingAddressData);
      List<CartData> tempCartList = (intentData[1] as List<CartData>);
      cartItemsList.addAll(tempCartList);
      cartData.value = (intentData[2] as CartResponseData);
      gstDataList.addAll(intentData[3] as List<GSTData>);
      print('cartItemsList :: ${cartItemsList.length}');
    } catch (e) {
      LoggerUtils.logException('setIntentData', e);
    }
  }

  Future<void> createOrderApiCall() async {
    try {
      List<OrderProduct> orderProductList = [];

      for (var element in cartItemsList) {
        orderProductList.add(OrderProduct(
            quantity: element.quantity,
            productVariantId: element.productVariantId));
      }
      var requestModel = CreateOrderRequestModel(
        order: Order(shippingAddressId: shippingAddressData.id),
        orderProducts: orderProductList,
      );
      var response = await Get.find<OrderRepo>()
          .createOrderApi(requestModel: requestModel);

      if (response == true) {
        navigateToHomeScreen();
      }
    } catch (e) {
      LoggerUtils.logException('createOrderApiCall', e);
    }
  }

  void navigateToHomeScreen() {
    // Get.find<BuyerBottomNavController>().index.value = 0;
    // Get.offAllNamed(kRouteBuyerBottomNavScreen);

    Get.back();
    Get.back();
    Get.back();
    if(LocalStorage.isFromProductDetailsScreen == true){
      Get.back();
    }
    LocalStorage.isFromProductDetailsScreen = false;
    // Get.offAndToNamed(kRouteBuyerBottomNavScreen);
    Get.find<BuyerBottomNavController>().index.value = 2;
    Get.find<AlertMessageUtils>()
        .showToastMessages(msg: 'Order placed successfully');
    Get.find<LocalStorage>().cartCount.value= 0;
  }
}

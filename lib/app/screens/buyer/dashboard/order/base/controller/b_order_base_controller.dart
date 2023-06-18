import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/order_repo.dart';
import 'package:tsofie/app/screens/buyer/bottom_nav_screens/controller/bottom_nav_controller.dart';
import 'package:tsofie/app/screens/buyer/dashboard/order/base/model/response/orders_response_model.dart';
import 'package:tsofie/app/utils/local_storage.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class BOrderBaseController extends GetxController {
  TextEditingController orderSearchController = TextEditingController();
  RxString searchText = ''.obs;

  RxList<Order> filterOrdersList = List<Order>.empty(growable: true).obs;
  RxList<Order> originalOrdersList = List<Order>.empty(growable: true).obs;
  RxList<Order> searchOrdersList = List<Order>.empty(growable: true).obs;

  RxInt cartCount = 0.obs;

  RxBool isLatestSelected = true.obs;
  RxBool isOldestSelected = false.obs;

  @override
  Future<void> onInit() async {
    Get.lazyPut(() => OrderRepo(), fenix: true);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getOrdersFromServer();
    });

    Get.find<BuyerBottomNavController>().index.listen((p0) {
      if (p0 == 2) {
        filterOrdersList.clear();
        getOrdersFromServer();
      }
    });
    cartCount.value = Get.find<LocalStorage>().cartCount.value;
    Get.find<LocalStorage>().cartCount.listen((p0) {
      cartCount.value = p0;
    });
    super.onInit();
  }

  getOrdersFromServer() async {
    try {
      var response = await Get.find<OrderRepo>()
          .getOrdersFromServer(isLatest: isLatestSelected.value);
      if (response != null) {
        filterOrdersList.addAll(response.responseData?.orders ?? []);
        originalOrdersList.addAll(response.responseData?.orders ?? []);
      }
    } catch (e) {
      LoggerUtils.logException('getOrdersFromServer', e);
    }
  }

  void navigateToOrderDetailsScreen({required Order orderData}) {
    Get.toNamed(kRouteBOrderDetailsScreen, arguments: [orderData]);
  }

  void navigateToMyCartScreen() {
    Get.toNamed(kRouteBMyCartScreen);
  }

  /// search order by name or orderId
  void searchOrder() {
    try {
      searchOrdersList.clear();
      for (var element in filterOrdersList) {
        if ((element.productName ?? '')
                .isCaseInsensitiveContainsAny(searchText.value) ||
            (element.orderDetails?.orderId ?? 0)
                .toString()
                .contains(searchText.value)) {
          searchOrdersList.add(element);
        }
      }
    } catch (e) {
      LoggerUtils.logException('searchOrder', e);
    }
  }

  /// filters function
  void applyFilter() {
    try {
      filterOrdersList.clear();
      getOrdersFromServer();
    } catch (e) {
      LoggerUtils.logException('applyFilter', e);
    }
  }

  void resetOrderFilter() {
     isLatestSelected.value = true;
     isOldestSelected.value = false;
    filterOrdersList.clear();
    getOrdersFromServer();
  }
}

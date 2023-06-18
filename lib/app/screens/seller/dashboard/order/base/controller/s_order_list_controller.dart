import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/screens/seller/dashboard/order/model/order_list_response_model.dart';

import '../../../../../../repositories/recent_repo.dart';
import '../../../../../../utils/logger_utils.dart';
import '../../../../s_bootom_nav_screen/controller/s_bottom_nav_controller.dart';

class SOrderBaseController extends GetxController {
  TextEditingController orderSearchController = TextEditingController();
  Rx<OrderResponseData> recentOrderResponseData = OrderResponseData().obs;
  RxList<RecentOrders> recentOrderResponseDataList =
      List<RecentOrders>.empty(growable: true).obs;
  RxList<RecentOrders> searchOrdersList =
      List<RecentOrders>.empty(growable: true).obs;
  RxInt current = 0.obs;
  RxList<String> imageList = List<String>.empty(growable: true).obs;
  RxBool isDataLoading = true.obs;
  RxBool tempBool = false.obs;

  RxString searchText = ''.obs;
  RxBool isLatestSelected = true.obs;
  RxBool isOldestSelected = false.obs;

  @override
  Future<void> onInit() async {
    Get.lazyPut(() => RecentRepo(), fenix: true);
    await WidgetsFlutterBinding.ensureInitialized();
    getRecentOrderListFromServer();

    Get.find<SellerBottomNavController>().index.listen((p2) {
      if (p2 == 2) {
        isDataLoading.value = true;
        recentOrderResponseDataList.clear();
        getRecentOrderListFromServer();
      }
    });
    super.onInit();
  }

  Future<void> navigateToOrderDetailsScreen(int index) async {
    await Get.toNamed(kRouteSOrderDetailsScreen,
        arguments: [recentOrderResponseDataList[index]]);
    isDataLoading.value = true;
    recentOrderResponseDataList.clear();
    getRecentOrderListFromServer();
  }

  Future<void> getRecentOrderListFromServer() async {
    try {
      //  isDataLoading.value = true;
      var response = await Get.find<RecentRepo>()
          .getOrderList(page: 1, isLatest: isLatestSelected.value);
      if (response != null && response.responseData != null) {
        recentOrderResponseData.value = response.responseData!;
        //categoriesDataList.addAll(categoriesData.value.categories ?? []);
        recentOrderResponseDataList
            .addAll(response.responseData?.recentOrders ?? []);
      }
      isDataLoading.value = false;
    } catch (e) {
      LoggerUtils.logException('getRecentOrderListFromServer', e);
    }
  }

  /// search order by name or orderId
  void searchOrder() {
    try {
      searchOrdersList.clear();
      for (var element in recentOrderResponseDataList) {
        if ((element.productName ?? '')
                .isCaseInsensitiveContainsAny(searchText.value) ||
            (element.orderId ?? 0).toString().contains(searchText.value)) {
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
      recentOrderResponseDataList.clear();
      getRecentOrderListFromServer();
    } catch (e) {
      LoggerUtils.logException('applyFilter', e);
    }
  }

  void resetOrderFilter() {
    isLatestSelected = true.obs;
    isOldestSelected = false.obs;
    recentOrderResponseDataList.clear();
    getRecentOrderListFromServer();
  }
}

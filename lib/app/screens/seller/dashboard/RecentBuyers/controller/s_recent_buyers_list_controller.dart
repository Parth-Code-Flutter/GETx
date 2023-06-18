import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/recent_repo.dart';

import '../../../../../common/response_status_codes.dart';
import '../model/s_recent_buyers_list_model.dart';



class SRecentBuyersListController extends GetxController {
  TextEditingController searchController = TextEditingController();
  Rx<RecentBuyersResponseData> recentBuyersResponseData =
      RecentBuyersResponseData().obs;
  RxList<RecentBuyers> recentBuyersResponseDataList =
      List<RecentBuyers>.empty(growable: true).obs;
  RxBool isDataLoading = true.obs;
  @override
  Future<void> onInit() async {
    Get.lazyPut(() => RecentRepo(), fenix: true);
    await WidgetsFlutterBinding.ensureInitialized();
    getRecentBuyersListFromServer();
    super.onInit();
  }
  getRecentBuyersListFromServer() async {
    // try {
    var response =
    await Get.find<RecentRepo>().getRecentBuyersList(page: 1);
    if (response != null &&
        response.responseData != null &&
        response.responseCode == successCode) {
      recentBuyersResponseData.value = response.responseData!;
      recentBuyersResponseDataList.addAll(recentBuyersResponseData.value.recentBuyers ?? []);
    }
    isDataLoading.value = false;
    // } catch (e) {
    //   LoggerUtils.logException('getProductListFromServer', e);
    //   isDataLoading.value = false;
    // }
  }

  /// navigate to product details screen
  Future<void> navigateToProductDetailsScreen(int index) async {
    await Get.toNamed(kRouteSRecentBuyersDetailsScreen,
        arguments: [recentBuyersResponseDataList[index]]);
    isDataLoading.value = true;
    recentBuyersResponseDataList.clear();
    getRecentBuyersListFromServer();
  }

  void navigateToAddProductScreen() {
    Get.toNamed(kRouteSAddProductScreen);
  }
}

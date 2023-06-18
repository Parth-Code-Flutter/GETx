import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/repositories/generale_repo.dart';
import 'package:tsofie/app/utils/local_storage.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class BuyerBottomNavController extends GetxController {
  RxInt index = 0.obs;
  double bottomBarNamePadding = 6;

  @override
  void onInit() {
    Get.lazyPut(() => GeneralRepo(), fenix: true);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCartCountFromServer();
    });
    super.onInit();
  }

  Future<void> getCartCountFromServer() async {
    try {
      var response = await Get.find<GeneralRepo>().getGeneraDataFromServer();
      if (response != null) {
        Get.find<LocalStorage>().cartCount.value =
            response.responseData?.totalCartCount ?? 0;
      }
    } catch (e) {
      LoggerUtils.logException('getCartCountFromServer', e);
    }
  }
}

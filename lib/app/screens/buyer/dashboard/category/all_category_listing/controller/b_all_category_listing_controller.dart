import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/model/response/categories_list_model.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/categories_repo.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class BAllCategoryListingController extends GetxController {
  Rx<CategoriesListResponseData> categoriesData =
      CategoriesListResponseData().obs;
  RxList<Categories> categoriesDataList =
      List<Categories>.empty(growable: true).obs;

  @override
  Future<void> onInit() async {
    Get.lazyPut(() => CategoriesRepo(), fenix: true);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCategoriesListFromServer();
    });
    super.onInit();
  }

  Future<void> getCategoriesListFromServer() async {
    try {
      var response =
          await Get.find<CategoriesRepo>().getCategoriesList(page: 1);
      if (response != null && response.responseData != null) {
        categoriesData.value = response.responseData!;
        categoriesDataList.addAll(categoriesData.value.categories ?? []);
        print(response.responseData?.categories);
      }
    } catch (e) {
      LoggerUtils.logException('getCategoriesListFromServer', e);
    }
  }

  void navigateToCatProductListingScreen(int catId) {
    Get.toNamed(kRouteBCategoryProductListingScreen,arguments: [catId]);
  }
}

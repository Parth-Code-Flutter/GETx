import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/response_status_codes.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/product_repo.dart';
import 'package:tsofie/app/screens/buyer/dashboard/product/base/model/response/product_list_response_model.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class BCategoryProductListingController extends GetxController {
  TextEditingController searchController = TextEditingController();

  Rx<ProductData> productData = ProductData().obs;
  RxList<BuyerProducts> productList = List<BuyerProducts>.empty(growable: true).obs;

  RxString searchProductText = ''.obs;

  int currentPageNumber = 1;
  int? nextPageNumber;
  int categoryId = 0;

  Rx<ScrollController> scrollController = ScrollController().obs;

  RxBool isDataLoading = true.obs;

  @override
  Future<void> onInit() async {
    Get.lazyPut(() => ProductRepo(), fenix: true);

    scrollController.value.addListener(() {
      if (scrollController.value.position.maxScrollExtent ==
          scrollController.value.position.pixels) {
        if (nextPageNumber != null) {
          isDataLoading.value = true;
          currentPageNumber++;
          getProductListFromServer();
        }
      }
    });
    super.onInit();
  }

  Future<void> setIntentData({required dynamic intentData}) async {
    try {
      categoryId = (intentData[0] as int);
      await getProductListFromServer();
    } catch (e) {
      LoggerUtils.logException('setIntentData', e);
    }
  }

  void navigateToProductDetailsScreen(int index) {
    Get.toNamed(kRouteBProductDetailsScreen, arguments: [productList[index]]);
  }

  getProductListFromServer({bool isShowLoader = false}) async {
    try {
      var response = await Get.find<ProductRepo>().getProductListApiCall(
          pageNumber: currentPageNumber,
          name: searchProductText.value,
          state: '',
          catId: categoryId.toString(),
          isShowLoader: isShowLoader);
      if (response != null &&
          response.responseData != null &&
          response.responseCode == successCode) {
        productData.value = response.responseData!;
        currentPageNumber = productData.value.currentPage ?? 1;
        nextPageNumber = productData.value.nextPage;
        productList.addAll(productData.value.products ?? []);
      }
      isDataLoading.value = false;
    } catch (e) {
      LoggerUtils.logException('getProductListFromServer', e);
      isDataLoading.value = false;
    }
  }

  /// fav/unfav api call
  Future<void> favUnFavApiCall({required int index}) async {
    try {
      var response = await Get.find<ProductRepo>().favUnFavProductApi(
          productId: productList[index].id ?? 0,
          isFavourite: !(productList[index].isFavourite ?? false),
          buyerId: AppConstants.userId);

      if (response != null && response == true) {
        updateIsFavValues(index: index);
      }
    } catch (e) {
      LoggerUtils.logException('favUnFavApiCall', e);
    }
  }

  void updateIsFavValues({required int index}) {
    productList[index].isFavourite = !(productList[index].isFavourite ?? false);
    productList.refresh();
  }
}

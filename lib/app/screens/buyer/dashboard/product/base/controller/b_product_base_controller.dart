import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/response_status_codes.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/product_repo.dart';
import 'package:tsofie/app/screens/buyer/bottom_nav_screens/controller/bottom_nav_controller.dart';
import 'package:tsofie/app/screens/buyer/dashboard/product/base/model/response/product_list_response_model.dart';
import 'package:tsofie/app/screens/buyer/location/base/model/response/location_response_model.dart';
import 'package:tsofie/app/utils/local_storage.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class BProductBaseController extends GetxController {
  TextEditingController searchController = TextEditingController();
  Rx<ProductData> productData = ProductData().obs;
  RxList<BuyerProducts> filterProductList = List<BuyerProducts>.empty(growable: true).obs;
  RxList<BuyerProducts> originalProductList =
      List<BuyerProducts>.empty(growable: true).obs;

  Rx<LocationData> locationData = LocationData().obs;

  Rx<ScrollController> scrollController = ScrollController().obs;

  RxString searchProductText = ''.obs;

  int currentPageNumber = 1;
  int? nextPageNumber;

  RxInt cartCount = 0.obs;
  RxBool isDataLoading = true.obs;

  RxBool isNewestProductSelected = true.obs;
  RxBool isHighToLowSelected = false.obs;
  RxBool isLowToHighSelected = false.obs;

  @override
  Future<void> onInit() async {
    Get.lazyPut(() => ProductRepo(), fenix: true);
    await getProductListFromServer();
    Get.find<BuyerBottomNavController>().index.listen((p0) {
      if (p0 == 1) {
        isDataLoading.value = true;
        filterProductList.clear();
        currentPageNumber = 1;
        getProductListFromServer();
      }
    });

    cartCount.value = Get.find<LocalStorage>().cartCount.value;
    Get.find<LocalStorage>().cartCount.listen((p0) {
      cartCount.value = p0;
    });

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

  getProductListFromServer({bool isShowLoader = false}) async {
    try {
      var response = await Get.find<ProductRepo>().getProductListApiCall(
          pageNumber: currentPageNumber,
          name: searchProductText.value,
          state: (locationData.value.state ?? '').replaceAll(' ', ''),
          isShowLoader: isShowLoader);
      if (response != null &&
          response.responseData != null &&
          response.responseCode == successCode) {
        productData.value = response.responseData!;
        currentPageNumber = productData.value.currentPage ?? 1;
        nextPageNumber = productData.value.nextPage;
        filterProductList.addAll(productData.value.products ?? []);
        originalProductList.addAll(productData.value.products ?? []);
      }
      isDataLoading.value = false;
    } catch (e) {
      LoggerUtils.logException('getProductListFromServer', e);
      isDataLoading.value = false;
    }
  }

  void navigateToMyCartScreen() {
    Get.toNamed(kRouteBMyCartScreen);
  }

  /// fav/unfav api call
  Future<void> favUnFavApiCall({required int index}) async {
    try {
      var response = await Get.find<ProductRepo>().favUnFavProductApi(
          productId: filterProductList[index].id ?? 0,
          isFavourite: !(filterProductList[index].isFavourite ?? false),
          buyerId: AppConstants.userId);

      if (response != null && response == true) {
        updateIsFavValues(index: index);
      }
    } catch (e) {
      LoggerUtils.logException('favUnFavApiCall', e);
    }
  }

  void updateIsFavValues({required int index}) {
    filterProductList[index].isFavourite =
        !(filterProductList[index].isFavourite ?? false);
    filterProductList.refresh();
  }

  /// navigate to product details screen
  Future<void> navigateToProductDetailsScreen(int index) async {
    await Get.toNamed(kRouteBProductDetailsScreen,
        arguments: [filterProductList[index]]);
    isDataLoading.value = true;
    filterProductList.clear();
    currentPageNumber = 1;
    getProductListFromServer();
  }

  /// navigate to search location screen
  Future<void> navigateToLocationSearchScreen() async {
    var response = await Get.toNamed(kRouteBSearchLocationScreen,
        arguments: locationData.value);
    if (response != null) {
      locationData.value = response;
      filterProductList.clear();
      isDataLoading.value = true;
      getProductListFromServer();
    }
  }

  /// filters function
  void applyFilter() {
    try {
      if (isNewestProductSelected.value) {
        if (filterProductList.isNotEmpty) {
          filterProductList.sort((a, b) => (b.id ?? 0).compareTo(
                (a.id ?? 0),
              ));
        }
      } else if (isHighToLowSelected.value) {
        if (filterProductList.isNotEmpty) {
          filterProductList.sort(
            (a, b) => double.parse(b.productVariants?[0].discountedPrice ?? '0')
                .compareTo(
                    double.parse(a.productVariants?[0].discountedPrice ?? '0')),
          );
        }
      } else if (isLowToHighSelected.value) {
        filterProductList.sort(
          (a, b) => double.parse(a.productVariants?[0].discountedPrice ?? '0')
              .compareTo(
                  double.parse(b.productVariants?[0].discountedPrice ?? '0')),
        );
      }
    } catch (e) {
      LoggerUtils.logException('applyFilter', e);
    }
  }

  void resetProductFilter() {
    isDataLoading.value = true;
    isNewestProductSelected.value = true;
    isHighToLowSelected.value = false;
    isLowToHighSelected.value = false;
    filterProductList.clear();
    currentPageNumber = 1;
    getProductListFromServer();
  }
}

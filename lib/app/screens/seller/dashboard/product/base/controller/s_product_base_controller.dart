import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsofie/app/common/routing_constants.dart';

import '../../../../../../common/model/response/product_list_model.dart';
import '../../../../../../common/response_status_codes.dart';
import '../../../../../../repositories/categories_repo.dart';
import '../../../../../../repositories/product_repo.dart';
import '../../../../../../utils/logger_utils.dart';
import '../../../../s_bootom_nav_screen/controller/s_bottom_nav_controller.dart';

class SProductBaseController extends GetxController {
  TextEditingController searchController = TextEditingController();
  Rx<ProductResponseData> productData = ProductResponseData().obs;
  RxList<Products> filterProductList = List<Products>.empty(growable: true).obs;
  RxList<Products> originalProductList =
      List<Products>.empty(growable: true).obs;
 // RxList<Products> productList = List<Products>.empty(growable: true).obs;
  RxBool isDataLoading = true.obs;

  // At the beginning, we fetch the first 20 posts
  int _page = 1;
  int? nextPage;

  // There is next page or not
  RxBool hasNextPage = true.obs;

  // Used to display loading indicators when _firstLoad function is running
  RxBool isFirstLoadRunning = false.obs;
  RxString searchProductText = ''.obs;
  // Used to display loading indicators when _loadMore function is running
  RxBool isLoadMoreRunning = false.obs;
  late ScrollController scrollController = ScrollController();

  RxBool isNewestProductSelected = true.obs;
  RxBool isHighToLowSelected = false.obs;
  RxBool isLowToHighSelected = false.obs;
  @override
  Future<void> onInit() async {
    Get.lazyPut(() => ProductRepo(), fenix: true);
    await WidgetsFlutterBinding.ensureInitialized();
    Get.find<SellerBottomNavController>().index.listen((p1) {
      if (p1 == 1) {
        isDataLoading.value = true;
        filterProductList.clear();

        getProductListFromServer();
      }
    });
    //_page= 1;
    //getProductListFromServer();
    scrollController = ScrollController()..addListener(_loadMore);
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.removeListener(_loadMore);
    super.dispose();
  }
  getProductListFromServer({bool isShowLoader = false}) async {
    try {
      var response = await Get.find<ProductRepo>().getSellerProductListApiCall(
          pageNumber: _page,
          name: searchProductText.value);
      if (response != null &&
          response.responseData != null &&
          response.responseCode == successCode) {
        productData.value = response.responseData!;
        _page = productData.value.currentPage ?? 1;
        nextPage = productData.value.nextPage;
        filterProductList.addAll(productData.value.products ?? []);
        originalProductList.addAll(productData.value.products ?? []);
      }
      isDataLoading.value = false;
    } catch (e) {
      LoggerUtils.logException('getProductListFromServer', e);
      isDataLoading.value = false;
    }
  }

  // getProductListFromServer() async {
  //   print("Product list");
  //   isFirstLoadRunning = true.obs;
  //   try {
  //     var response = await Get.find<ProductRepo>()
  //         .getSellerProductListApiCall(pageNumber: _page,name:searchProductText.value, );
  //     if (response != null &&
  //         response.responseData != null &&
  //         response.responseCode == successCode) {
  //       _page = response.responseData?.currentPage ?? 1;
  //       nextPage = response.responseData?.nextPage;
  //       productData.value = response.responseData!;
  //       productList.addAll(productData.value.products ?? []);
  //     }
  //     isDataLoading.value = false;
  //   } catch (e) {
  //     LoggerUtils.logException('getProductListFromServer', e);
  //     isDataLoading.value = false;
  //   }
  //   isFirstLoadRunning = false.obs;
  // }

  /// navigate to product details screen
  Future<void> navigateToProductDetailsScreen(int index) async {
    await Get.toNamed(kRouteSProductDetailsScreen,
        arguments: [filterProductList[index]]);
    isDataLoading.value = true;
    filterProductList.clear();
    _page = 1;
    getProductListFromServer();

  }

  Future<void> navigateToAddProductScreen() async {
    bool isAdded = await Get.toNamed(kRouteSAddProductScreen);
    if (isAdded != null && isAdded) {
      _page = 1;
      filterProductList.clear();
      getProductListFromServer();
    }
  }

  Future<void> deleteProductApiCall(productId) async {
    try {
      var response =
          await Get.find<ProductRepo>().deleteProductApi(productId: productId);
      if (response == true) {
        filterProductList.removeWhere((element) => element.id == productId);
        filterProductList.refresh();
        Get.back();
      }
    } catch (e) {
      LoggerUtils.logException('deleteProductApiCall', e);
    }
  }

  Future<void> _loadMore() async {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      isLoadMoreRunning =
          true.obs; // Display a progress indicator at the bottom

      //_page += 1; // Increase _page by 1
      try {
        if (nextPage != null) {
          isDataLoading.value = true;
          _page++;
          getProductListFromServer();
        }
        //       var response = await Get.find<ProductRepo>()
        //           .getSellerProductListApiCall(pageNumber: _page,limit: _limit);
        //       if (response != null &&
        //           response.responseData != null &&
        //           response.responseCode == successCode) {
        //         _page= response.responseData?.nextPage??1;
        //         productData.value = response.responseData!;
        //         productList.addAll(productData.value.products ?? []);
        //       }else{
        // // This means there is no more data
        // // and therefore, we will not send another GET request
        //         hasNextPage = false.obs;
        //       }
        //       isDataLoading.value = false;
      } catch (e) {
        LoggerUtils.logException('getProductListFromServer', e);
        isDataLoading.value = false;
      }
      isLoadMoreRunning = false.obs;
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
     isNewestProductSelected.value = true;
     isHighToLowSelected.value = false;
     isLowToHighSelected.value = false;
    isDataLoading.value = true;

    filterProductList.clear();
    _page = 1;
    getProductListFromServer();
  }
}

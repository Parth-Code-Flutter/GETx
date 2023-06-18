import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/banner_img_repo.dart';
import 'package:tsofie/app/repositories/categories_repo.dart';
import 'package:tsofie/app/repositories/order_repo.dart';
import 'package:tsofie/app/screens/buyer/bottom_nav_screens/controller/bottom_nav_controller.dart';
import 'package:tsofie/app/screens/buyer/dashboard/order/base/model/response/orders_response_model.dart';
import 'package:tsofie/app/utils/local_storage.dart';

import '../../../../../common/model/response/banner_image_list_response_model.dart';
import '../../../../../common/model/response/categories_list_model.dart';
import '../../../../../utils/logger_utils.dart';

class BHomeController extends GetxController {
  RxString defaultLocation = 'Ahmedabad, Gujarat'.obs;
  Rx<CarouselController> imageSliderController = CarouselController().obs;

  RxInt cartCount = 0.obs;

  RxInt current = 0.obs;
  RxList<String> imageList = List<String>.empty(growable: true).obs;

  RxList<Order> recentOrdersList = List<Order>.empty(growable: true).obs;

  RxBool tempBool = false.obs;
  Rx<CategoriesListResponseData> categoriesData =
      CategoriesListResponseData().obs;
  RxList<Categories> categoriesDataList =
      List<Categories>.empty(growable: true).obs;
  Rx<BannerImageListResponseData> bannerImageListResponseData =
      BannerImageListResponseData().obs;
  RxList<Banners> bannerImageListResponseDataList =
      List<Banners>.empty(growable: true).obs;

  @override
  Future<void> onInit() async {
    Get.lazyPut(() => CategoriesRepo(), fenix: true);
    Get.lazyPut(() => BannerImgRepo(), fenix: true);
    Get.lazyPut(() => OrderRepo(), fenix: true);
    await WidgetsFlutterBinding.ensureInitialized();
    await getCategoriesListFromServer();
    await getBannerImgListFromServer();
    getRecentOrdersFromServer();

    cartCount.value = Get.find<LocalStorage>().cartCount.value;
    Get.find<LocalStorage>().cartCount.listen((p0) {
      cartCount.value = p0;
    });
    super.onInit();
  }

  void navigateToLocationScreen() {
    Get.toNamed(kRouteBBaseLocationScreen);
  }

  void navigateToAllCategoryListingScreen() {
    Get.toNamed(kRouteBAllCategoryListing);
  }

  void navigateToMyCartScreen() {
    Get.toNamed(kRouteBMyCartScreen);
  }

  Future<void> getCategoriesListFromServer() async {
    try {
      var response = await Get.find<CategoriesRepo>()
          .getCategoriesList(page: 1, isShowLoader: false);
      if (response != null && response.responseData != null) {
        categoriesData.value = response.responseData!;
        categoriesDataList.addAll(categoriesData.value.categories ?? []);
      }
    } catch (e) {
      LoggerUtils.logException('getCategoriesListFromServer', e);
    }
  }

  Future<void> getBannerImgListFromServer() async {
    try {
      var response =
          await Get.find<BannerImgRepo>().getBannerImgList(isShowLoader: false);
      if (response != null && response.responseData != null) {
        bannerImageListResponseData.value = response.responseData!;
        bannerImageListResponseDataList
            .addAll(bannerImageListResponseData.value.banners ?? []);
      }
    } catch (e) {
      LoggerUtils.logException('getBannerImgListFromServer', e);
    }
  }

  Future<void> getRecentOrdersFromServer() async {
    try {
      var response = await Get.find<OrderRepo>().getRecentOrdersList();
      if (response != null) {
        recentOrdersList.addAll(response.responseData?.orders ?? []);
      }
    } catch (e) {
      LoggerUtils.logException('getRecentOrdersFromServer', e);
    }
  }

  void navigateToOrderDetailsScreen({required Order orderData}) {
    Get.toNamed(kRouteBOrderDetailsScreen, arguments: [orderData]);
  }

  void navigateToOrderListingScreen() {
    Get.find<BuyerBottomNavController>().index.value = 2;
  }

  void navigateToCatProductListingScreen(int catId) {
    Get.toNamed(kRouteBCategoryProductListingScreen, arguments: [catId]);
  }
}

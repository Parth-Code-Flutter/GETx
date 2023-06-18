import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/product_repo.dart';
import 'package:tsofie/app/repositories/recent_repo.dart';
import '../../../../../common/model/response/banner_image_list_response_model.dart';
import '../../../../../common/model/response/categories_list_model.dart';
import '../../../../../common/model/response/product_list_model.dart';
import '../../../../../repositories/banner_img_repo.dart';
import '../../../../../repositories/categories_repo.dart';
import '../../../../../utils/logger_utils.dart';
import '../../../s_bootom_nav_screen/controller/s_bottom_nav_controller.dart';
import '../../RecentBuyers/model/s_recent_buyers_list_model.dart';

class SHomeController extends GetxController {
  TextEditingController searchLocationController = TextEditingController();
  RxString defaultLocation = 'Ahmedabad, Gujarat'.obs;
  Rx<CarouselController> imageSliderController = CarouselController().obs;
  Rx<BannerImageListResponseData> bannerImageListResponseData =
      BannerImageListResponseData().obs;
  RxList<Banners> bannerImageListResponseDataList =
      List<Banners>.empty(growable: true).obs;
  Rx<ProductResponseData> recentProductsResponseData =
      ProductResponseData().obs;
  RxList<Products> recentProductsResponseDataList =
      List<Products>.empty(growable: true).obs;
  Rx<RecentBuyersResponseData> recentBuyersResponseData =
      RecentBuyersResponseData().obs;
  RxList<RecentBuyers> recentBuyersResponseDataList =
      List<RecentBuyers>.empty(growable: true).obs;
  RxInt current = 0.obs;
  // RxList<String> imageList = List<String>.empty(growable: true).obs;

  RxBool tempBool = false.obs;
  RxBool isDataLoading = true.obs;
  @override
  Future<void> onInit() async {
    // imageList.add(kImgDummyBanner2);
    // imageList.add(kImgDummyBanner2);
    // imageList.add(kImgDummyBanner2);
    // imageList.add(kImgDummyBanner2);
    // imageList.add(kImgDummyBanner2);
    // imageList.add(kImgDummyBanner2);
    Get.lazyPut(() => BannerImgRepo(), fenix: true);
    Get.lazyPut(() => ProductRepo(), fenix: true);
    Get.lazyPut(() => RecentRepo(), fenix: true);
    await WidgetsFlutterBinding.ensureInitialized(

    );
    // getCategoriesListFromServer();
    getBannerImgListFromServer();
    getRecentBuyersListFromServer();
    getRecentProductListFromServer();
    Get.find<SellerBottomNavController>().index.listen((p0) {
      if (p0 == 0) {
        isDataLoading.value = true;
        recentProductsResponseDataList.clear();
        getRecentProductListFromServer();
        recentBuyersResponseDataList.clear();
        getRecentBuyersListFromServer();
      }
    });
    super.onInit();

  }
  /// navigate to product details screen
  Future<void> navigateToProductDetailsScreen(int index) async {
    await Get.toNamed(kRouteSProductDetailsScreen,
        arguments: [recentProductsResponseDataList[index]]);
    isDataLoading.value = true;
    recentProductsResponseDataList.clear();
    getRecentProductListFromServer();
  }
  /// navigate to product details screen
  Future<void> navigateToBuyersDetailsScreen(int index) async {
    await Get.toNamed(kRouteSRecentBuyersDetailsScreen,
        arguments: [recentBuyersResponseDataList[index]]);
    isDataLoading.value = true;
    recentBuyersResponseDataList.clear();
    getRecentBuyersListFromServer();
  }
   navigateToRecentBuyersListScreen() {
    Get.toNamed(kRouteSRecentBuyersListScreen);
  }
  Future<void> getBannerImgListFromServer() async {
    try {
      var response = await Get.find<BannerImgRepo>().getBannerImgList();
      if (response != null && response.responseData != null) {
        bannerImageListResponseData.value = response.responseData!;
        bannerImageListResponseDataList
            .addAll(bannerImageListResponseData.value.banners ?? []);
      }
    } catch (e) {
      LoggerUtils.logException('getBannerImgListFromServer', e);
    }
  }
    Future<void> getRecentProductListFromServer() async {
      try {
        var response =
        await Get.find<ProductRepo>().getRecentProductsList(page: 1);
        if (response != null && response.responseData != null) {
          recentProductsResponseData.value = response.responseData!;
          //categoriesDataList.addAll(categoriesData.value.categories ?? []);
          recentProductsResponseDataList.addAll(
              response.responseData?.products ?? []);
        }
      } catch (e) {
        LoggerUtils.logException('getRecentProductListFromServer', e);
      }
    }
  Future<void> getRecentBuyersListFromServer() async {
    try {
      var response =
      await Get.find<RecentRepo>().getRecentBuyersList(page: 1);
      if (response != null && response.responseData != null) {
        recentBuyersResponseData.value = response.responseData!;
        //categoriesDataList.addAll(categoriesData.value.categories ?? []);
        recentBuyersResponseDataList.addAll(
            response.responseData?.recentBuyers ?? []);
        print("response recent buyers :: ${response.responseData}");
      }
    } catch (e) {
      LoggerUtils.logException('getRecentProductListFromServer', e);
    }
  }
  Future<void> navigateToAddProductScreen() async {
    //  bool isAdded =
    await Get.toNamed(kRouteSAddProductScreen);
    // if (isAdded != null && isAdded) {
    //   _page = 1;
    //   productList.clear();
    isDataLoading.value = true;
    recentProductsResponseDataList.clear();
    getRecentProductListFromServer();
    // }
  }
}

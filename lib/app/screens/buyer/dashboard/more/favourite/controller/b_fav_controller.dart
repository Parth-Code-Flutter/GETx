import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/response_status_codes.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/favourite_repo.dart';
import 'package:tsofie/app/repositories/product_repo.dart';
import 'package:tsofie/app/screens/buyer/dashboard/product/base/model/response/product_list_response_model.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class BFavController extends GetxController {
  RxList<BuyerProducts> favouriteProductList =
      List<BuyerProducts>.empty(growable: true).obs;

  @override
  Future<void> onInit() async {
    Get.lazyPut(() => FavouriteRepo(), fenix: true);
    Get.lazyPut(() => ProductRepo(), fenix: true);

    super.onInit();
  }

  Future<void> getFavouriteProductsListFromServer() async {
    try {
      var response =
          await Get.find<FavouriteRepo>().getFavouriteProductListApiCall();
      if (response != null &&
          response.responseData != null &&
          response.responseCode == successCode) {
        favouriteProductList.addAll(response.responseData?.products ?? []);
      }
    } catch (e) {
      LoggerUtils.logException('getFavouriteProductsListFromServer', e);
    }
  }

  void navigateToProductDetailsScreen(int index) {
    Get.toNamed(kRouteBProductDetailsScreen,
        arguments: [favouriteProductList[index]]);
  }

  /// fav/unfav api call
  Future<void> favUnFavApiCall({required int index}) async {
    try {
      var response = await Get.find<ProductRepo>().favUnFavProductApi(
          productId: favouriteProductList[index].id ?? 0,
          isFavourite: !(favouriteProductList[index].isFavourite ?? false),
          buyerId: AppConstants.userId);

      if (response != null && response == true) {
        updateIsFavValues(index: index);
      }
    } catch (e) {
      LoggerUtils.logException('favUnFavApiCall', e);
    }
  }

  void updateIsFavValues({required int index}) {
    favouriteProductList.removeAt(index);
    favouriteProductList.refresh();
  }
}

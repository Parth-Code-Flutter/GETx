import 'package:get/get.dart';
import 'package:tsofie/app/common/model/response/banner_image_list_response_model.dart';
import 'package:tsofie/app/repositories/recent_repo.dart';

import '../../../../../utils/logger_utils.dart';
import '../../../../buyer/cart/my_cart/controller/b_my_cart_controller.dart';
import '../model/s_recent_buyers_list_model.dart';
class SBuyersDetailsController extends GetxController{
  RxInt currentIndex = 0.obs;
  RxInt currentVariantIndex = 0.obs;
  RxList<GSTData> gstDataList = List<GSTData>.empty(growable: true).obs;
  Rx<RecentBuyers> recentBuyersResponseData =
      RecentBuyers().obs;
  RxList<Banners> bannersList = List<Banners>.empty(growable: true).obs;
  @override
  void onInit() {
    Get.lazyPut(() => RecentRepo(), fenix: true);

    super.onInit();
  }

  setIntentData({required dynamic intentData}) {
    try {
      currentVariantIndex.value = 0;

      recentBuyersResponseData.value = (intentData[0] as RecentBuyers);

      //  print('image length :: ${(recentBuyersResponseData.value.recentBuyers.productImages[]??[]).length}');
      if((recentBuyersResponseData.value.productImages ??[]).isNotEmpty){
        for(ProductImages ele in (recentBuyersResponseData.value.productImages??[])){
          bannersList.add(Banners(id: ele.id,image: ele.image));
        }
      }

      print('bannersList :: ${bannersList.length}');
      // productDetailsData.value.productVariants?[currentVariantIndex.value].qty =
      // 1;
      // calculateTotalPrice();
    } catch (e) {
      LoggerUtils.logException('setIntentData', e);
    }
  }
}
import 'package:get/get.dart';
import 'package:tsofie/app/screens/seller/dashboard/order/model/order_list_response_model.dart';

import '../../../../../../common/model/response/banner_image_list_response_model.dart';
import '../../../../../../utils/logger_utils.dart';

class SOrderDetailsController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxInt currentVariantIndex = 0.obs;

  Rx<RecentOrders> recentOrdersData = RecentOrders().obs;
  RxList<Banners> bannersList = List<Banners>.empty(growable: true).obs;
  RxString tempOrderStatus = 'Delivered'.obs;
  setIntentData({required dynamic intentData}) {
    try {
      currentVariantIndex.value = 0;

      recentOrdersData.value = (intentData[0] as RecentOrders);

      print('image length :: ${(recentOrdersData.value.productImages?[0].image??[])}');
      if(((recentOrdersData.value.productImages??[]).isNotEmpty)){
        for(ProductImages ele in (recentOrdersData.value.productImages??[])){
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

import 'package:get/get.dart';
import 'package:tsofie/app/common/model/response/banner_image_list_response_model.dart';
import 'package:tsofie/app/screens/buyer/dashboard/order/base/model/response/orders_response_model.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class BOrderDetailsController extends GetxController {
  RxInt currentIndex = 0.obs;

  RxString tempOrderStatus = 'Delivered'.obs;

  RxList<Banners> bannerList = List<Banners>.empty(growable: true).obs;
  Rx<Order> orderData = Order().obs;

  void setIntentData({required dynamic intentData}) {
    try {
      orderData.value = (intentData[0] as Order);
      if ((orderData.value.productImages ?? []).isNotEmpty) {
        (orderData.value.productImages ?? []).forEach((element) {
          bannerList.add(Banners(id: element.id, image: element.image));
        });
      }
    } catch (e) {
      LoggerUtils.logException('setIntentData', e);
    }
  }
}

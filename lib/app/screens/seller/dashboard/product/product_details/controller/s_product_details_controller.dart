import 'package:get/get.dart';
import 'package:tsofie/app/common/model/response/banner_image_list_response_model.dart';

import '../../../../../../common/model/response/product_list_model.dart';
import '../../../../../../common/routing_constants.dart';
import '../../../../../../repositories/product_repo.dart';
import '../../../../../../utils/logger_utils.dart';

class SProductDetailsController extends GetxController{
  RxInt currentIndex = 0.obs;
  RxInt currentVariantIndex = 0.obs;

  RxBool isReadMoreExpanded = false.obs;

  Rx<Products> productDetailsData = Products().obs;
  RxList<Banners> bannersList = List<Banners>.empty(growable: true).obs;

  @override
  void onInit() {
    Get.lazyPut(() => ProductRepo(), fenix: true);

    super.onInit();
  }
  /// navigate to product details screen
  Future<void> navigateToEditProductScreen() async {
   var response =  await Get.toNamed(kRouteSEditProductScreen,
        arguments: [productDetailsData.value]);
    print("callback ::: $response");
    if(response!=null) {
      productDetailsData.value = response;
      bannersList.clear();
      if((productDetailsData.value.productImages??[]).isNotEmpty){
        for(ProductImages ele in (productDetailsData.value.productImages??[])){
          bannersList.add(Banners(id: ele.id,image: ele.image));
        }
      }
      bannersList.refresh();
    }

  }
  void updateProductVariants(int index) {
    // productDetailsData.value.productVariants?[currentVariantIndex.value].stockQty =
    // 1;
    currentVariantIndex.value = index;
    //calculateTotalPrice();
  }
  setIntentData({required dynamic intentData}) {
    try {
      currentVariantIndex.value = 0;

      productDetailsData.value = (intentData[0] as Products);

      print('image length :: ${(productDetailsData.value.productImages??[]).length}');
      if((productDetailsData.value.productImages??[]).isNotEmpty){
        for(ProductImages ele in (productDetailsData.value.productImages??[])){
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
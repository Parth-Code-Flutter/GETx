import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/model/response/banner_image_list_response_model.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/cart_repo.dart';
import 'package:tsofie/app/repositories/product_repo.dart';
import 'package:tsofie/app/screens/buyer/dashboard/product/base/model/response/product_list_response_model.dart';
import 'package:tsofie/app/screens/buyer/dashboard/product/product_details/model/request/add_to_cart_request_model.dart';
import 'package:tsofie/app/utils/alert_message_utils.dart';
import 'package:tsofie/app/utils/local_storage.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class BProductDetailsController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxInt currentVariantIndex = 0.obs;

  RxInt cartCount = 0.obs;

  RxBool isReadMoreExpanded = true.obs;

  RxInt leftQty = 0.obs;

  Rx<BuyerProducts> productDetailsData = BuyerProducts().obs;
  RxList<Banners> productImagesList = List<Banners>.empty(growable: true).obs;

  @override
  void onInit() {
    Get.lazyPut(() => ProductRepo(), fenix: true);
    Get.lazyPut(() => CartRepo(), fenix: true);
    cartCount.value = Get.find<LocalStorage>().cartCount.value;
    Get.find<LocalStorage>().cartCount.listen((p0) {
      cartCount.value = p0;
    });
    super.onInit();
  }

  /// set intentData from product listing screen
  setIntentData({required dynamic intentData}) {
    try {
      currentVariantIndex.value = 0;

      productDetailsData.value = (intentData[0] as BuyerProducts);
      productDetailsData.value.productVariants?[currentVariantIndex.value].qty =
          1;
      leftQty.value = productDetailsData.value.productVariants?[0].leftQty??0;
      if ((productDetailsData.value.productImages ?? []).isNotEmpty) {
        for (ProductImage data
            in (productDetailsData.value.productImages ?? [])) {
          productImagesList.add(Banners(id: data.id, image: data.image));
        }
      }
      calculateTotalPrice();
    } catch (e) {
      LoggerUtils.logException('setIntentData', e);
    }
  }

  /// fav/unfav api call
  Future<void> favUnFavApiCall() async {
    try {
      var response = await Get.find<ProductRepo>().favUnFavProductApi(
          productId: productDetailsData.value.id ?? 0,
          isFavourite: !(productDetailsData.value.isFavourite ?? false),
          buyerId: AppConstants.userId);

      if (response != null && response == true) {
        updateIsFavValues();
      }
    } catch (e) {
      LoggerUtils.logException('favUnFavApiCall', e);
    }
  }

  void updateIsFavValues() {
    productDetailsData.value.isFavourite =
        !(productDetailsData.value.isFavourite ?? false);
    productDetailsData.refresh();
  }

  void minusQty() {
    if ((productDetailsData
                .value.productVariants?[currentVariantIndex.value].qty ??
            0) >
        1) {
      productDetailsData.value.productVariants?[currentVariantIndex.value].qty =
          (productDetailsData
                      .value.productVariants?[currentVariantIndex.value].qty ??
                  0) -
              1;
      productDetailsData.refresh();
    }
    calculateTotalPrice();
  }

  void addQty() {
    productDetailsData.value.productVariants?[currentVariantIndex.value].qty =
        (productDetailsData
                    .value.productVariants?[currentVariantIndex.value].qty ??
                0) +
            1;
    productDetailsData.refresh();
    calculateTotalPrice();
  }

  void updateProductVariants(int index) {
    productDetailsData.value.productVariants?[currentVariantIndex.value].qty =
        1;
    currentVariantIndex.value = index;
    leftQty.value = productDetailsData.value.productVariants?[index].leftQty ??0;
    print('leftQty :: ${leftQty.value}');
    calculateTotalPrice();
  }

  calculateTotalPrice() {
    productDetailsData
        .value.productVariants?[currentVariantIndex.value].totalPrice = 0.0;

    double productPrice = double.parse(
        '${productDetailsData.value.productVariants?[currentVariantIndex.value].price ?? 0}');
    double qty = double.parse(
        '${productDetailsData.value.productVariants?[currentVariantIndex.value].qty ?? 0}');
    productDetailsData.value.productVariants?[currentVariantIndex.value]
        .totalPrice = (productDetailsData
                .value.productVariants?[currentVariantIndex.value].totalPrice ??
            0.0) +
        (productPrice * qty);

    productDetailsData.refresh();
  }

  Future<void> checkAvailabilityQtyApiCall({bool isBuyButtonClicked = false}) async {
    try {
      var response = await Get.find<CartRepo>().checkAvailabilityQtyApi(
        productVariantId: productDetailsData
                .value.productVariants?[currentVariantIndex.value].id ??
            0,
        qty: productDetailsData
                .value.productVariants?[currentVariantIndex.value].qty ??
            0,
      );
      if (response == true) {
        addToCartApiCall(isBuyButtonClicked: isBuyButtonClicked);
      }
    } catch (e) {
      LoggerUtils.logException('checkAvailabilityQtyApiCall', e);
    }
  }

  Future<void> addToCartApiCall({bool isBuyButtonClicked = false}) async {
    try {
      var requestModel = AddToCartRequestModel(
        productVariantId: productDetailsData
                .value.productVariants?[currentVariantIndex.value].id ??
            0,
        quantity: productDetailsData
                .value.productVariants?[currentVariantIndex.value].qty ??
            0,
      );
      var response =
          await Get.find<CartRepo>().addToCartApi(requestModel: requestModel);

      if (response != null) {
        Get.find<LocalStorage>().cartCount.value = response.responseData?.totalCartCount??0;
        if(isBuyButtonClicked){
          navigateToMyCartScreen();
        }else{
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: 'Add To Cart Successfully');
        }
      }
    } catch (e) {
      LoggerUtils.logException('addToCartApiCall', e);
    }
  }

  void navigateToMyCartScreen() {
    LocalStorage.isFromProductDetailsScreen = true;
    Get.toNamed(kRouteBMyCartScreen);
  }

  String returnDiscountedPrice() {
    String discountedPrice = '0';
    discountedPrice = (double.parse(productDetailsData
                    .value.productVariants?[currentVariantIndex.value].price ??
                '0') -
            double.parse(productDetailsData
                    .value
                    .productVariants?[currentVariantIndex.value]
                    .discountedPrice ??
                '0'))
        .toStringAsFixed(2);
    return discountedPrice;
  }
}

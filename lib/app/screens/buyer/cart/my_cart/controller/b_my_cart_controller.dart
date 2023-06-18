import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/common/response_status_codes.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/cart_repo.dart';
import 'package:tsofie/app/screens/buyer/cart/my_cart/model/request/update_cart_items_request_model.dart';
import 'package:tsofie/app/screens/buyer/cart/my_cart/model/response/cart_items_response_model.dart';
import 'package:tsofie/app/utils/local_storage.dart';
import 'package:tsofie/app/utils/logger_utils.dart';
import 'package:tsofie/app/utils/return_gst_calc_value.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/alert_dialog_widget.dart';
import 'package:tsofie/app/widgets/primary_button.dart';

class BMyCartController extends GetxController {
  RxString shippingAddress =
      'E-202, Rudram Icon, opp. Lambada house, Gota Cross Road, Ahmdabad'.obs;

  RxList<GSTData> gstDataList = List<GSTData>.empty(growable: true).obs;
  Rx<CartResponseData> cartData = CartResponseData().obs;
  RxList<CartData> cartItemsList = List<CartData>.empty(growable: true).obs;

  @override
  void onInit() {
    Get.lazyPut(() => CartRepo(), fenix: true);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await getCartItemsFromServer();
    // });
    super.onInit();
  }

  Future<void> getCartItemsFromServer() async {
    try {
      var response = await Get.find<CartRepo>().getCartItemsApi();

      if (response != null) {
        cartData.value = response.responseData!;
        cartItemsList.addAll(cartData.value.cartItems ?? []);
      }
      if (cartItemsList.isNotEmpty) {
        calculateTotalQty();
      }
    } catch (e) {
      LoggerUtils.logException('getCartItemsFromServer', e);
    }
  }

  void decrQty(int index) {
    if ((cartItemsList[index].quantity ?? 1) > 1) {
      cartItemsList[index].quantity = (cartItemsList[index].quantity ?? 1) - 1;
      cartItemsList.refresh();
      calculateTotalQty();
      // calculateTotalPrice();
      // calculateTotalGstAndGstList();
    }
  }

  void incrQty(int index) {
    cartItemsList[index].quantity = (cartItemsList[index].quantity ?? 1) + 1;
    cartItemsList.refresh();
    calculateTotalQty();
    // calculateTotalPrice();
    // calculateTotalGstAndGstList();
  }

  /// calculate total qty
  void calculateTotalQty() {
    cartData.value.totalQty = 0;
    for (var cartItem in cartItemsList) {
      int qty = cartItem.quantity ?? 0;
      cartData.value.totalQty = qty + (cartData.value.totalQty ?? 0);
    }
    cartData.refresh();
    calculateTotalPrice();
  }

  /// calculate total product price
  void calculateTotalPrice() {
    cartData.value.totalPrice = 0.0;
    for (var cartItem in cartItemsList) {
      double discountedPrice = (double.parse(cartItem.price ?? '0') -
          double.parse(cartItem.discountedPrice ?? '0'));
      cartItem.updatedDiscountPrice = discountedPrice.toStringAsFixed(2);
      double productPrice =
          double.parse('${cartItem.discountedPrice ?? 0}');
      double qty = double.parse('${cartItem.quantity ?? 0}');
      cartData.value.totalPrice =
          (cartData.value.totalPrice ?? 0.0) + (productPrice * qty);
    }
    cartData.refresh();
    calculateTotalGstAndGstList();
  }

  /// add gst values to list and calculate totalGst value
  void calculateTotalGstAndGstList() {
    /// add gst data into gstDataList
    gstDataList.clear();
    for (var cartItem in cartItemsList) {
      if (gstDataList.isNotEmpty) {
        // if(gstDataList.asMap().containsKey(cartItem.gst??0)){
        int i = gstDataList
            .indexWhere((element) => element.gstPerc == cartItem.gst);
        if (i != -1) {
          double price =
               double.parse((cartItem.discountedPrice ?? '0'));
          // double price = (cartItem.price ?? 0).toDouble();
          double finalPrice = gstDataList[i].price +(price * (cartItem.quantity ?? 0));

          // double finalPrice = returnGstCalcValue(
          //     productPrice: price,
          //     qty: cartItem.quantity ?? 0,
          //     gstValue: (gstDataList[i].gstPerc??0).toDouble());
          gstDataList.remove(gstDataList[i]);
          gstDataList.add(GSTData(cartItem.gst ?? 0, finalPrice)); // finalPrice
        } else {
          // double price = double.parse('${cartItem.price ?? 0}');
          double discountedPrice = (
              double.parse(cartItem.discountedPrice ?? '0'));
          cartItem.updatedDiscountPrice = discountedPrice.toStringAsFixed(2);
          double price = double.parse('$discountedPrice');
          double finalPrice = (price * (cartItem.quantity ?? 0));

          // int currentGstIndex = gstDataList.isEmpty?0:gstDataList.length-1;
          // double price =  double.parse('${cartItem.price ?? 0}');
          // double finalPrice = returnGstCalcValue(
          //     productPrice: price,
          //     qty: cartItem.quantity ?? 0,
          //     gstValue: double.parse('${gstDataList[currentGstIndex].gstPerc}'));

          gstDataList.add(
            GSTData(cartItem.gst ?? 0, finalPrice), // finalPrice
          );
        }
      } else {
        // double price = double.parse('${cartItem.price ?? 0}');
        double discountedPrice = (
            double.parse(cartItem.discountedPrice ?? '0'));
        cartItem.updatedDiscountPrice = discountedPrice.toStringAsFixed(2);
        double price = double.parse('$discountedPrice');
        double finalPrice = (price * (cartItem.quantity ?? 0));

        // int currentGstIndex = gstDataList.isEmpty?0:gstDataList.length-1;
        // double price =  double.parse('${cartItem.price ?? 0}');
        // double finalPrice = returnGstCalcValue(
        //     productPrice: price,
        //     qty: cartItem.quantity ?? 0,
        //     gstValue: double.parse('${gstDataList[currentGstIndex].gstPerc}'));
        gstDataList.add(
          GSTData(cartItem.gst ?? 0, finalPrice), // finalPrice
        );
      }
    }

    for (var element in gstDataList) {
      element.price = returnGstCalcValue(
          productPrice: (element.price).toDouble(),
          gstValue: (element.gstPerc).toDouble());
    }
    gstDataList.refresh();

    /// calculate total gst
    cartData.value.totalGSTPerc = 0.0;
    cartData.value.totalGSTPrice = 0.0;
    for (var gstData in gstDataList) {
      // cartData.value.totalGSTPerc =
      //     ((cartData.value.totalGSTPerc ?? 0.0) + gstData.gstPerc);
      cartData.value.totalGSTPrice =
          ((cartData.value.totalGSTPrice ?? 0.0) + gstData.price);
    }

    // cartData.value.totalPrice = (cartData.value.totalPrice ?? 0.0) +
    //     (cartData.value.totalGSTPrice ?? 0.0);
    cartData.refresh();
  }

  /// remove cart items api call
  Future<void> removeCartItemApiCall(int cartItemID, int index) async {
    try {
      var response =
          await Get.find<CartRepo>().removeCartItem(cartItemID: cartItemID);

      if (response != null && response == true) {
        cartItemsList.removeAt(index);
        cartItemsList.refresh();
        calculateTotalQty();
      }
    } catch (e) {
      LoggerUtils.logException('removeCartItemApiCall', e);
    }
  }

  /// update cart items api call
  Future<void> updateCartItemsApiCall({bool isForCheckout = false}) async {
    try {
      if (cartItemsList.isEmpty) {
        Get.find<LocalStorage>().cartCount.value = 0;
        Get.back();
      } else {
        /// from updateCart api response data list store into below list for comparison
        List<CartData> updatedCartList = [];

        /// request cartList
        List<Cart> cartList = [];
        for (var cartItems in cartItemsList) {
          cartList.add(
            Cart(
                quantity: cartItems.quantity ?? 1,
                cartId: cartItems.cartId ?? 0),
          );
        }
        var requestModel = UpdateCartItemsRequestModel(
          carts: cartList,
        );
        var response = await Get.find<CartRepo>()
            .updateCartItemsApi(requestModel: requestModel);
        if (response != null) {
          if (response.responseCode == successCode) {
            // Get.back();

            // else if (response.responseCode == errorCode &&
            //     response.responseData != null) {
            if (isForCheckout) {
              updatedCartList.addAll(response.responseData?.cartItems ?? []);
              checkForOutOfStock(
                  requestCartList: cartList, updatedCartList: updatedCartList);
            } else {
              if (cartItemsList.isEmpty) {
                Get.find<LocalStorage>().cartCount.value = 0;
              } else {
                Get.find<LocalStorage>().cartCount.value = cartItemsList.length;
              }
              Get.back();
            }
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('updateCartItemsApiCall', e);
    }
  }

  checkForOutOfStock(
      {required List<Cart> requestCartList,
      required List<CartData> updatedCartList}) {
    try {
      for (var items in requestCartList) {
        for (var cartData in cartItemsList) {
          if (items.cartId == cartData.cartId &&
              (items.quantity ?? 1) > (cartData.leftQty ?? 1)) {
            cartData.isOutOfStock = true;
          }
        }
      }
      cartItemsList.refresh();

      int i =
          cartItemsList.indexWhere((element) => element.isOutOfStock == true);
      if (i != -1) {
        showAlertDialog();
      } else {
        Get.toNamed(kRouteBShippingAddressesScreen,
            arguments: [cartItemsList, cartData.value, gstDataList]);
      }
    } catch (e) {
      LoggerUtils.logException('checkForOutOfStock', e);
    }
  }

  showAlertDialog() {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width,
                height: 80,
                // height: 120,
                decoration: BoxDecoration(color: kColorBackground),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ),
                    // SizedBox(height: 10),
                    Text(kLabelPleaseRemoveOutOfStock,
                        style: TextStyles.kH16PrimaryBold700),
                    // SvgPicture.asset(kIconDelete)
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                child: primaryButton(
                    onPress: () {
                      Get.back();
                    },
                    buttonTxt: kLabelOkay,
                    height: 50),
              ),
            ],
          ),
        );
      },
    );
  }
}

class GSTData {
  int gstPerc;
  double price;

  GSTData(this.gstPerc, this.price);
}

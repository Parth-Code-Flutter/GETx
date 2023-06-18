import 'dart:convert';

import 'package:get/get.dart';
import 'package:tsofie/app/common/response_status_codes.dart';
import 'package:tsofie/app/screens/buyer/cart/my_cart/model/request/update_cart_items_request_model.dart';
import 'package:tsofie/app/screens/buyer/cart/my_cart/model/response/cart_items_response_model.dart';
import 'package:tsofie/app/screens/buyer/dashboard/product/product_details/model/request/add_to_cart_request_model.dart';
import 'package:tsofie/app/screens/buyer/dashboard/product/product_details/model/response/add_to_cart_response_model.dart';
import 'package:tsofie/app/services/api_constants.dart';
import 'package:tsofie/app/services/api_services.dart';
import 'package:tsofie/app/utils/alert_message_utils.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class CartRepo {
  Future<AddToCartResponseModel?> addToCartApi(
      {required AddToCartRequestModel requestModel}) async {
    try {
      var response = await ApiService().postRequest(
          endPoint: ApiConst.addToCart,
          requestModel: addToCartRequestModelToJson(requestModel));

      if (response != null) {
        var responseModel = addToCartResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode &&
            responseModel.responseData != null) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('addToCartApi', e);
    }
    return null;
  }

  Future<CartItemsResponseModel?> getCartItemsApi() async {
    try {
      var response =
          await ApiService().getRequest(endPoint: ApiConst.cartItemsList);
      if (response != null) {
        var responseModel = cartItemsResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode &&
            responseModel.responseData != null) {
          return responseModel;
        } else {
          // Get.find<AlertMessageUtils>()
          //     .showSnackBar(message: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('getCartItemsApi', e);
    }
    return null;
  }

  Future<bool?> checkAvailabilityQtyApi(
      {required int productVariantId, required int qty}) async {
    try {
      var response = await ApiService().getRequest(
          endPoint:
              '${ApiConst.checkAvailableQuantity}?product_variant_id=$productVariantId&quantity=$qty');

      if (response != null) {
        var responseModel = jsonDecode(response.body);
        if (responseModel['response_code'] == successCode) {
          return true;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel['response_message']);
        }
      }
    } catch (e) {
      LoggerUtils.logException('checkAvailabilityQtyApi', e);
    }
    return false;
  }

  Future<bool?> removeCartItem({required int cartItemID}) async {
    try {
      var response = await ApiService()
          .deleteRequest(endPoint: '${ApiConst.removeCartItem}/$cartItemID');

      if (response != null) {
        var responseModel = jsonDecode(response.body);
        if (responseModel['response_code'] == successCode) {
          return true;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel['response_message']);
        }
      }
    } catch (e) {
      LoggerUtils.logException('removeCartItem', e);
    }
    return false;
  }

  Future<CartItemsResponseModel?> updateCartItemsApi(
      {required UpdateCartItemsRequestModel requestModel}) async {
    try {
      var response = await ApiService().putRequest(
          endPoint: ApiConst.updateCart,
          requestModel: updateCartItemsRequestModelToJson(requestModel));
      if (response != null) {
        var responseModel = cartItemsResponseModelFromJson(response.body);

        return responseModel;
      }
    } catch (e) {
      LoggerUtils.logException('updateCartItemsApi', e);
    }
    return null;
  }
}

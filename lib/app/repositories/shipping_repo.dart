import 'dart:convert';

import 'package:get/get.dart';
import 'package:tsofie/app/common/response_status_codes.dart';
import 'package:tsofie/app/screens/buyer/cart/shipping_details/shipping_addresses/model/request/add_shipping_address_request_model.dart';
import 'package:tsofie/app/screens/buyer/cart/shipping_details/shipping_addresses/model/response/shipping_address_response_model.dart';
import 'package:tsofie/app/services/api_constants.dart';
import 'package:tsofie/app/services/api_services.dart';
import 'package:tsofie/app/utils/alert_message_utils.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class ShippingRepo {
  Future<ShippingAddressResponseModel?> getShippingAddressApi() async {
    try {
      var response =
          await ApiService().getRequest(endPoint: ApiConst.shippingAddressList);
      if (response != null) {
        var responseModel = shippingAddressResponseModelFromJson(response.body);

        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          // Get.find<AlertMessageUtils>()
          //     .showSnackBar(message: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('getShippingAddressApi', e);
    }
    return null;
  }

  Future<bool?> addShippingAddressApi(
      {required AddShippingAddressRequestModel requestModel}) async {
    try {
      var response = await ApiService().postRequest(
          endPoint: ApiConst.shippingAddressList,
          requestModel: addShippingAddressRequestModelToJson(requestModel));

      if (response != null) {
        var responseModel = jsonDecode(response.body);
        if (responseModel['response_code'] == successCode) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      LoggerUtils.logException('addShippingAddressApi', e);
    }
    return false;
  }

  Future<bool?> updateShippingAddressApi(
      {required int id,
      required AddShippingAddressRequestModel requestModel}) async {
    try {
      var response = await ApiService().putRequest(
        endPoint: '${ApiConst.shippingAddressList}/$id',
        requestModel: addShippingAddressRequestModelToJson(requestModel),
      );

      if (response != null) {
        var responseModel = jsonDecode(response.body);
        if (responseModel['response_code'] == successCode) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      LoggerUtils.logException('addShippingAddressApi', e);
    }
    return false;
  }
}

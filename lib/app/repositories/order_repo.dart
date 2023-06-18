import 'dart:convert';

import 'package:get/get.dart';
import 'package:tsofie/app/common/response_status_codes.dart';
import 'package:tsofie/app/screens/buyer/cart/order_summary/model/request/create_order_request_model.dart';
import 'package:tsofie/app/screens/buyer/dashboard/order/base/model/response/orders_response_model.dart';
import 'package:tsofie/app/services/api_constants.dart';
import 'package:tsofie/app/services/api_services.dart';
import 'package:tsofie/app/utils/alert_message_utils.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class OrderRepo {
  Future<bool?> createOrderApi(
      {required CreateOrderRequestModel requestModel}) async {
    try {
      var response = await ApiService().postRequest(
          endPoint: ApiConst.createOrder,
          requestModel: createOrderRequestModelToJson(requestModel));

      if (response != null) {
        var responseModel = jsonDecode(response.body);
        if (responseModel['response_code'] == successCode) {
          return true;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel['response_message']);
          return false;
        }
      }
    } catch (e) {
      LoggerUtils.logException('createOrderApi', e);
    }
    return false;
  }

  Future<OrdersResponseModel?> getOrdersFromServer({required bool isLatest}) async {
    try {
      var response =
          await ApiService().getRequest(endPoint: '${ApiConst.getOrdersList}?isLatest=$isLatest');

      if (response != null) {
        var responseModel = ordersResponseModelFromJson(response.body);

        if (responseModel.responseCode == successCode) {
          return responseModel;
        }
      }
    } catch (e) {
      LoggerUtils.logException('getOrdersFromServer', e);
    }
    return null;
  }

  Future<OrdersResponseModel?> getRecentOrdersList() async {
    try {
      var response =
          await ApiService().getRequest(endPoint: ApiConst.getRecentOrdersList);

      if (response != null) {
        var responseModel = ordersResponseModelFromJson(response.body);

        if (responseModel.responseCode == successCode) {
          return responseModel;
        }
      }
    } catch (e) {
      LoggerUtils.logException('getRecentOrdersFromServer', e);
    }
    return null;
  }
}

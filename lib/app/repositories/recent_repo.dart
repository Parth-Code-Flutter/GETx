import 'package:tsofie/app/screens/seller/dashboard/RecentBuyers/model/s_recent_buyers_list_model.dart';
import 'package:tsofie/app/screens/seller/dashboard/order/model/order_list_response_model.dart';

import '../common/response_status_codes.dart';
import '../services/api_constants.dart';
import '../services/api_services.dart';
import '../utils/logger_utils.dart';

class RecentRepo{
  Future<RecentBuyersResponseModel?> getRecentBuyersList({required int page}) async {
    try {
      var response = await ApiService().getRequest(
          endPoint:
          ApiConst.recentBuyers); /// update : locationList in appCosnt file

      if (response != null) {
        var responseModel = recentBuyersResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode) {
          print("response recent buyers :: ${response.body}");
          return responseModel;
        } else {
          // Get.find<AlertMessageUtils>()
          //     .showSnackBar(message: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('RecentProductsList', e);
    }
    return null;
  }
  Future<OrderResponseModel?> getOrderList({required int page,required bool isLatest}) async {
    try {
      var response = await ApiService().getRequest(
          endPoint:
          '${ApiConst.recentOrders}?isLatest=$isLatest');

      if (response != null) {
        var responseModel = recentOrderResponseModelFromJson(response.body);
        print('Order List ${response.body}');
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          // Get.find<AlertMessageUtils>()
          //     .showSnackBar(message: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('getOrderList', e);
    }
    return null;
  }
}
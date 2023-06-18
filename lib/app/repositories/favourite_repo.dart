import 'package:get/get.dart';
import 'package:tsofie/app/common/response_status_codes.dart';
import 'package:tsofie/app/screens/buyer/dashboard/product/base/model/response/product_list_response_model.dart';
import 'package:tsofie/app/services/api_constants.dart';
import 'package:tsofie/app/services/api_services.dart';
import 'package:tsofie/app/utils/alert_message_utils.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class FavouriteRepo {
  Future<ProductListResponseModel?> getFavouriteProductListApiCall(
      ) async {
    try {
      var response = await ApiService().getRequest(
          endPoint: ApiConst.favouriteProductList);

      if (response != null) {
        var responseModel = productListResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode ||
            responseModel.responseCode == noDataFoundCode) {
          return responseModel;
        } else {
          // Get.find<AlertMessageUtils>()
          //     .showSnackBar(message: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('getFavouriteProductListApiCall', e);
    }
    return null;
  }
}

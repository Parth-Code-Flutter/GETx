import 'package:get/get.dart';
import 'package:tsofie/app/common/response_status_codes.dart';
import 'package:tsofie/app/screens/buyer/location/base/model/response/location_response_model.dart';
import 'package:tsofie/app/services/api_constants.dart';
import 'package:tsofie/app/services/api_services.dart';
import 'package:tsofie/app/utils/alert_message_utils.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class LocationRepo {
  Future<LocationResponseModel?> getLocationList({required int page}) async {
    try {
      var response = await ApiService().getRequest(
          endPoint:
              '${ApiConst.locationList}?page=$page');

      if (response != null) {
        var responseModel = locationResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('getLocationList', e);
    }
    return null;
  }
}

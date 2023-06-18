import 'package:tsofie/app/common/model/response/banner_image_list_response_model.dart';
import 'package:tsofie/app/common/model/response/categories_list_model.dart';
import '../common/response_status_codes.dart';
import '../services/api_constants.dart';
import '../services/api_services.dart';
import '../utils/logger_utils.dart';

class BannerImgRepo{

  Future<BannerImageListResponseModel?> getBannerImgList({bool isShowLoader = true}) async {
    try {
      var response = await ApiService().getRequest(
          endPoint:
          ApiConst.bannersImgList,isShowLoader: isShowLoader); /// update : locationList in appCosnt file

      if (response != null) {
        var responseModel = bannerImageListResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          // Get.find<AlertMessageUtils>()
          //     .showSnackBar(message: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('getBannerImgList', e);
    }
    return null;
  }
}
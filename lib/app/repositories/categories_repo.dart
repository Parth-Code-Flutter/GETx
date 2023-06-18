import 'package:tsofie/app/common/model/response/GstResponseModel.dart';
import 'package:tsofie/app/common/model/response/categories_list_model.dart';
import '../common/response_status_codes.dart';
import '../services/api_constants.dart';
import '../services/api_services.dart';
import '../utils/logger_utils.dart';

class CategoriesRepo{

  Future<CategoriesListResponseModel?> getCategoriesList({required int page,bool isShowLoader = true}) async {
    try {
      var response = await ApiService().getRequest(
          endPoint:
          '${ApiConst.categoriesList}?page=$page',isShowLoader: isShowLoader); /// update : locationList in appCosnt file

      if (response != null) {
        var responseModel = categoriesListResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          // Get.find<AlertMessageUtils>()
          //     .showSnackBar(message: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('getCategoriesList', e);
    }
    return null;
  }
  Future<GstResponseDataModel?> getGstList() async {
    try {
      var response = await ApiService().getRequest(
          endPoint:
          ApiConst.gstList); /// update : locationList in appCosnt file

      if (response != null) {
        var responseModel = gstListResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          // Get.find<AlertMessageUtils>()
          //     .showSnackBar(message: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('getCategoriesList', e);
    }
    return null;
  }
}
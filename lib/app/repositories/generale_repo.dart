import 'package:tsofie/app/common/model/response/general_response_model.dart';
import 'package:tsofie/app/common/response_status_codes.dart';
import 'package:tsofie/app/services/api_constants.dart';
import 'package:tsofie/app/services/api_services.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class GeneralRepo {
  Future<GeneralResponseModel?> getGeneraDataFromServer() async {
    try {
      var response = await ApiService().getRequest(endPoint: ApiConst.generalApi);

      if( response!=null && response.statusCode ==successCode ){
        var responseModel = generalResponseModelFromJson(response.body);
        if(responseModel.responseCode == successCode){
          return responseModel;
        }
      }
    } catch (e) {
      LoggerUtils.logException('getGeneraDataFromServer', e);
    }
    return null;
  }
}

import 'package:get/get.dart';
import 'package:tsofie/app/common/model/response/city_response_model.dart';
import 'package:tsofie/app/common/model/response/state_response_model.dart';
import 'package:tsofie/app/common/response_status_codes.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/edit_profile/model/request/edit_profile_request_model.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/edit_profile/model/response/edit_profile_response_model.dart';
import 'package:tsofie/app/services/api_constants.dart';
import 'package:tsofie/app/services/api_services.dart';
import 'package:tsofie/app/utils/alert_message_utils.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

import '../screens/seller/dashboard/more/get_profile_seller/response/get_profile_response_model.dart';

class UserRepository {
  Future<EditProfileResponseModel?> editUserProfileWithMultiPart({
    required EditProfileRequestModel requestModel,
    required String imagePath,
    required String imgExtension,
    bool isBuyerProfileUpdate = true,
  }) async {
    var response = await ApiService().putRequestWithMultiPart(
        endPoint: isBuyerProfileUpdate
            ? ApiConst.editProfile
            : ApiConst.editProfileSeller,
        imagePath: imagePath,
        imgExtension: imgExtension,
        isBuyerProfileUpdate: isBuyerProfileUpdate,
        // requestModel: editProfileRequestModelToJson(requestModel));
        requestModel: requestModel);

    if (response != null) {
      var responseModel = editProfileResponseModelFromJson(response.body);

      if (responseModel.responseCode == successCode) {
        return responseModel;
      } else {
        Get.find<AlertMessageUtils>()
            .showToastMessages(msg: responseModel.responseMessage ?? '');
      }
    }
    try {} catch (e) {
      LoggerUtils.logException('editUserProfileWithMultiPart', e);
    }
    return null;
  }

  Future<EditProfileResponseModel?> getUserProfileApi() async {
    try {
      var response =
          await ApiService().getRequest(endPoint: ApiConst.getBuyerProfile);
      if (response != null) {
        var responseModel = editProfileResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('getUserProfileApi', e);
    }
    return null;
  }

  Future<GetProfileResponseModel?> getProfile() async {
    try {
      var response =
          await ApiService().getRequest(endPoint: ApiConst.getProfile);

      /// update : locationList in appCosnt file

      if (response != null) {
        var responseModel = getProfileResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode) {
          print('GET PROFILE RESPONSE DATA :: ${response.body}');
          return responseModel;
        } else {
          // Get.find<AlertMessageUtils>()
          //     .showSnackBar(message: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('getProfile', e);
    }
    return null;
  }

  Future<StateResponseModel?> getStateDataApi(
      {required String countryCode}) async {
    try {
      var response = await ApiService().getRequest(
          endPoint: '${ApiConst.stateList}?country_code=$countryCode');

      if (response != null) {
        var responseModel = stateResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('getStateDataApi', e);
    }
    return null;
  }

  Future<CityResponseModel?> getCityDataApi(
      {required String countryCode, required String stateCode}) async {
    try {
      var response = await ApiService().getRequest(
          endPoint:
              '${ApiConst.cityList}?country_code=$countryCode&state_code=$stateCode');

      if (response != null) {
        var responseModel = cityResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('getStateDataApi', e);
    }
    return null;
  }
}

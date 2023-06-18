import 'package:get/get.dart';
import 'package:tsofie/app/common/response_status_codes.dart';
import 'package:tsofie/app/screens/authentication/buyer_auth/registration_as_buyer/model/request/buyer_reg_requset_model.dart';
import 'package:tsofie/app/screens/authentication/buyer_auth/registration_as_buyer/model/response/buyer_reg_response_model.dart';
import 'package:tsofie/app/screens/authentication/seller_auth/login_as_seller/model/request/seller_login_req_model.dart';
import 'package:tsofie/app/screens/authentication/seller_auth/otp_seller/model/request/s_otp_verification_request_model.dart';
import 'package:tsofie/app/screens/authentication/seller_auth/regsitration_as_seller/model/request/seller_reg_request_model.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/edit_profile/model/request/edit_profile_request_model.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/edit_profile/model/response/edit_profile_response_model.dart';
import 'package:tsofie/app/services/api_constants.dart';
import 'package:tsofie/app/services/api_services.dart';
import 'package:tsofie/app/utils/alert_message_utils.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

import '../common/app_constants.dart';
import '../common/model/request/GSTnumberRequestModel.dart';
import '../common/model/response/GSTnumberResponseModel.dart';
import '../screens/authentication/buyer_auth/login_as_buyer/model/request/buyer_login_req_model.dart';
import '../screens/authentication/buyer_auth/login_as_buyer/model/response/buyer_login_response_model.dart';
import '../screens/authentication/seller_auth/login_as_seller/model/response/seller_login_response_model.dart';
import '../screens/authentication/seller_auth/otp_seller/model/response/s_otp_verification_response_model.dart';
import '../screens/authentication/seller_auth/regsitration_as_seller/model/response/seller_reg_response_model.dart';

class AuthRepo {
  Future<BuyerRegResponseModel?> buyerRegApi(
      {required BuyerRegRequestModel requestModel}) async {
    try {
      var response = await ApiService().postRequest(
        endPoint: ApiConst.buyerReg,
        requestModel: buyerRegRequestModelToJson(requestModel),
      );
      if (response != null) {
        var responseModel = buyerRegResponseModelFromJson(response.body ?? '');
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('buyerRegApi', e);
      Get.find<AlertMessageUtils>().showToastMessages(msg: kError);
    }
    return null;
  }

  Future<EditProfileResponseModel?> editProfileBuyerApi(
      {required EditProfileRequestModel requestModel}) async {
    try {
      var response = await ApiService().putRequest(
        endPoint: ApiConst.editProfile,
        requestModel: editProfileRequestModelToJson(requestModel),
      );
      if (response != null) {
        var responseModel =
            editProfileResponseModelFromJson(response.body ?? '');
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('Edit Profile Api', e);
      Get.find<AlertMessageUtils>().showToastMessages(msg: kError);
    }
    return null;
  }

  Future<EditProfileResponseModel?> editProfileSellerApi(
      {required EditProfileRequestModel requestModel}) async {
    try {
      var response = await ApiService().putRequest(
        endPoint: ApiConst.editProfileSeller,
        requestModel: editProfileRequestModelToJson(requestModel),
      );
      if (response != null) {
        var responseModel =
            editProfileResponseModelFromJson(response.body ?? '');
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('Edit Profile Api', e);
      Get.find<AlertMessageUtils>().showToastMessages(msg: kError);
    }
    return null;
  }

  Future<SellerRegResponseModel?> sellerRegApi({
    required SellerRegRequestModel requestModel,
    required String imagePath,
    required String imgExtension,
  }) async {
    try {
      // var response = await ApiService().postRequest(
      //   endPoint: ApiConst.sellerReg,
      //   requestModel: sellerRegRequestModelToJson(requestModel),
      // );
      var response = await ApiService().postRequestWithMultiPart(
        endPoint: ApiConst.sellerReg,
        imagePath: imagePath,
        imgExtension: imgExtension,
        requestModel: requestModel,
      );
      if (response != null) {
        var responseModel = sellerRegResponseModelFromJson(response.body ?? '');
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('sellerRegApi', e);
      Get.find<AlertMessageUtils>().showToastMessages(msg: kError);
    }
    return null;
  }

  Future<BuyerLoginResponseDatamodel?> buyerLoginApi(
      {required BuyerLoginRequestModel requestModel}) async {
    try {
      var response = await ApiService().postRequest(
        endPoint: ApiConst.login,
        requestModel: buyerLoginRequestModelToJson(requestModel),
      );
      if (response != null) {
        var responseModel =
            buyerLoginResponseModelFromJson(response.body ?? '');
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('buyerLoginApi', e);
      Get.find<AlertMessageUtils>().showToastMessages(msg: kError);
    }
    return null;
  }

  Future<GSTnumberResponseModel?> gSTNumberApi(
      {required SellerGstNumberRequestModel requestModel}) async {
    try {
      var response = await ApiService().postRequest(
        endPoint: ApiConst.gstNumber,
        requestModel: sellerGstNumberRequestModelToJson(requestModel),
      );
      if (response != null) {
        var responseModel =
            sellerGstNumberResponseModelFromJson(response.body ?? '');
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('sellerGSTNumberApi', e);
      Get.find<AlertMessageUtils>().showToastMessages(msg: kError);
    }
    return null;
  }

  Future<SellerLoginResponseDatamodel?> sellerLoginApi(
      {required SellerLoginRequestModel requestModel}) async {
    try {
      var response = await ApiService().postRequest(
        endPoint: ApiConst.login,
        requestModel: sellerLoginRequestModelToJson(requestModel),
      );
      if (response != null) {
        var responseModel =
            sellerLoginResponseModelFromJson(response.body ?? '');
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('sellerLoginApi', e);
      Get.find<AlertMessageUtils>().showToastMessages(msg: kError);
    }
    return null;
  }

  Future<OTPVerificationResponsemodel?> sOtpVerificationApi(
      {required SellerOTPRequestModel requestModel}) async {
    try {
      var response = await ApiService().postRequest(
        endPoint: ApiConst.otp,
        requestModel: sOtpRequestModelToJson(requestModel),
      );
      if (response != null) {
        var responseModel =
            OTPVerificationResponseModelFromJson(response.body ?? '');
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('sellerOTPApi', e);
      Get.find<AlertMessageUtils>().showToastMessages(msg: kError);
    }
    return null;
  }

  Future<OTPVerificationResponsemodel?> sResendOtpApi(
      {required SellerOTPRequestModel requestModel}) async {
    try {
      var response = await ApiService().postRequest(
        endPoint: ApiConst.reSendOTP,
        requestModel: sOtpRequestModelToJson(requestModel),
      );
      if (response != null) {
        var responseModel =
            OTPVerificationResponseModelFromJson(response.body ?? '');
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('sellerResendOTPApi', e);
      Get.find<AlertMessageUtils>().showToastMessages(msg: kError);
    }
    return null;
  }

  Future<OTPVerificationResponsemodel?> bOtpVerificationApi(
      {required SellerOTPRequestModel requestModel}) async {
    try {
      var response = await ApiService().postRequest(
        endPoint: ApiConst.otp,
        requestModel: sOtpRequestModelToJson(requestModel),
      );
      if (response != null) {
        var responseModel =
            OTPVerificationResponseModelFromJson(response.body ?? '');
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('buyerOTPApi', e);
      Get.find<AlertMessageUtils>().showToastMessages(msg: kError);
    }
    return null;
  }

  Future<OTPVerificationResponsemodel?> bResendOTPapi(
      {required SellerOTPRequestModel requestModel}) async {
    try {
      var response = await ApiService().postRequest(
        endPoint: ApiConst.reSendOTP,
        requestModel: sOtpRequestModelToJson(requestModel),
      );
      if (response != null) {
        var responseModel =
            OTPVerificationResponseModelFromJson(response.body ?? '');
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('buyerOTPApi', e);
      Get.find<AlertMessageUtils>().showToastMessages(msg: kError);
    }
    return null;
  }
}

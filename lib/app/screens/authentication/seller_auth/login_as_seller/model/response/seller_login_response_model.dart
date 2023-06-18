import 'dart:convert';

SellerLoginResponseDatamodel sellerLoginResponseModelFromJson(String str) =>
    SellerLoginResponseDatamodel.fromJson(json.decode(str));
class SellerLoginResponseDatamodel {
  int? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  SellerLoginResponseDatamodel(
      {this.responseCode, this.responseMessage, this.responseData});

  SellerLoginResponseDatamodel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    responseData = json['response_data'] != null
        ? new ResponseData.fromJson(json['response_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_message'] = this.responseMessage;
    if (this.responseData != null) {
      data['response_data'] = this.responseData!.toJson();
    }
    return data;
  }
}

class ResponseData {
  int? otp;
  String? token;

  ResponseData({this.otp, this.token});

  ResponseData.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['token'] = this.token;
    return data;
  }
}
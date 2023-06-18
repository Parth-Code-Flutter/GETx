import 'dart:convert';

GSTnumberResponseModel sellerGstNumberResponseModelFromJson(String str) =>
    GSTnumberResponseModel.fromJson(json.decode(str));
class GSTnumberResponseModel {
  int? responseCode;
  String? responseMessage;
  bool? flag;

  GSTnumberResponseModel({this.responseCode, this.responseMessage, this.flag});

  GSTnumberResponseModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_message'] = this.responseMessage;
    data['flag'] = this.flag;
    return data;
  }
}

// To parse this JSON data, do
//
//     final generalResponseModel = generalResponseModelFromJson(jsonString);

import 'dart:convert';

GeneralResponseModel generalResponseModelFromJson(String str) =>
    GeneralResponseModel.fromJson(json.decode(str));

class GeneralResponseModel {
  int? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  GeneralResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  factory GeneralResponseModel.fromJson(Map<String, dynamic> json) =>
      GeneralResponseModel(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        responseData: json["response_data"] == null
            ? null
            : ResponseData.fromJson(json["response_data"]),
      );
}

class ResponseData {
  int? totalCartCount;

  ResponseData({
    this.totalCartCount,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        totalCartCount: json["total_cart_count"],
      );
}

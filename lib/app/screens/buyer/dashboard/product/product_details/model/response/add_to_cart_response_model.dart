// To parse this JSON data, do
//
//     final addToCartResponseModel = addToCartResponseModelFromJson(jsonString);

import 'dart:convert';

AddToCartResponseModel addToCartResponseModelFromJson(String str) =>
    AddToCartResponseModel.fromJson(json.decode(str));

class AddToCartResponseModel {
  AddToCartResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  int? responseCode;
  String? responseMessage;
  AddToCartResponseData? responseData;

  factory AddToCartResponseModel.fromJson(Map<String, dynamic> json) =>
      AddToCartResponseModel(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        responseData: json["response_data"] == null
            ? null
            : AddToCartResponseData.fromJson(json["response_data"]),
      );
}

class AddToCartResponseData {
  AddToCartResponseData({
    this.totalCartCount,
  });

  int? totalCartCount;

  factory AddToCartResponseData.fromJson(Map<String, dynamic> json) =>
      AddToCartResponseData(
        totalCartCount: json["total_cart_count"],
      );
}

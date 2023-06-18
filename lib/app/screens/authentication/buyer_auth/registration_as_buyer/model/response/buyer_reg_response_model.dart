// To parse this JSON data, do
//
//     final buyerRegResponseModel = buyerRegResponseModelFromJson(jsonString);

import 'dart:convert';

BuyerRegResponseModel buyerRegResponseModelFromJson(String str) =>
    BuyerRegResponseModel.fromJson(json.decode(str));

class BuyerRegResponseModel {
  BuyerRegResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  int? responseCode;
  String? responseMessage;
  BuyerRegData? responseData;

  factory BuyerRegResponseModel.fromJson(Map<String, dynamic> json) =>
      BuyerRegResponseModel(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        responseData: json["response_data"] == null
            ? null
            : BuyerRegData.fromJson(json["response_data"]),
      );
}

class BuyerRegData {
  BuyerRegData({
    this.id,
    this.mobileCode,
    this.mobileNumber,
    this.name,
    this.profilePic,
    this.token,
    this.otp,
  });

  int? id;
  String? mobileCode;
  String? mobileNumber;
  String? name;
  dynamic profilePic;
  String? token;
  int? otp;

  factory BuyerRegData.fromJson(Map<String, dynamic> json) => BuyerRegData(
        id: json["id"],
        mobileCode: json["mobile_code"],
        mobileNumber: json["mobile_number"],
        name: json["name"],
        profilePic: json["profile_pic"],
        token: json["token"],
        otp: json["otp"],
      );
}

// To parse this JSON data, do
//
//     final buyerRegRequestModel = buyerRegRequestModelFromJson(jsonString);

import 'dart:convert';

BuyerRegRequestModel buyerRegRequestModelFromJson(String str) => BuyerRegRequestModel.fromJson(json.decode(str));

String buyerRegRequestModelToJson(BuyerRegRequestModel data) => json.encode(data.toJson());

class BuyerRegRequestModel {
  BuyerRegRequestModel({
    this.name,
    this.mobileCode,
    this.mobileNumber,
    this.email,
  });

  String? name;
  String? mobileCode;
  String? mobileNumber;
  String? email;

  factory BuyerRegRequestModel.fromJson(Map<String, dynamic> json) => BuyerRegRequestModel(
    name: json["name"],
    mobileCode: json["mobile_code"],
    mobileNumber: json["mobile_number"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile_code": mobileCode,
    "mobile_number": mobileNumber,
    "email": email,
  };
}

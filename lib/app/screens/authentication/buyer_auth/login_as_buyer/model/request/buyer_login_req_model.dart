import 'dart:convert';

BuyerLoginRequestModel buyerLoginRequestModelFromJson(String str) => BuyerLoginRequestModel.fromJson(json.decode(str));

String buyerLoginRequestModelToJson(BuyerLoginRequestModel data) => json.encode(data.toJson());

class BuyerLoginRequestModel {
  BuyerLoginRequestModel({
    this.mobileCode,
    this.mobileNumber,
    this.role
  });

  String? mobileCode;
  String? mobileNumber;
  String? role;

  factory BuyerLoginRequestModel.fromJson(Map<String, dynamic> json) => BuyerLoginRequestModel(
    mobileCode: json["mobile_code"],
    mobileNumber: json["mobile_number"],
    role:json["role"],
  );

  Map<String, dynamic> toJson() => {
    "mobile_code": mobileCode,
    "mobile_number": mobileNumber,
    "role":role,
  };
}

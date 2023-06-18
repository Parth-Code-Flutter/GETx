import 'dart:convert';

SellerLoginRequestModel sellerLoginRequestModelFromJson(String str) => SellerLoginRequestModel.fromJson(json.decode(str));

String sellerLoginRequestModelToJson(SellerLoginRequestModel data) => json.encode(data.toJson());

class SellerLoginRequestModel {
  SellerLoginRequestModel({
    this.mobileCode,
    this.mobileNumber,
    this.role
  });

  String? mobileCode;
  String? mobileNumber;
  String? role;

  factory SellerLoginRequestModel.fromJson(Map<String, dynamic> json) => SellerLoginRequestModel(
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

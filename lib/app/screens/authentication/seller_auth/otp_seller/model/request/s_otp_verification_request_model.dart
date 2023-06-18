import 'dart:convert';

SellerOTPRequestModel sOtpRequestModelFromJson(String str) => SellerOTPRequestModel.fromJson(json.decode(str));

String sOtpRequestModelToJson(SellerOTPRequestModel data) => json.encode(data.toJson());

class SellerOTPRequestModel {
  SellerOTPRequestModel({
    this.mobileCode,
    this.mobileNumber,
    this.role,
    this.otp
  });

  String? mobileCode;
  String? mobileNumber;
  String? role;
  String? otp;

  factory SellerOTPRequestModel.fromJson(Map<String, dynamic> json) => SellerOTPRequestModel(
    mobileCode: json["mobile_code"],
    mobileNumber: json["mobile_number"],
    role:json["role"],
    otp:json['otp']
  );

  Map<String, dynamic> toJson() => {
    "mobile_code": mobileCode,
    "mobile_number": mobileNumber,
    "role":role,
    "otp":otp
  };
}

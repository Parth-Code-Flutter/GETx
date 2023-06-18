import 'dart:convert';

SellerRegRequestModel sellerRegRequestModelFromJson(String str) => SellerRegRequestModel.fromJson(json.decode(str));

String sellerRegRequestModelToJson(SellerRegRequestModel data) => json.encode(data.toJson());

class SellerRegRequestModel {
  SellerRegRequestModel({
    this.name,
    this.mobileCode,
    this.mobileNumber,
    this.companyName,
    this.gstNumber,
  });

  String? name;
  String? mobileCode;
  String? mobileNumber;
  String? companyName;
  String? gstNumber;

  factory SellerRegRequestModel.fromJson(Map<String, dynamic> json) => SellerRegRequestModel(
    name: json["name"],
    mobileCode: json["mobile_code"],
    mobileNumber: json["mobile_number"],
    companyName:json["company_name"],
    gstNumber: json["gst_number"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile_code": mobileCode,
    "mobile_number": mobileNumber,
    "company_name":companyName,
    "gst_number":gstNumber,
  };
}

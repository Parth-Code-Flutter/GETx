
import 'dart:convert';

SellerGstNumberRequestModel sellerGstNumberRequestModelFromJson(String str) => SellerGstNumberRequestModel.fromJson(json.decode(str));

String sellerGstNumberRequestModelToJson(SellerGstNumberRequestModel data) => json.encode(data.toJson());

class SellerGstNumberRequestModel {
  SellerGstNumberRequestModel({
    this.gst_number,
  });

  String? gst_number;

  factory SellerGstNumberRequestModel.fromJson(Map<String, dynamic> json) => SellerGstNumberRequestModel(
    gst_number: json["gst_number"],
  );

  Map<String, dynamic> toJson() => {
    "gst_number": gst_number,
  };
}

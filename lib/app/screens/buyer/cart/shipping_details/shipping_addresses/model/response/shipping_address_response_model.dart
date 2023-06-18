// To parse this JSON data, do
//
//     final shippingAddressResponseModel = shippingAddressResponseModelFromJson(jsonString);

import 'dart:convert';

ShippingAddressResponseModel shippingAddressResponseModelFromJson(String str) =>
    ShippingAddressResponseModel.fromJson(json.decode(str));

class ShippingAddressResponseModel {
  int? responseCode;
  String? responseMessage;
  ShippingResponseData? responseData;

  ShippingAddressResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  factory ShippingAddressResponseModel.fromJson(Map<String, dynamic> json) =>
      ShippingAddressResponseModel(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        responseData: json["response_data"] == null
            ? null
            : ShippingResponseData.fromJson(json["response_data"]),
      );
}

class ShippingResponseData {
  List<ShippingAddressData>? addresses;

  ShippingResponseData({
    this.addresses,
  });

  factory ShippingResponseData.fromJson(Map<String, dynamic> json) =>
      ShippingResponseData(
        addresses: List<ShippingAddressData>.from(
            json["addresses"].map((x) => ShippingAddressData.fromJson(x))),
      );
}

class ShippingAddressData {
  int? id;
  String? streetAddress;
  String? city;
  String? state;
  String? pincode;

  // dynamic lat;
  // dynamic lng;
  bool? isDefault;

  ShippingAddressData({
    this.id,
    this.streetAddress,
    this.city,
    this.state,
    this.pincode,
    // this.lat,
    // this.lng,
    this.isDefault,
  });

  factory ShippingAddressData.fromJson(Map<String, dynamic> json) =>
      ShippingAddressData(
        id: json["id"],
        streetAddress: json["street_address"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        // lat: json["lat"],
        // lng: json["lng"],
        isDefault: json["is_default"]=false,
      );
}

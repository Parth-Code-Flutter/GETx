// To parse this JSON data, do
//
//     final addShippingAddressRequestModel = addShippingAddressRequestModelFromJson(jsonString);

import 'dart:convert';

AddShippingAddressRequestModel addShippingAddressRequestModelFromJson(String str) => AddShippingAddressRequestModel.fromJson(json.decode(str));

String addShippingAddressRequestModelToJson(AddShippingAddressRequestModel data) => json.encode(data.toJson());

class AddShippingAddressRequestModel {
  String? streetAddress;
  String? city;
  String? state;
  String? pincode;
  bool? isDefault;

  AddShippingAddressRequestModel({
    this.streetAddress,
    this.city,
    this.state,
    this.pincode,
    this.isDefault,
  });

  factory AddShippingAddressRequestModel.fromJson(Map<String, dynamic> json) => AddShippingAddressRequestModel(
    streetAddress: json["street_address"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    isDefault: json["is_default"],
  );

  Map<String, dynamic> toJson() => {
    "street_address": streetAddress,
    "city": city,
    "state": state,
    "pincode": pincode,
    "is_default": isDefault,
  };
}

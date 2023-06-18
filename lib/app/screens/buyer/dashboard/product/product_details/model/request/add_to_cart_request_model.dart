// To parse this JSON data, do
//
//     final addToCartRequestModel = addToCartRequestModelFromJson(jsonString);

import 'dart:convert';

AddToCartRequestModel addToCartRequestModelFromJson(String str) => AddToCartRequestModel.fromJson(json.decode(str));

String addToCartRequestModelToJson(AddToCartRequestModel data) => json.encode(data.toJson());

class AddToCartRequestModel {
  AddToCartRequestModel({
    this.productVariantId,
    this.quantity,
  });

  int? productVariantId;
  int? quantity;

  factory AddToCartRequestModel.fromJson(Map<String, dynamic> json) => AddToCartRequestModel(
    productVariantId: json["product_variant_id"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "product_variant_id": productVariantId,
    "quantity": quantity,
  };
}

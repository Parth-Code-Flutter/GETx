// To parse this JSON data, do
//
//     final updateCartItemsRequestModel = updateCartItemsRequestModelFromJson(jsonString);

import 'dart:convert';

UpdateCartItemsRequestModel updateCartItemsRequestModelFromJson(String str) => UpdateCartItemsRequestModel.fromJson(json.decode(str));

String updateCartItemsRequestModelToJson(UpdateCartItemsRequestModel data) => json.encode(data.toJson());

class UpdateCartItemsRequestModel {
  UpdateCartItemsRequestModel({
    this.carts,
  });

  List<Cart>? carts;

  factory UpdateCartItemsRequestModel.fromJson(Map<String, dynamic> json) => UpdateCartItemsRequestModel(
    carts: List<Cart>.from(json["carts"].map((x) => Cart.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "carts": List<dynamic>.from((carts??[]).map((x) => x.toJson())),
  };
}

class Cart {
  Cart({
    this.cartId,
    this.quantity,
  });

  int? cartId;
  int? quantity;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    cartId: json["id"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": cartId,
    "quantity": quantity,
  };
}

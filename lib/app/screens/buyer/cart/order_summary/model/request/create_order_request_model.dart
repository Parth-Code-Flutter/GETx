// To parse this JSON data, do
//
//     final createOrderRequestModel = createOrderRequestModelFromJson(jsonString);

import 'dart:convert';

CreateOrderRequestModel createOrderRequestModelFromJson(String str) => CreateOrderRequestModel.fromJson(json.decode(str));

String createOrderRequestModelToJson(CreateOrderRequestModel data) => json.encode(data.toJson());

class CreateOrderRequestModel {
  Order? order;
  List<OrderProduct>? orderProducts;

  CreateOrderRequestModel({
    this.order,
    this.orderProducts,
  });

  factory CreateOrderRequestModel.fromJson(Map<String, dynamic> json) => CreateOrderRequestModel(
    order: Order.fromJson(json["order"]),
    orderProducts: List<OrderProduct>.from(json["order_products"].map((x) => OrderProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order": order?.toJson(),
    "order_products": List<dynamic>.from((orderProducts??[]).map((x) => x.toJson())),
  };
}

class Order {
  int? shippingAddressId;

  Order({
    this.shippingAddressId,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    shippingAddressId: json["shipping_address_id"],
  );

  Map<String, dynamic> toJson() => {
    "shipping_address_id": shippingAddressId,
  };
}

class OrderProduct {
  int? productVariantId;
  int? quantity;

  OrderProduct({
    this.productVariantId,
    this.quantity,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
    productVariantId: json["product_variant_id"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "product_variant_id": productVariantId,
    "quantity": quantity,
  };
}

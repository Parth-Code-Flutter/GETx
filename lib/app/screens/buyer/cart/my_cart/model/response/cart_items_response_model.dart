// To parse this JSON data, do
//
//     final cartItemsResponseModel = cartItemsResponseModelFromJson(jsonString);

import 'dart:convert';

CartItemsResponseModel cartItemsResponseModelFromJson(String str) =>
    CartItemsResponseModel.fromJson(json.decode(str));

class CartItemsResponseModel {
  CartItemsResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  int? responseCode;
  String? responseMessage;
  CartResponseData? responseData;

  factory CartItemsResponseModel.fromJson(Map<String, dynamic> json) =>
      CartItemsResponseModel(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        responseData: json["response_data"] == null
            ? null
            : CartResponseData.fromJson(json["response_data"]),
      );
}

class CartResponseData {
  CartResponseData({
    this.totalRecords,
    this.totalPages,
    this.currentPage,
    this.nextPage,
    this.cartItems,
    this.totalQty,
    this.totalPrice,
    this.totalGSTPerc,
    this.totalGSTPrice,
  });

  int? totalRecords;
  int? totalPages;
  int? currentPage;
  int? nextPage;
  List<CartData>? cartItems;
  int? totalQty;
  double? totalPrice;
  double? totalGSTPerc;
  double? totalGSTPrice;

  factory CartResponseData.fromJson(Map<String, dynamic> json) =>
      CartResponseData(
        totalRecords: json["total_records"] ?? 0,
        totalPages: json["total_pages"] ?? 0,
        currentPage: json["current_page"] ?? 0,
        nextPage: json["next_page"] ?? 0,
        cartItems:
            List<CartData>.from(json["carts"].map((x) => CartData.fromJson(x))),
        totalQty: json["totalQty"] = 0,
        totalPrice: json["totalPrice"] = 0.0,
        totalGSTPerc: json["totalGST"] = 0.0,
        totalGSTPrice: json["totalGSTPrice"] = 0.0,
      );
}

class CartData {
  CartData({
    this.cartId,
    this.quantity,
    this.sellerName,
    this.productName,
    this.productImage,
    this.category,
    this.productVariantId,
    this.size,
    this.stockQty,
    this.leftQty,
    this.price,
    this.discountedPrice,
    this.updatedDiscountPrice,
    this.gst,
    this.isOutOfStock,
  });

  int? cartId;
  int? quantity;
  String? sellerName;
  String? productName;
  String? productImage;
  String? category;
  int? productVariantId;
  String? size;
  int? stockQty;
  int? leftQty;
  String? price;
  String? discountedPrice;
  String? updatedDiscountPrice;
  int? gst;
  bool? isOutOfStock;

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
        cartId: json["cart_id"],
        quantity: json["quantity"] ?? 0,
        sellerName: json["seller_name"],
        productName: json["product_name"],
        productImage: json["product_image"],
        category: json["category"],
        productVariantId: json["product_variant_id"],
        size: json["size"],
        stockQty: json["stock_qty"],
        leftQty: json["left_qty"],
        price: json["price"],
        discountedPrice: json["discounted_price"],
        updatedDiscountPrice: json['updatedDiscountPrice'],
        gst: json["gst"],
        isOutOfStock: json["isOutOfStock"],
      );
}

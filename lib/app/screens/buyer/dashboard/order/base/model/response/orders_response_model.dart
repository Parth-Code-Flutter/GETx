// To parse this JSON data, do
//
//     final ordersResponseModel = ordersResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:tsofie/app/screens/buyer/dashboard/product/base/model/response/product_list_response_model.dart';

OrdersResponseModel ordersResponseModelFromJson(String str) =>
    OrdersResponseModel.fromJson(json.decode(str));

class OrdersResponseModel {
  int? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  OrdersResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  factory OrdersResponseModel.fromJson(Map<String, dynamic> json) =>
      OrdersResponseModel(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        responseData: json["response_data"] == null
            ? null
            : ResponseData.fromJson(json["response_data"]),
      );
}

class ResponseData {
  List<Order>? orders;

  ResponseData({
    this.orders,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );
}

class Order {
  OrderDetails? orderDetails;
  int? orderProductId;
  String? quantityPrice;
  int? quantity;
  String? totalPrice;
  int? gst;
  int? productVariantId;
  String? productVariantPrice;
  String? productVariantSize;
  bool? isVariant;
  String? productName;
  String? categoryName;
  int? categoryId;
  String? productVariantDiscountedPrice;
  String? specification;
  OrderShippingAddress? orderShippingAddress;
  SoldBy? soldBy;
  List<ProductImage>? productImages;

  Order({
    this.orderDetails,
    this.orderProductId,
    this.quantityPrice,
    this.quantity,
    this.totalPrice,
    this.gst,
    this.productVariantId,
    this.productVariantPrice,
    this.productVariantSize,
    this.isVariant,
    this.productName,
    this.categoryName,
    this.categoryId,
    this.specification,
    this.productVariantDiscountedPrice,
    this.orderShippingAddress,
    this.soldBy,
    this.productImages,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderDetails: OrderDetails.fromJson(json["order_deatails"]),
        orderProductId: json["order_product_id"],
        quantityPrice: json["quantity_price"],
        quantity: json["quantity"],
        totalPrice: json["total_price"],
        gst: json["gst"],
        productVariantId: json["product_variant_id"],
        productVariantPrice: json["product_variant_price"],
        productVariantSize: json["product_variant_size"],
        isVariant: json["is_variant"],
        productName: json["product_name"],
        categoryName: json["category_name"],
        categoryId: json["category_id"],
        specification: json["specification"],
        productVariantDiscountedPrice: json["product_variant_discounted_price"],
        orderShippingAddress:
            OrderShippingAddress.fromJson(json["order_shipping_address"]),
        soldBy: SoldBy.fromJson(json["sold_by"]),
        productImages: List<ProductImage>.from((json["product_images"] ?? [])
            .map((x) => ProductImage.fromJson(x))),
      );
}

class OrderDetails {
  int? orderId;
  String? orderNumber;
  String? grandTotalPrice;
  int? totalGstPercent;
  String? totalGstPrice;
  String? finalDiscountedPrice;
  String? orderStatus;
  String? orderCreatedAt;
  String? orderStatusDate;

  OrderDetails({
    this.orderId,
    this.orderNumber,
    this.grandTotalPrice,
    this.totalGstPercent,
    this.totalGstPrice,
    this.finalDiscountedPrice,
    this.orderStatus,
    this.orderCreatedAt,
    this.orderStatusDate,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        orderId: json["order_id"],
        orderNumber : json['order_number'],
        grandTotalPrice: json["grand_total_price"],
        totalGstPercent: json["total_gst_percent"],
        totalGstPrice: json["total_gst_price"],
        finalDiscountedPrice: json["final_discounted_price"],
        orderStatus: json["order_status"],
        orderCreatedAt: json["order_created_at"],
        orderStatusDate: json["order_status_date"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "order_number": orderNumber,
        "grand_total_price": grandTotalPrice,
        "total_gst_percent": totalGstPercent,
        "total_gst_price": totalGstPrice,
        "final_discounted_price": finalDiscountedPrice,
        "order_status": orderStatus,
        "order_created_at": orderCreatedAt,
        "order_status_date": orderStatusDate,
      };
}

class OrderShippingAddress {
  int? buyerId;
  String? streetAddress;
  String? city;
  String? state;
  String? pincode;

  OrderShippingAddress({
    this.buyerId,
    this.streetAddress,
    this.city,
    this.state,
    this.pincode,
  });

  factory OrderShippingAddress.fromJson(Map<String, dynamic> json) =>
      OrderShippingAddress(
        buyerId: json["buyer_id"],
        streetAddress: json["street_address"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "buyer_id": buyerId,
        "street_address": streetAddress,
        "city": city,
        "state": state,
        "pincode": pincode,
      };
}

class SoldBy {
  int? sellerId;
  String? sellerName;
  String? gstNumber;
  String? companyName;
  String? companyAddress;
  String? city;
  String? state;
  String? zipCode;

  SoldBy({
    this.sellerId,
    this.sellerName,
    this.gstNumber,
    this.companyName,
    this.companyAddress,
    this.city,
    this.state,
    this.zipCode,
  });

  factory SoldBy.fromJson(Map<String, dynamic> json) => SoldBy(
        sellerId: json["seller_id"],
    sellerName: json["seller_name"],
        gstNumber: json["gst_number"],
        companyName: json["company_name"],
        companyAddress: json["company_address"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zip_code"],
      );

  Map<String, dynamic> toJson() => {
        "seller_id": sellerId,
        "seller_name": sellerName,
        "gst_number": gstNumber,
        "company_name": companyName,
        "company_address": companyAddress,
        "city": city,
        "state": state,
        "zip_code": zipCode,
      };
}

import 'dart:convert';

OrderResponseModel recentOrderResponseModelFromJson(String str) =>
    OrderResponseModel.fromJson(json.decode(str));
class OrderResponseModel {
  int? responseCode;
  String? responseMessage;
  OrderResponseData? responseData;

  OrderResponseModel(
      {this.responseCode, this.responseMessage, this.responseData});

  OrderResponseModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    responseData = json['response_data'] != null
        ? new OrderResponseData.fromJson(json['response_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_message'] = this.responseMessage;
    if (this.responseData != null) {
      data['response_data'] = this.responseData!.toJson();
    }
    return data;
  }
}

class OrderResponseData {
  List<RecentOrders>? recentOrders;

  OrderResponseData({this.recentOrders});

  OrderResponseData.fromJson(Map<String, dynamic> json) {
    if (json['recent_orders'] != null) {
      recentOrders = <RecentOrders>[];
      json['recent_orders'].forEach((v) {
        recentOrders!.add(new RecentOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recentOrders != null) {
      data['recent_orders'] =
          this.recentOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class RecentOrders {
  int? orderId;
  String? orderNumber;
  String? orderCreatedAt;
  String? grandTotalPrice;
  int? totalGst;
  String? totalGstPrice;
  String? finalDiscountedPrice;
  String? orderStatus;
  String? orderStatusDate;
  int? buyerId;
  String? buyerName;
  String? buyerEmail;
  String? buyerMobileNumber;
  String? buyerProfilePic;
  int? buyerShippingAddressId;
  String? streetAddress;
  String? city;
  String? state;
  String? pincode;
  int? orderProductVariantId;
  int? orderProductVariantQuantity;
  String? orderProductVariantQuantityPrice;
  int? productVariantId;
  String? productVariantPrice;
  String? productVariantDiscountedPrice;
  String? productName;
  String? specification;
  int? gst;
  bool? isVariant;
  String? categoryName;
  int? categoryId;
  bool? isFavourite;
  List<ProductImages>? productImages;

  RecentOrders(
      {this.orderId,
        this.orderNumber,
        this.orderCreatedAt,
        this.grandTotalPrice,
        this.totalGst,
        this.totalGstPrice,
        this.finalDiscountedPrice,
        this.orderStatus,
        this.orderStatusDate,
        this.buyerId,
        this.buyerName,
        this.buyerEmail,
        this.buyerMobileNumber,
        this.buyerProfilePic,
        this.buyerShippingAddressId,
        this.streetAddress,
        this.city,
        this.state,
        this.pincode,
        this.orderProductVariantId,
        this.orderProductVariantQuantity,
        this.orderProductVariantQuantityPrice,
        this.productVariantId,
        this.productVariantPrice,
        this.productVariantDiscountedPrice,
        this.productName,
        this.specification,
        this.gst,
        this.isVariant,
        this.categoryName,
        this.categoryId,
        this.isFavourite,
        this.productImages});

  RecentOrders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderNumber = json['order_number'];
    orderCreatedAt = json['order_created_at'];
    grandTotalPrice = json['grand_total_price'];
    totalGst = json['total_gst'];
    totalGstPrice = json['total_gst_price'];
    finalDiscountedPrice = json['final_discounted_price'];
    orderStatus = json['order_status'];
    orderStatusDate= json["order_status_date"];
    buyerId = json['buyer_id'];
    buyerName = json['buyer_name'];
    buyerEmail = json['buyer_email'];
    buyerMobileNumber = json['buyer_mobile_number'];
    buyerProfilePic = json['buyer_profile_pic'];
    buyerShippingAddressId = json['buyer_shipping_address_id'];
    streetAddress = json['street_address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    orderProductVariantId = json['order_product_variant_id'];
    orderProductVariantQuantity = json['order_product_variant_quantity'];
    orderProductVariantQuantityPrice =
    json['order_product_variant_quantity_price'];
    productVariantId = json['product_variant_id'];
    productVariantPrice = json['product_variant_price'];
    productVariantDiscountedPrice = json['product_variant_discounted_price'];
    productName = json['product_name'];
    specification = json['specification'];
    gst = json['gst'];
    isVariant = json['is_variant'];
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    isFavourite = json['is_favourite'];
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_number'] = this.orderNumber;
    data['order_created_at'] = this.orderCreatedAt;
    data['grand_total_price'] = this.grandTotalPrice;
    data['total_gst'] = this.totalGst;
    data['total_gst_price'] = this.totalGstPrice;
    data['final_discounted_price'] = this.finalDiscountedPrice;
    data['order_status'] = this.orderStatus;
    data['order_status_date'] = this.orderStatusDate;
    data['buyer_id'] = this.buyerId;
    data['street_address'] = this.streetAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['order_product_variant_id'] = this.orderProductVariantId;
    data['order_product_variant_quantity'] = this.orderProductVariantQuantity;
    data['order_product_variant_quantity_price'] =
        this.orderProductVariantQuantityPrice;
    data['product_variant_id'] = this.productVariantId;
    data['product_variant_price'] = this.productVariantPrice;
    data['product_variant_discounted_price'] =
        this.productVariantDiscountedPrice;
    data['product_name'] = this.productName;
    data['specification'] = this.specification;
    data['gst'] = this.gst;
    data['is_variant'] = this.isVariant;
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    data['is_favourite'] = this.isFavourite;
    if (this.productImages != null) {
      data['product_images'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ProductImages {
  int? id;
  String? image;

  ProductImages({this.id, this.image});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}


// class OrderResponseModel {
//   int? responseCode;
//   String? responseMessage;
//   OrderResponseData? responseData;
//
//   OrderResponseModel(
//       {this.responseCode, this.responseMessage, this.responseData});
//
//   OrderResponseModel.fromJson(Map<String, dynamic> json) {
//     responseCode = json['response_code'];
//     responseMessage = json['response_message'];
//     responseData = json['response_data'] != null
//         ? new OrderResponseData.fromJson(json['response_data'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['response_code'] = this.responseCode;
//     data['response_message'] = this.responseMessage;
//     if (this.responseData != null) {
//       data['response_data'] = this.responseData!.toJson();
//     }
//     return data;
//   }
// }
//
// class OrderResponseData {
//   List<RecentOrders>? recentOrders;
//
//   OrderResponseData({this.recentOrders});
//
//   OrderResponseData.fromJson(Map<String, dynamic> json) {
//     if (json['recent_orders'] != null) {
//       recentOrders = <RecentOrders>[];
//       json['recent_orders'].forEach((v) {
//         recentOrders!.add(new RecentOrders.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.recentOrders != null) {
//       data['recent_orders'] =
//           this.recentOrders!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class RecentOrders {
//   int? orderId;
//   String? grandTotalPrice;
//   int? totalGst;
//   String? orderStatus;
//
//   RecentOrders(
//       {this.orderId, this.grandTotalPrice, this.totalGst, this.orderStatus});
//
//   RecentOrders.fromJson(Map<String, dynamic> json) {
//     orderId = json['order_id'];
//     grandTotalPrice = json['grand_total_price'];
//     totalGst = json['total_gst'];
//     orderStatus = json['order_status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['order_id'] = this.orderId;
//     data['grand_total_price'] = this.grandTotalPrice;
//     data['total_gst'] = this.totalGst;
//     data['order_status'] = this.orderStatus;
//     return data;
//   }
// }

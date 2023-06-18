
import 'dart:convert';

RecentBuyersResponseModel recentBuyersResponseModelFromJson(String str) =>
    RecentBuyersResponseModel.fromJson(json.decode(str));
// class RecentBuyersResponseModel {
//   int? responseCode;
//   String? responseMessage;
//   RecentBuyersResponseData? recentBuyersResponseData;
//
//   RecentBuyersResponseModel(
//       {this.responseCode, this.responseMessage, this.recentBuyersResponseData});
//
//   RecentBuyersResponseModel.fromJson(Map<String, dynamic> json) {
//     responseCode = json['response_code'];
//     responseMessage = json['response_message'];
//     recentBuyersResponseData = json['RecentBuyersResponseData'] != null
//         ? new RecentBuyersResponseData.fromJson(
//         json['RecentBuyersResponseData'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['response_code'] = this.responseCode;
//     data['response_message'] = this.responseMessage;
//     if (this.recentBuyersResponseData != null) {
//       data['RecentBuyersResponseData'] =
//           this.recentBuyersResponseData!.toJson();
//     }
//     return data;
//   }
// }
//
// class RecentBuyersResponseData {
//   List<RecentBuyers>? recentBuyers;
//
//   RecentBuyersResponseData({this.recentBuyers});
//
//   RecentBuyersResponseData.fromJson(Map<String, dynamic> json) {
//     if (json['recent_buyers'] != null) {
//       recentBuyers = <RecentBuyers>[];
//       json['recent_buyers'].forEach((v) {
//         recentBuyers!.add(new RecentBuyers.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.recentBuyers != null) {
//       data['recent_buyers'] =
//           this.recentBuyers!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class RecentBuyers {
//   int? id;
//   String? mobileNumber;
//   String? name;
//   int? orderId;
//   String? orderStatus;
//   int? orderProductVariantId;
//   int? orderProductVariantQuantity;
//   String? productSpecification;
//   int? productVariantId;
//   String? productVariantPrice;
//   String? productVariantDiscountedPrice;
//   int? productId;
//   String? productName;

//   List<ProductImages>? productImages;
//
//   RecentBuyers(
//       {this.id,
//         this.mobileNumber,
//         this.name,
//         this.orderId,
//         this.orderStatus,
//         this.orderProductVariantId,
//         this.orderProductVariantQuantity,
//         this.productVariantId,
//         this.productVariantPrice,
//         this.productVariantDiscountedPrice,
//         this.productId,
//         this.productName,
//         this.productSpecification,
//         this.productImages});
//
//   RecentBuyers.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     mobileNumber = json['mobile_number'];
//     name = json['name'];
//     orderId = json['order_id'];
//     orderStatus = json['order_status'];
//     orderProductVariantId = json['order_product_variant_id'];
//     orderProductVariantQuantity = json['order_product_variant_quantity'];
//     productSpecification = json['product_specification'];
//     productVariantId = json['product_variant_id'];
//     productVariantPrice = json['product_variant_price'];
//     productVariantDiscountedPrice = json['product_variant_discounted_price'];
//     productId = json['product_id'];
//     productName = json['product_name'];

//     if (json['product_images'] != null) {
//       productImages = <ProductImages>[];
//       json['product_images'].forEach((v) {
//         productImages!.add(new ProductImages.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['mobile_number'] = this.mobileNumber;
//     data['name'] = this.name;
//     data['order_id'] = this.orderId;
//     data['order_status'] = this.orderStatus;
//     data['order_product_variant_id'] = this.orderProductVariantId;
//     data['order_product_variant_quantity'] = this.orderProductVariantQuantity;
//     data['product_specification'] = this.productSpecification;
//     data['product_variant_id'] = this.productVariantId;
//     data['product_variant_price'] = this.productVariantPrice;
//     data['product_variant_discounted_price'] =
//         this.productVariantDiscountedPrice;
//     data['product_id'] = this.productId;
//     data['product_name'] = this.productName;

//     if (this.productImages != null) {
//       data['product_images'] =
//           this.productImages!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class ProductImages {
//   int? id;
//   String? image;
//
//   ProductImages({this.id, this.image});
//
//   ProductImages.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['image'] = this.image;
//     return data;
//   }
// }

class RecentBuyersResponseModel {
  int? responseCode;
  String? responseMessage;
  RecentBuyersResponseData? responseData;

  RecentBuyersResponseModel(
      {this.responseCode, this.responseMessage, this.responseData});

  RecentBuyersResponseModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    responseData = json['response_data'] != null
        ? new RecentBuyersResponseData.fromJson(json['response_data'])
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

class RecentBuyersResponseData {
  List<RecentBuyers>? recentBuyers;

  RecentBuyersResponseData({this.recentBuyers});

  RecentBuyersResponseData.fromJson(Map<String, dynamic> json) {
    if (json['recent_buyers'] != null) {
      recentBuyers = <RecentBuyers>[];
      json['recent_buyers'].forEach((v) {
        recentBuyers!.add(new RecentBuyers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recentBuyers != null) {
      data['recent_buyers'] =
          this.recentBuyers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecentBuyers {
  int? id;
  String? mobileNumber;
  String? name;
  String? profilePic;
  int? orderId;
  String? orderNumber;
  String? orderCreatedAt;
  String? orderStatusDate;
  String? grandTotalPrice;
  int? totalGst;
  String? totalGstPrice;
  String? finalDiscountedPrice;
  String? orderStatus;
  int? buyerId;
  String? streetAddress;
  String? city;
  String? state;
  String? pincode;
  int? orderProductVariantId;
  int? orderProductVariantQuantity;
  String? orderProductVariantQuantityPrice;
  int? productVariantId;
  String? productVariantSize;
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

  RecentBuyers(
      {this.id,
        this.mobileNumber,
        this.name,
        this.profilePic,
        this.orderId,
        this.orderNumber,
        this.orderCreatedAt,
        this.orderStatusDate,
        this.grandTotalPrice,
        this.totalGst,
        this.totalGstPrice,
        this.finalDiscountedPrice,
        this.orderStatus,
        this.buyerId,
        this.streetAddress,
        this.city,
        this.state,
        this.pincode,
        this.orderProductVariantId,
        this.orderProductVariantQuantity,
        this.orderProductVariantQuantityPrice,
        this.productVariantId,
        this.productVariantSize,
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

  RecentBuyers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobileNumber = json['mobile_number'];
    name = json['name'];
    profilePic = json['profile_pic'];
    orderId = json['order_id'];
    orderNumber = json['order_number'];
    orderCreatedAt = json['order_created_at'];
    orderStatusDate = json['order_status_date'];
    grandTotalPrice = json['grand_total_price'];
    totalGst = json['total_gst'];
    totalGstPrice = json['total_gst_price'];
    finalDiscountedPrice = json['final_discounted_price'];
    orderStatus = json['order_status'];
    buyerId = json['buyer_id'];
    streetAddress = json['street_address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    orderProductVariantId = json['order_product_variant_id'];
    orderProductVariantQuantity = json['order_product_variant_quantity'];
    orderProductVariantQuantityPrice =
    json['order_product_variant_quantity_price'];
    productVariantId = json['product_variant_id'];
    productVariantSize = json['product_variant_size'];
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
    data['id'] = this.id;
    data['mobile_number'] = this.mobileNumber;
    data['name'] = this.name;
    data['profile_pic'] = this.profilePic;
    data['order_id'] = this.orderId;
    data['order_number'] = this.orderNumber;
    data['order_created_at'] = this.orderCreatedAt;
    data['order_status_date'] = this.orderStatusDate;
    data['grand_total_price'] = this.grandTotalPrice;
    data['total_gst'] = this.totalGst;
    data['total_gst_price'] = this.totalGstPrice;
    data['final_discounted_price'] = this.finalDiscountedPrice;
    data['order_status'] = this.orderStatus;
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
    data['product_variant_size'] = this.productVariantSize;
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


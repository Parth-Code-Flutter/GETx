// To parse this JSON data, do
//
//     final productListResponseModel = productListResponseModelFromJson(jsonString);

import 'dart:convert';

ProductListResponseModel productListResponseModelFromJson(String str) =>
    ProductListResponseModel.fromJson(json.decode(str));

class ProductListResponseModel {
  ProductListResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  int? responseCode;
  String? responseMessage;
  ProductData? responseData;

  factory ProductListResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductListResponseModel(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        responseData: json["response_data"] == null
            ? null
            : ProductData.fromJson(json["response_data"]),
      );
}

class ProductData {
  ProductData({
    this.totalRecords,
    this.totalPages,
    this.currentPage,
    this.nextPage,
    this.products,
  });

  int? totalRecords;
  int? totalPages;
  int? currentPage;
  int? nextPage;
  List<BuyerProducts>? products;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        totalRecords: json["total_records"],
        totalPages: json["total_pages"],
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        products: List<BuyerProducts>.from(
            json["products"].map((x) => BuyerProducts.fromJson(x))),
      );
}

class BuyerProducts {
  BuyerProducts({
    this.id,
    this.name,
    this.specification,
    this.gst,
    this.isVariant,
    this.categoryName,
    this.categoryId,
    this.isFavourite,
    this.sellerId,
    this.sellerName,
    this.sellerEmail,
    this.sellerCity,
    this.sellerState,
    this.companyAddress,
    this.productImages,
    this.productVariants,
    this.isOrderPlaced,
  });

  int? id;
  String? name;
  String? specification;
  int? gst;
  bool? isVariant;
  String? categoryName;
  int? categoryId;
  bool? isFavourite;
  int? sellerId;
  String? sellerName;
  bool? isOrderPlaced;
  dynamic sellerEmail;
  dynamic sellerCity;
  dynamic sellerState;
  dynamic companyAddress;
  List<ProductImage>? productImages;
  List<ProductVariant>? productVariants;

  factory BuyerProducts.fromJson(Map<String, dynamic> json) => BuyerProducts(
        id: json["id"],
        name: json["name"],
        specification: json["specification"],
        gst: json["gst"],
        isVariant: json["is_variant"],
        categoryName: json["category_name"],
        categoryId: json["category_id"],
        isFavourite: json["is_favourite"],
        sellerId: json["seller_id"],
        sellerName: json["seller_name"],
        sellerEmail: json["seller_email"],
        sellerCity: json["seller_city"],
        sellerState: json["seller_state"],
        companyAddress: json["company_address"],
        isOrderPlaced: json["isOrderPlaced"],
        productImages: List<ProductImage>.from(
            json["product_images"].map((x) => ProductImage.fromJson(x))),
        productVariants: List<ProductVariant>.from(
            json["product_variants"].map((x) => ProductVariant.fromJson(x))),
      );
}

class ProductImage {
  ProductImage({
    this.id,
    this.image,
  });

  int? id;
  String? image;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        image: json["image"],
      );
}

class ProductVariant {
  ProductVariant({
    this.id,
    this.size,
    this.stockQty,
    this.gst,
    this.price,
    this.discountedPrice,
    this.leftQty,
    this.sellerId,
    this.qty,
    this.totalPrice,
  });

  int? id;
  String? size;

  int? gst;
  String? price;
  String? discountedPrice;
  int? stockQty;
  int? leftQty;
  int? sellerId;
  int? qty;
  double? totalPrice;

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
        id: json["id"],
        size: json["size"],
        gst: json["gst"] ?? 0,
        price: json["price"],
        discountedPrice: json["discounted_price"],
        stockQty: json["stock_qty"],
        leftQty: json["left_qty"],
        sellerId: json["seller_id"],
        qty: json["qty"] = 1,
        totalPrice: json["totalPrice"] = 0.0,
      );
}

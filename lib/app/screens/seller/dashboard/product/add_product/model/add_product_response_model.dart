
import 'dart:convert';

AddProductResponseModel addProductResponseModelFromJson(String str) =>
    AddProductResponseModel.fromJson(json.decode(str));
class AddProductResponseModel {
  int? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  AddProductResponseModel(
      {this.responseCode, this.responseMessage, this.responseData});

  AddProductResponseModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    responseData = json['response_data'] != null
        ? new ResponseData.fromJson(json['response_data'])
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

class ResponseData {
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
  String? sellerEmail;
  String? sellerCity;
  String? sellerState;
  String? companyAddress;
  List<Null>? productImages;
  List<ProductVariants>? productVariants;

  ResponseData(
      {this.id,
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
        this.productVariants});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    specification = json['specification'];
    gst = json['gst'];
    isVariant = json['is_variant'];
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    isFavourite = json['is_favourite'];
    sellerId = json['seller_id'];
    sellerName = json['seller_name'];
    sellerEmail = json['seller_email'];
    sellerCity = json['seller_city'];
    sellerState = json['seller_state'];
    companyAddress = json['company_address'];
    // if (json['product_images'] != null) {
    //   productImages = <Null>[];
    //   json['product_images'].forEach((v) {
    //     productImages!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['product_variants'] != null) {
      productVariants = <ProductVariants>[];
      json['product_variants'].forEach((v) {
        productVariants!.add(new ProductVariants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['specification'] = this.specification;
    data['gst'] = this.gst;
    data['is_variant'] = this.isVariant;
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    data['is_favourite'] = this.isFavourite;
    data['seller_id'] = this.sellerId;
    data['seller_name'] = this.sellerName;
    data['seller_email'] = this.sellerEmail;
    data['seller_city'] = this.sellerCity;
    data['seller_state'] = this.sellerState;
    data['company_address'] = this.companyAddress;
    // if (this.productImages != null) {
    //   data['product_images'] =
    //       this.productImages!.map((v) => v.toJson()).toList();
    // }
    if (this.productVariants != null) {
      data['product_variants'] =
          this.productVariants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductVariants {
  int? id;
  String? size;
  int? stockQty;
  int? gst;
  String? price;
  String? discountedPrice;
  int? leftQty;
  int? sellerId;

  ProductVariants(
      {this.id,
        this.size,
        this.stockQty,
        this.gst,
        this.price,
        this.discountedPrice,
        this.leftQty,
        this.sellerId});

  ProductVariants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    stockQty = json['stock_qty'];
    gst = json['gst'];
    price = json['price'];
    discountedPrice = json['discounted_price'];
    leftQty = json['left_qty'];
    sellerId = json['seller_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    data['stock_qty'] = this.stockQty;
    data['gst'] = this.gst;
    data['price'] = this.price;
    data['discounted_price'] = this.discountedPrice;
    data['left_qty'] = this.leftQty;
    data['seller_id'] = this.sellerId;
    return data;
  }
}

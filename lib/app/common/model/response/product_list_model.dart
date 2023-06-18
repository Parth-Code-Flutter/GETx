import 'dart:convert';

ProductList productListSellerResponseModelFromJson(String str)=>
    ProductList.fromJson(json.decode(str));
class ProductList {
  int? responseCode;
  String? responseMessage;
  ProductResponseData? responseData;

  ProductList({this.responseCode, this.responseMessage, this.responseData});

  ProductList.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    responseData = json['response_data'] != null
        ? new ProductResponseData.fromJson(json['response_data'])
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

class ProductResponseData {
  int? totalRecords;
  int? totalPages;
  int? currentPage;
  int? nextPage;
  List<Products>? products;

  ProductResponseData(
      {this.totalRecords,
        this.totalPages,
        this.currentPage,
        this.nextPage,
        this.products});

  ProductResponseData.fromJson(Map<String, dynamic> json) {
    totalRecords = json['total_records'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    nextPage = json['next_page'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_records'] = this.totalRecords;
    data['total_pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    data['next_page'] = this.nextPage;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? specification;
  int? gst;
  bool? isVariant;
  bool? isOrderPlaced;
  String? categoryName;
  int? categoryId;
  bool? isFavourite;
  int? sellerId;
  String? sellerName;
  String? sellerEmail;
  String? sellerCity;
  String? sellerState;
  String? companyAddress;
  List<ProductImages>? productImages;
  List<ProductVariants>? productVariants;

  Products(
      {this.id,
        this.name,
        this.specification,
        this.gst,
        this.isVariant,
        this.isOrderPlaced,
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

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    specification = json['specification'];
    gst = json['gst'];
    isVariant = json['is_variant'];
    isOrderPlaced = json['isOrderPlaced'];
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    isFavourite = json['is_favourite'];
    sellerId = json['seller_id'];
    sellerName = json['seller_name'];
    sellerEmail = json['seller_email'];
    sellerCity = json['seller_city'];
    sellerState = json['seller_state'];
    companyAddress = json['company_address'];
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }
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
    data['isOrderPlaced'] = this.isOrderPlaced;
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    data['is_favourite'] = this.isFavourite;
    data['seller_id'] = this.sellerId;
    data['seller_name'] = this.sellerName;
    data['seller_email'] = this.sellerEmail;
    data['seller_city'] = this.sellerCity;
    data['seller_state'] = this.sellerState;
    data['company_address'] = this.companyAddress;
    if (this.productImages != null) {
      data['product_images'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    if (this.productVariants != null) {
      data['product_variants'] =
          this.productVariants!.map((v) => v.toJson()).toList();
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
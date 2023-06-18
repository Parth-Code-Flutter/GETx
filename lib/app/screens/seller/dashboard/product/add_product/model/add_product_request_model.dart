import 'dart:convert';

AddProductRequestModel addProductRequestModelFromJson(String str) => AddProductRequestModel.fromJson(json.decode(str));

String addProductRequestModelToJson(AddProductRequestModel data) => json.encode(data.toJson());
class AddProductRequestModel {
  Product? product;

  AddProductRequestModel({this.product});

  AddProductRequestModel.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? name;
  String? specification;
  int? categoryId;
  bool? isVariant;
  String? gst;
  List<ProductVariantsAttributes>? productVariantsAttributes;
  List<String>? productImages;

  Product(
      {this.name,
        this.specification,
        this.categoryId,
        this.isVariant,
        this.gst,
        this.productVariantsAttributes,
        this.productImages});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    specification = json['specification'];
    categoryId = json['category_id'];
    isVariant = json['is_variant'];
    gst = json['gst'];
    if (json['product_variants_attributes'] != null) {
      productVariantsAttributes = <ProductVariantsAttributes>[];
      json['product_variants_attributes'].forEach((v) {
        productVariantsAttributes!
            .add(new ProductVariantsAttributes.fromJson(v));
      });
    }
    productImages = json['product_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['specification'] = this.specification;
    data['category_id'] = this.categoryId;
    data['is_variant'] = this.isVariant;
    data['gst'] = this.gst;
    if (this.productVariantsAttributes != null) {
      data['product_variants_attributes'] =
          this.productVariantsAttributes!.map((v) => v.toJson()).toList();
    }
    data['product_images'] = this.productImages;
    return data;
  }
}

class ProductVariantsAttributes {
  int? categoryId;
  int? sellerId;
  int? id;
  int? size;
  int? availableQuantity;
  String? price;
  String? discountedPrice;

  ProductVariantsAttributes(
      {this.categoryId,
        this.sellerId,
        this.id,
        this.size,
        this.availableQuantity,
        this.price,
        this.discountedPrice,
      });

  ProductVariantsAttributes.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    id = json['id'];
    sellerId = json['seller_id'];
    size = json['size'];
    availableQuantity = json['available_quantity'];
    price = json['price'];
    discountedPrice = json['discounted_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['seller_id'] = this.sellerId;
    data['size'] = this.size;
    data['available_quantity'] = this.availableQuantity;
    data['price'] = this.price;
    data['discounted_price'] = this.discountedPrice;
    return data;
  }
}


//
// class AddProductRequestModel {
//   Product? product;
//
//   AddProductRequestModel({this.product});
//
//   AddProductRequestModel.fromJson(Map<String, dynamic> json) {
//     product =
//     json['product'] != null ? new Product.fromJson(json['product']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.product != null) {
//       data['product'] = this.product!.toJson();
//     }
//     return data;
//   }
// }
//
// class Product {
//   String? name;
//   String? specification;
//   String? categoryId;
//   bool? isVariant;
//   String? gst;
//   List<ProductImages>? productImages;
//   List<ProductVariantsAttributes>? productVariantsAttributes;
//
//   Product(
//       {this.name,
//         this.specification,
//         this.categoryId,
//         this.isVariant,
//         this.gst,
//         this.productImages,
//         this.productVariantsAttributes});
//
//   Product.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     specification = json['specification'];
//     categoryId = json['category_id'];
//     isVariant = json['is_variant'];
//     gst = json['gst'];
//     if (json['product_images'] != null) {
//       productImages = <ProductImages>[];
//       json['product_images'].forEach((v) {
//         productImages!.add(new ProductImages.fromJson(v));
//       });
//     }
//     if (json['product_variants_attributes'] != null) {
//       productVariantsAttributes = <ProductVariantsAttributes>[];
//       json['product_variants_attributes'].forEach((v) {
//         productVariantsAttributes!
//             .add(new ProductVariantsAttributes.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['specification'] = this.specification;
//     data['category_id'] = this.categoryId;
//     data['is_variant'] = this.isVariant;
//     data['gst'] = this.gst;
//     if (this.productImages != null) {
//       data['product_images'] =
//           this.productImages!.map((v) => v.toJson()).toList();
//     }
//     if (this.productVariantsAttributes != null) {
//       data['product_variants_attributes'] =
//           this.productVariantsAttributes!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class ProductImages {
//   String? id;
//   String? image;
//   String? sDestroy;
//
//   ProductImages({this.id, this.image, this.sDestroy});
//
//   ProductImages.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//     sDestroy = json['_destroy'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['image'] = this.image;
//     data['_destroy'] = this.sDestroy;
//     return data;
//   }
// }
//
// class ProductVariantsAttributes {
//   String? size;
//   String? availableQuantity;
//   String? price;
//   String? discountedPrice;
//   int? leftQuantity;
//   String? sellerId;
//   String? categoryId;
//
//   ProductVariantsAttributes(
//       {this.size,
//         this.availableQuantity,
//         this.price,
//         this.discountedPrice,
//         this.leftQuantity,
//         this.sellerId,
//         this.categoryId});
//
//   ProductVariantsAttributes.fromJson(Map<String, dynamic> json) {
//     size = json['size'];
//     availableQuantity = json['available_quantity'];
//     price = json['price'];
//     discountedPrice = json['discounted_price'];
//     leftQuantity = json['left_quantity'];
//     sellerId = json['seller_id'];
//     categoryId = json['category_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['size'] = this.size;
//     data['available_quantity'] = this.availableQuantity;
//
//     data['price'] = this.price;
//     data['discounted_price'] = this.discountedPrice;
//     data['left_quantity'] = this.leftQuantity;
//     data['seller_id'] = this.sellerId;
//     data['category_id'] = this.categoryId;
//     return data;
//   }
// }
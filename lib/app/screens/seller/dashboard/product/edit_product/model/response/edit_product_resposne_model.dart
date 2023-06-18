// To parse this JSON data, do
//
//     final editProductResponseModel = editProductResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:tsofie/app/common/model/response/product_list_model.dart';

EditProductResponseModel editProductResponseModelFromJson(String str) => EditProductResponseModel.fromJson(json.decode(str));

class EditProductResponseModel {
  int? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  EditProductResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  factory EditProductResponseModel.fromJson(Map<String, dynamic> json) => EditProductResponseModel(
    responseCode: json["response_code"],
    responseMessage: json["response_message"],
    responseData: json["response_data"]==null?null:ResponseData.fromJson(json["response_data"]),
  );

}

class ResponseData {
  Products? products;

  ResponseData({
    this.products,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    products: Products.fromJson(json["products"]),
  );

}

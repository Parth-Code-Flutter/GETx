import 'dart:convert';

CategoriesListResponseModel categoriesListResponseModelFromJson(String str)=>
CategoriesListResponseModel.fromJson(json.decode(str));

class CategoriesListResponseModel{
  int? responseCode;
  String? responseMessages;
  CategoriesListResponseData? responseData;

  CategoriesListResponseModel({this.responseCode, this.responseMessages, this.responseData});

  CategoriesListResponseModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessages = json['response_messages'];
    responseData = json['response_data'] != null
        ? new CategoriesListResponseData.fromJson(json['response_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_messages'] = this.responseMessages;
    if (this.responseData != null) {
      data['response_data'] = this.responseData!.toJson();
    }
    return data;
  }
}

class CategoriesListResponseData {
  int? totalRecords;
  int? totalPages;
  int? currentPage;
  Null? nextPage;
  List<Categories>? categories;

  CategoriesListResponseData(
      {this.totalRecords,
        this.totalPages,
        this.currentPage,
        this.nextPage,
        this.categories});

  CategoriesListResponseData.fromJson(Map<String, dynamic> json) {
    totalRecords = json['total_records'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    nextPage = json['next_page'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_records'] = this.totalRecords;
    data['total_pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    data['next_page'] = this.nextPage;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? image;

  Categories({this.id, this.name, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

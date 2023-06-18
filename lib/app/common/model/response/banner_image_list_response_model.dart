import 'dart:convert';

BannerImageListResponseModel bannerImageListResponseModelFromJson(String str)=>
    BannerImageListResponseModel.fromJson(json.decode(str));
class BannerImageListResponseModel {
  int? responseCode;
  String? responseMessage;
  BannerImageListResponseData? responseData;

  BannerImageListResponseModel(
      {this.responseCode, this.responseMessage, this.responseData});

  BannerImageListResponseModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    responseData = json['response_data'] != null
        ? new BannerImageListResponseData.fromJson(json['response_data'])
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

class BannerImageListResponseData {
  List<Banners>? banners;

  BannerImageListResponseData({this.banners});

  BannerImageListResponseData.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  int? id;
  String? image;

  Banners({this.image,this.id});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

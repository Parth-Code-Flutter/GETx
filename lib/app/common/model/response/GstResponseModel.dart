import 'dart:convert';

GstResponseDataModel gstListResponseModelFromJson(String str)=>
    GstResponseDataModel.fromJson(json.decode(str));
class GstResponseDataModel {
  int? responseCode;
  String? responseMessage;
  GSTResponseData? responseData;

  GstResponseDataModel({this.responseCode, this.responseMessage, this.responseData});

  GstResponseDataModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    responseData = json['response_data'] != null
        ? new GSTResponseData.fromJson(json['response_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_message'] = this.responseMessage;
    if (this.responseData != null) {
      data['response_data'] = this.responseData?.toJson();
    }
    return data;
  }
}

class GSTResponseData {
  List<Prices>? prices;

  GSTResponseData({this.prices});

  GSTResponseData.fromJson(Map<String, dynamic> json) {
    if (json['prices'] != null) {
      prices = <Prices>[];
      json['prices'].forEach((v) {
        prices?.add(new Prices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final prices = this.prices;
    if (prices != null) {
      data['prices'] = prices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prices {
  int? id;
  String? priceInPer;

  Prices({this.id, this.priceInPer});

  Prices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priceInPer = json['price_in_per'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price_in_per'] = this.priceInPer;
    return data;
  }
}

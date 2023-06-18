// To parse this JSON data, do
//
//     final cityResponseModel = cityResponseModelFromJson(jsonString);

import 'dart:convert';

CityResponseModel cityResponseModelFromJson(String str) =>
    CityResponseModel.fromJson(json.decode(str));

class CityResponseModel {
  CityResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  int? responseCode;
  String? responseMessage;
  CityResponseData? responseData;

  factory CityResponseModel.fromJson(Map<String, dynamic> json) =>
      CityResponseModel(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        responseData: json["response_data"] == null
            ? null
            : CityResponseData.fromJson(json["response_data"]),
      );
}

class CityResponseData {
  CityResponseData({
    this.cities,
  });

  List<CityData>? cities;

  factory CityResponseData.fromJson(Map<String, dynamic> json) =>
      CityResponseData(
        cities: List<CityData>.from(
            json["cities"].map((x) => CityData.fromJson(x))),
      );
}

class CityData {
  CityData({
    this.cityName,
  });

  String? cityName;

  factory CityData.fromJson(Map<String, dynamic> json) => CityData(
        cityName: json["city_name"],
      );
}

// To parse this JSON data, do
//
//     final locationResponseModel = locationResponseModelFromJson(jsonString);

import 'dart:convert';

LocationResponseModel locationResponseModelFromJson(String str) => LocationResponseModel.fromJson(json.decode(str));

class LocationResponseModel {
  LocationResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  int? responseCode;
  String? responseMessage;
  LocationResponseData? responseData;

  factory LocationResponseModel.fromJson(Map<String, dynamic> json) => LocationResponseModel(
    responseCode: json["response_code"],
    responseMessage: json["response_message"],
    responseData:json["response_data"]==null?null: LocationResponseData.fromJson(json["response_data"]),
  );
}

class LocationResponseData {
  LocationResponseData({
    this.totalRecords,
    this.totalPages,
    this.currentPage,
    this.nextPage,
    this.locations,
  });

  int? totalRecords;
  int? totalPages;
  int? currentPage;
  dynamic nextPage;
  List<LocationData>? locations;

  factory LocationResponseData.fromJson(Map<String, dynamic> json) => LocationResponseData(
    totalRecords: json["total_records"],
    totalPages: json["total_pages"],
    currentPage: json["current_page"],
    nextPage: json["next_page"],
    locations: List<LocationData>.from(json["locations"].map((x) => LocationData.fromJson(x))),
  );

}

class LocationData {
  LocationData({
    this.id,
    this.address,
    this.city,
    this.state,
    this.lat,
    this.lng,
    this.isDefault,
  });

  int? id;
  String? address;
  String? city;
  String? state;
  dynamic lat;
  dynamic lng;
  bool? isDefault;

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
    id: json["id"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    lat: json["lat"],
    lng: json["lng"],
    isDefault: json["is_default"],
  );

}

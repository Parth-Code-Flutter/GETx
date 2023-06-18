// To parse this JSON data, do
//
//     final stateResponseModel = stateResponseModelFromJson(jsonString);

import 'dart:convert';

StateResponseModel stateResponseModelFromJson(String str) =>
    StateResponseModel.fromJson(json.decode(str));

class StateResponseModel {
  StateResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  int? responseCode;
  String? responseMessage;
  StateResponseData? responseData;

  factory StateResponseModel.fromJson(Map<String, dynamic> json) =>
      StateResponseModel(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        responseData: json["response_data"] == null
            ? null
            : StateResponseData.fromJson(json["response_data"]),
      );
}

class StateResponseData {
  StateResponseData({
    this.states,
  });

  List<StateData>? states;

  factory StateResponseData.fromJson(Map<String, dynamic> json) =>
      StateResponseData(
        states: List<StateData>.from(
            json["states"].map((x) => StateData.fromJson(x))),
      );
}

class StateData {
  StateData({
    this.stateCode,
    this.stateName,
  });

  String? stateCode;
  String? stateName;

  factory StateData.fromJson(Map<String, dynamic> json) => StateData(
        stateCode: json["state_code"],
        stateName: json["state_name"],
      );
}

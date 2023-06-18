// To parse this JSON data, do
//
//     final buyerRegRequestModel = buyerRegRequestModelFromJson(jsonString);

import 'dart:convert';

EditProfileRequestModel editProfileRequestModelFromJson(String str) =>
    EditProfileRequestModel.fromJson(json.decode(str));

String editProfileRequestModelToJson(EditProfileRequestModel data) =>
    json.encode(data.toJson());

class EditProfileRequestModel {
  EditProfileRequestModel(
      {this.name,
      this.mobileCode,
      this.mobileNumber,
      this.profilePic,
      this.id,
      // this.mobileCode,
      // this.mobileNumber,
      // this.name,
      // this.profilePic,
      this.companyName,
      this.gstNumber,
      this.companyAddress,
      this.city,
      this.state,
      this.zipCode,
      this.contactPerson,
      this.officeNumber,
      this.cellNumber,
      this.email,
      this.token,
      this.otp,

      this.accountNumber,
      this.bankName,
      this.ifscNumber});

  String? name;
  String? mobileCode;
  String? mobileNumber;
  String? profilePic;

  int? id;

  // String? mobileCode;
  // String? mobileNumber;
  // String? name;
  // String? profilePic;
  String? companyName;
  String? gstNumber;
  String? companyAddress;
  String? city;
  String? state;
  String? zipCode;
  String? contactPerson;
  String? officeNumber;
  String? cellNumber;
  String? email;
  String? token;
  int? otp;
  String? accountNumber;
  String? bankName;
  String? ifscNumber;

  factory EditProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      EditProfileRequestModel(
        name: json["name"],
        mobileCode: json["mobile_code"],
        mobileNumber: json["mobile_number"],
        profilePic: json["profile_pic"],
        companyName: json['company_name'],
        gstNumber: json['gst_number'],
        companyAddress: json['company_address'],
        city: json['city'],
        state: json['state'],
        zipCode: json['zip_code'],
        contactPerson: json['contact_person'],
        officeNumber: json['office_number'],
        cellNumber: json['cell_number'],
        email: json['email'],
        token: json['token'],
        otp: json['otp'],
        accountNumber: json['account_number'],
        bankName: json['bank_name'],
        ifscNumber: json['ifsc_number'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mobile_code": mobileCode,
        "mobile_number": mobileNumber,
        "profile_pic": profilePic,
        "id": id,
        "company_name": companyName,
        "gst_number": gstNumber,
        "company_address": companyAddress,
        "city": city,
        "state": state,
        "zip_code": zipCode,
        "contact_person": contactPerson,
        "office_number": officeNumber,
        "cell_number": cellNumber,
        "email": email,
        "token": token,
        "otp": otp,
      };
}


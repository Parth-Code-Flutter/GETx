import 'dart:convert';

OTPVerificationResponsemodel OTPVerificationResponseModelFromJson(String str) =>
    OTPVerificationResponsemodel.fromJson(json.decode(str));

class OTPVerificationResponsemodel {
  int? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  OTPVerificationResponsemodel(
      {this.responseCode, this.responseMessage, this.responseData});

  OTPVerificationResponsemodel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    responseData = json['response_data'] != null
        ? new ResponseData.fromJson(json['response_data'])
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

class ResponseData {
  int? id;
  String? mobileCode;
  String? mobileNumber;
  String? name;
  String? profilePic;
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
  bool? isProfileUpdated;

  ResponseData(
      {this.id,
      this.mobileCode,
      this.mobileNumber,
      this.name,
      this.profilePic,
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
      this.isProfileUpdated});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobileCode = json['mobile_code'];
    mobileNumber = json['mobile_number'];
    name = json['name'];
    profilePic = json['profile_pic'];
    companyName = json['company_name'];
    gstNumber = json['gst_number'];
    companyAddress = json['company_address'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    contactPerson = json['contact_person'];
    officeNumber = json['office_number'];
    cellNumber = json['cell_number'];
    email = json['email'];
    token = json['token'];
    otp = json['otp'];
    isProfileUpdated = json['is_profile_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile_code'] = this.mobileCode;
    data['mobile_number'] = this.mobileNumber;
    data['name'] = this.name;
    data['profile_pic'] = this.profilePic;
    data['company_name'] = this.companyName;
    data['gst_number'] = this.gstNumber;
    data['company_address'] = this.companyAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    data['contact_person'] = this.contactPerson;
    data['office_number'] = this.officeNumber;
    data['cell_number'] = this.cellNumber;
    data['email'] = this.email;
    data['token'] = this.token;
    data['otp'] = this.otp;
    return data;
  }
}

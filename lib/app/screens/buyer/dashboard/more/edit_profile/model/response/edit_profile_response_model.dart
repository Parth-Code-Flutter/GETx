import 'dart:convert';

EditProfileResponseModel editProfileResponseModelFromJson(String str) =>
    EditProfileResponseModel.fromJson(json.decode(str));

class EditProfileResponseModel {
  int? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  EditProfileResponseModel(
      {this.responseCode, this.responseMessage, this.responseData});

  EditProfileResponseModel.fromJson(Map<String, dynamic> json) {
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
  BankDetailsData? bankDetailsData;
  String? accountNumber;
  String? bankName;
  String? ifscNumber;

  ResponseData({
    this.id,
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
    this.bankDetailsData,
    this.accountNumber,
    this.bankName,
    this.ifscNumber,
  });

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
    bankDetailsData= json["bank_deatails"]==null?null:BankDetailsData.fromJson(json["bank_deatails"]);
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    ifscNumber = json['ifsc_number'];
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

class BankDetailsData {
  BankDetailsData({
    this.bankNumber,
    this.bankName,
    this.ifscNumber,
  });

  String? bankNumber;
  String? bankName;
  String? ifscNumber;

  factory BankDetailsData.fromJson(Map<String, dynamic> json) => BankDetailsData(
    bankNumber: json["bank_number"],
    bankName: json["bank_name"],
    ifscNumber: json["ifsc_number"],
  );

  Map<String, dynamic> toJson() => {
    "bank_number": bankNumber,
    "bank_name": bankName,
    "ifsc_number": ifscNumber,
  };
}

// class EditProfileResponseModel {
//   int? responseCode;
//   String? responseMessage;
//   EditProfileResponseData? responseData;
//
//   EditProfileResponseModel(
//       {this.responseCode, this.responseMessage, this.responseData});
//
//   EditProfileResponseModel.fromJson(Map<String, dynamic> json) {
//     responseCode = json['response_code'];
//     responseMessage = json['response_message'];
//     responseData = json['response_data'] != null
//         ? new EditProfileResponseData.fromJson(json['response_data'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['response_code'] = this.responseCode;
//     data['response_message'] = this.responseMessage;
//     if (this.responseData != null) {
//       data['response_data'] = this.responseData!.toJson();
//     }
//     return data;
//   }
// }
//
// class EditProfileResponseData {
//   int? id;
//   String? mobileCode;
//   String? mobileNumber;
//   String? name;
//   String? profilePic;
//   String? companyName;
//   String? gstNumber;
//   String? companyAddress;
//   String? city;
//   String? state;
//   String? zipCode;
//   String? contactPerson;
//   String? officeNumber;
//   String? cellNumber;
//   String? email;
//   String? token;
//   int? otp;
//
//   EditProfileResponseData(
//       {this.id,
//         this.mobileCode,
//         this.mobileNumber,
//         this.name,
//         this.profilePic,
//         this.companyName,
//         this.gstNumber,
//         this.companyAddress,
//         this.city,
//         this.state,
//         this.zipCode,
//         this.contactPerson,
//         this.officeNumber,
//         this.cellNumber,
//         this.email,
//         this.token,
//         this.otp});
//
//   EditProfileResponseData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     mobileCode = json['mobile_code'];
//     mobileNumber = json['mobile_number'];
//     name = json['name'];
//     profilePic = json['profile_pic'];
//     companyName = json['company_name'];
//     gstNumber = json['gst_number'];
//     companyAddress = json['company_address'];
//     city = json['city'];
//     state = json['state'];
//     zipCode = json['zip_code'];
//     contactPerson = json['contact_person'];
//     officeNumber = json['office_number'];
//     cellNumber = json['cell_number'];
//     email = json['email'];
//     token = json['token'];
//     otp = json['otp'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['mobile_code'] = this.mobileCode;
//     data['mobile_number'] = this.mobileNumber;
//     data['name'] = this.name;
//     data['profile_pic'] = this.profilePic;
//     data['company_name'] = this.companyName;
//     data['gst_number'] = this.gstNumber;
//     data['company_address'] = this.companyAddress;
//     data['city'] = this.city;
//     data['state'] = this.state;
//     data['zip_code'] = this.zipCode;
//     data['contact_person'] = this.contactPerson;
//     data['office_number'] = this.officeNumber;
//     data['cell_number'] = this.cellNumber;
//     data['email'] = this.email;
//     data['token'] = this.token;
//     data['otp'] = this.otp;
//     return data;
//   }
// }
// class EditProfileResponseModel {
//   int? responseCode;
//   String? responseMessage;
//   EditProfileResponseData? responseData;
//
//   EditProfileResponseModel(
//       {this.responseCode, this.responseMessage, this.responseData});
//
//   EditProfileResponseModel.fromJson(Map<String, dynamic> json) {
//     responseCode = json['response_code'];
//     responseMessage = json['response_message'];
//     responseData = json['response_data'] != null
//         ? new EditProfileResponseData.fromJson(json['response_data'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['response_code'] = this.responseCode;
//     data['response_message'] = this.responseMessage;
//     if (this.responseData != null) {
//       data['response_data'] = this.responseData!.toJson();
//     }
//     return data;
//   }
// }
//
// class EditProfileResponseData {
//   int? id;
//   String? mobileCode;
//   String? mobileNumber;
//   String? name;
//   Null? profilePic;
//   String? token;
//   int? otp;
//
//   EditProfileResponseData(
//       {this.id,
//         this.mobileCode,
//         this.mobileNumber,
//         this.name,
//         this.profilePic,
//         this.token,
//         this.otp});
//
//   EditProfileResponseData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     mobileCode = json['mobile_code'];
//     mobileNumber = json['mobile_number'];
//     name = json['name'];
//     profilePic = json['profile_pic'];
//     token = json['token'];
//     otp = json['otp'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['mobile_code'] = this.mobileCode;
//     data['mobile_number'] = this.mobileNumber;
//     data['name'] = this.name;
//     data['profile_pic'] = this.profilePic;
//     data['token'] = this.token;
//     data['otp'] = this.otp;
//     return data;
//   }
// }

import 'package:tsofie/app/screens/seller/dashboard/more/get_profile_seller/response/get_profile_response_model.dart';

class UserPrefData {
  int? id;
  int? sellerId;
  String? mobileCode;
  String? mobileNumber;
  String? userName;
  String? userProfilePic;

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

  UserPrefData({
    this.id,
    this.sellerId,
    this.userName,
    this.mobileCode,
    this.mobileNumber,
    this.userProfilePic,
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
    this.ifscNumber,
  });

  factory UserPrefData.fromJson(Map<String, dynamic> jsonData) {
    return UserPrefData(
      id: jsonData['user_id'],
      sellerId: jsonData['seller_id'],
      userName: jsonData['name'],
      mobileCode: jsonData['mobile_code'],
      mobileNumber: jsonData['mobile_number'],
      userProfilePic: jsonData['profile_pic'],
      companyName: jsonData['company_name'],
      gstNumber: jsonData['gst_number'],
      companyAddress: jsonData['company_address'],
      city: jsonData['city'],
      state: jsonData['state'],
      zipCode: jsonData['zip_code'],
      contactPerson: jsonData['contact_person'],
      officeNumber: jsonData['office_number'],
      cellNumber: jsonData['cell_number'],
      email: jsonData['email'],
      token: jsonData['token'],
      otp: jsonData['otp'],
      accountNumber: jsonData['account_number'],
      bankName: jsonData['bank_name'],
      ifscNumber: jsonData['ifsc_number'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "id": id,
  //     "userName": userName,
  //     "mobileCode": mobileCode,
  //     "mobileNumber": mobileNumber,
  //     "userProfilePic": userProfilePic,
  //   };
  // }
}

class OtpModel {
  String? status;
  String? message;
  Data? data;

  OtpModel({this.status, this.message, this.data});

  OtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? mobile;
  String? otps;
  String? fcmToken;
  String? profilePhoto;
  String? createOn;
  String? isDelete;
  String? isActive;
  String? wallet_balance;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.mobile,
      this.otps,
      this.fcmToken,
      this.profilePhoto,
      this.createOn,
      this.isDelete,
      this.isActive,
      this.wallet_balance});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    mobile = json['mobile'];
    otps = json['otps'];
    fcmToken = json['fcm_token'];
    profilePhoto = json['profile_photo'];
    createOn = json['create_on'];
    isDelete = json['is_delete'];
    isActive = json['is_active'];
    wallet_balance = json['wallet_balence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['mobile'] = this.mobile;
    data['otps'] = this.otps;
    data['fcm_token'] = this.fcmToken;
    data['profile_photo'] = this.profilePhoto;
    data['create_on'] = this.createOn;
    data['is_delete'] = this.isDelete;
    data['is_active'] = this.isActive;
    data['wallet_balence'] = this.wallet_balance;
    return data;
  }
}

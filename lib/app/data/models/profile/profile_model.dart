class ProfileModel {
  bool? success;
  String? message;
  Data? data;

  ProfileModel({this.success, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileCountryCode;
  String? mobileNumber;
  String? rut;
  String? profilePicture;
  String? userSessionToken;
  String? deviceToken;
  String? deviceOs;
  String? deviceOsVersion;
  String? deviceModel;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? lastLoginAt;

  Data(
      {this.id,
        this.name,
        this.firstName,
        this.lastName,
        this.email,
        this.mobileCountryCode,
        this.mobileNumber,
        this.rut,
        this.profilePicture,
        this.userSessionToken,
        this.deviceToken,
        this.deviceOs,
        this.deviceOsVersion,
        this.deviceModel,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.lastLoginAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobileCountryCode = json['mobile_country_code'];
    mobileNumber = json['mobile_number'];
    rut = json['rut'];
    profilePicture = json['profile_picture'];
    userSessionToken = json['user_session_token'];
    deviceToken = json['device_token'];
    deviceOs = json['device_os'];
    deviceOsVersion = json['device_os_version'];
    deviceModel = json['device_model'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastLoginAt = json['last_login_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile_country_code'] = mobileCountryCode;
    data['mobile_number'] = mobileNumber;
    data['rut'] = rut;
    data['profile_picture'] = profilePicture;
    data['user_session_token'] = userSessionToken;
    data['device_token'] = deviceToken;
    data['device_os'] = deviceOs;
    data['device_os_version'] = deviceOsVersion;
    data['device_model'] = deviceModel;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_login_at'] = lastLoginAt;
    return data;
  }
}

class UserModel {
  String? message;
  String? accessToken;
  UserInfo? userInfo;

  UserModel({this.message, this.accessToken, this.userInfo});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['accessToken'];
    userInfo =
        json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['accessToken'] = accessToken;
    if (userInfo != null) {
      data['userInfo'] = userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? id;
  String? phoneNumber;
  String? fullName;
  String? gender;
  String? email;
  String? status;
  String? fireBaseUid;
  String? fcmtoken;
  String? brandId;
  String? createdAt;
  String? updatedAt;
  String? urlImg;

  UserInfo(
      {this.id,
      this.phoneNumber,
      this.fullName,
      this.gender,
      this.email,
      this.status,
      this.fireBaseUid,
      this.fcmtoken,
      this.brandId,
      this.createdAt,
      this.updatedAt,
      this.urlImg});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    gender = json['gender'];
    email = json['email'];
    status = json['status'];
    fireBaseUid = json['fireBaseUid'];
    fcmtoken = json['fcmtoken'];
    brandId = json['brandId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    urlImg = json['urlImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phoneNumber'] = phoneNumber;
    data['fullName'] = fullName;
    data['gender'] = gender;
    data['email'] = email;
    data['status'] = status;
    data['fireBaseUid'] = fireBaseUid;
    data['fcmtoken'] = fcmtoken;
    data['brandId'] = brandId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['urlImg'] = urlImg;
    return data;
  }
}

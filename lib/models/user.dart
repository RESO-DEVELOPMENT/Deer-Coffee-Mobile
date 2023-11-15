class UserModel {
  String? message;
  String? accessToken;
  UserDetails? userInfo;

  UserModel({this.message, this.accessToken, this.userInfo});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['accessToken'];
    userInfo = json['userInfo'] != null
        ? UserDetails.fromJson(json['userInfo'])
        : null;
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

class UserDetails {
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
  List<Wallets>? wallets;
  Level? level;

  UserDetails(
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
      this.urlImg,
      this.wallets,
      this.level});

  UserDetails.fromJson(Map<String, dynamic> json) {
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
    if (json['wallets'] != null) {
      wallets = <Wallets>[];
      json['wallets'].forEach((v) {
        wallets!.add(Wallets.fromJson(v));
      });
    }
    level = json['level'] != null ? Level.fromJson(json['level']) : null;
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
    if (wallets != null) {
      data['wallets'] = wallets!.map((v) => v.toJson()).toList();
    }
    if (level != null) {
      data['level'] = level!.toJson();
    }
    return data;
  }
}

class Wallets {
  String? id;
  String? name;
  num? balance;
  num? balanceHistory;

  Wallets({this.id, this.name, this.balance, this.balanceHistory});

  Wallets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    balance = json['balance'];
    balanceHistory = json['balanceHistory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['balance'] = balance;
    data['balanceHistory'] = balanceHistory;
    return data;
  }
}

class Level {
  String? memberLevelId;
  String? name;
  num? indexLevel;
  String? benefits;

  Level({this.memberLevelId, this.name, this.indexLevel, this.benefits});

  Level.fromJson(Map<String, dynamic> json) {
    memberLevelId = json['memberLevelId'];
    name = json['name'];
    indexLevel = json['indexLevel'];
    benefits = json['benefits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['memberLevelId'] = memberLevelId;
    data['name'] = name;
    data['indexLevel'] = indexLevel;
    data['benefits'] = benefits;
    return data;
  }
}

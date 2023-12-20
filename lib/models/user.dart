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
    if (level != null) {
      data['level'] = level!.toJson();
    }
    return data;
  }
}

class Level {
  String? memberLevelId;
  String? name;
  int? indexLevel;
  String? benefits;
  int? maxPoint;
  String? nextLevelName;
  List<MemberWallet>? memberWallet;
  List<MembershipCard>? membershipCard;

  Level(
      {this.memberLevelId,
      this.name,
      this.indexLevel,
      this.benefits,
      this.maxPoint,
      this.nextLevelName,
      this.memberWallet,
      this.membershipCard});

  Level.fromJson(Map<String, dynamic> json) {
    memberLevelId = json['memberLevelId'];
    name = json['name'];
    indexLevel = json['indexLevel'];
    benefits = json['benefits'];
    maxPoint = json['maxPoint'];
    nextLevelName = json['nextLevelName'];
    if (json['memberWallet'] != null) {
      memberWallet = <MemberWallet>[];
      json['memberWallet'].forEach((v) {
        memberWallet!.add(MemberWallet.fromJson(v));
      });
    }
    if (json['membershipCard'] != null) {
      membershipCard = <MembershipCard>[];
      json['membershipCard'].forEach((v) {
        membershipCard!.add(MembershipCard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['memberLevelId'] = memberLevelId;
    data['name'] = name;
    data['indexLevel'] = indexLevel;
    data['benefits'] = benefits;
    data['maxPoint'] = maxPoint;
    data['nextLevelName'] = nextLevelName;
    if (memberWallet != null) {
      data['memberWallet'] = memberWallet!.map((v) => v.toJson()).toList();
    }
    if (membershipCard != null) {
      data['membershipCard'] = membershipCard!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MemberWallet {
  String? id;
  int? balance;
  WalletType? walletType;

  MemberWallet({this.id, this.balance, this.walletType});

  MemberWallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    balance = json['balance'];
    walletType = json['walletType'] != null
        ? WalletType.fromJson(json['walletType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['balance'] = balance;
    if (walletType != null) {
      data['walletType'] = walletType!.toJson();
    }
    return data;
  }
}

class WalletType {
  String? name;
  String? currency;

  WalletType({this.name, this.currency});

  WalletType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['currency'] = currency;
    return data;
  }
}

class MembershipCard {
  String? id;
  String? membershipCardCode;
  String? physicalCardCode;
  MembershipCardType? membershipCardType;

  MembershipCard(
      {this.id,
      this.membershipCardCode,
      this.physicalCardCode,
      this.membershipCardType});

  MembershipCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    membershipCardCode = json['membershipCardCode'];
    physicalCardCode = json['physicalCardCode'];
    membershipCardType = json['membershipCardType'] != null
        ? MembershipCardType.fromJson(json['membershipCardType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['membershipCardCode'] = membershipCardCode;
    data['physicalCardCode'] = physicalCardCode;
    if (membershipCardType != null) {
      data['membershipCardType'] = membershipCardType!.toJson();
    }
    return data;
  }
}

class MembershipCardType {
  String? id;
  String? name;
  String? cardImage;

  MembershipCardType({this.id, this.name, this.cardImage});

  MembershipCardType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cardImage = json['cardImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cardImage'] = cardImage;
    return data;
  }
}

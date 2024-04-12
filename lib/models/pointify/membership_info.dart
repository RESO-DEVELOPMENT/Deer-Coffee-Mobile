import 'package:deer_coffee/models/pointify/membership_transaction.dart';

class MembershipInfo {
  String? membershipId;
  String? phoneNumber;
  String? email;
  String? fullname;
  bool? delFlg;
  num? gender;
  String? insDate;
  String? updDate;
  MemberLevel? memberLevel;

  MembershipInfo(
      {this.membershipId,
      this.phoneNumber,
      this.email,
      this.fullname,
      this.delFlg,
      this.gender,
      this.insDate,
      this.updDate,
      this.memberLevel});

  MembershipInfo.fromJson(Map<String, dynamic> json) {
    membershipId = json['membershipId'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    fullname = json['fullname'];
    delFlg = json['delFlg'];
    gender = json['gender'];
    insDate = json['insDate'];
    updDate = json['updDate'];
    memberLevel = json['memberLevel'] != null
        ? MemberLevel.fromJson(json['memberLevel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['membershipId'] = membershipId;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['fullname'] = fullname;
    data['delFlg'] = delFlg;
    data['gender'] = gender;
    data['insDate'] = insDate;
    data['updDate'] = updDate;
    if (memberLevel != null) {
      data['memberLevel'] = memberLevel!.toJson();
    }
    return data;
  }
}

class MemberLevel {
  String? memberLevelId;
  String? name;
  num? indexLevel;
  String? benefits;
  num? maxPoint;
  String? nextLevelName;
  List<MemberWallet>? memberWallet;
  List<MembershipCard>? membershipCard;

  MemberLevel(
      {this.memberLevelId,
      this.name,
      this.indexLevel,
      this.benefits,
      this.maxPoint,
      this.nextLevelName,
      this.memberWallet,
      this.membershipCard});

  MemberLevel.fromJson(Map<String, dynamic> json) {
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
  String? cardImg;

  MembershipCardType({this.id, this.name, this.cardImg});

  MembershipCardType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cardImg = json['cardImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cardImg'] = cardImg;
    return data;
  }
}

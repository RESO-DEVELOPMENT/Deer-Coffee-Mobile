class MemberShipModel {
  String? membershipId;
  String? phoneNumber;
  String? email;
  String? fullname;
  bool? delFlg;
  String? insDate;
  String? updDate;
  String? memberProgramId;
  String? memberLevelId;
  num? gender;
  MemberLevel? memberLevel;
  MemberProgram? memberProgram;
  List<MemberWallet>? memberWallet;

  MemberShipModel(
      {this.membershipId,
      this.phoneNumber,
      this.email,
      this.fullname,
      this.delFlg,
      this.insDate,
      this.updDate,
      this.memberProgramId,
      this.memberLevelId,
      this.gender,
      this.memberLevel,
      this.memberProgram,
      this.memberWallet});

  MemberShipModel.fromJson(Map<String, dynamic> json) {
    membershipId = json['membershipId'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    fullname = json['fullname'];
    delFlg = json['delFlg'];
    insDate = json['insDate'];
    updDate = json['updDate'];
    memberProgramId = json['memberProgramId'];
    memberLevelId = json['memberLevelId'];
    gender = json['gender'];
    memberLevel = json['memberLevel'] != null
        ? new MemberLevel.fromJson(json['memberLevel'])
        : null;
    memberProgram = json['memberProgram'] != null
        ? new MemberProgram.fromJson(json['memberProgram'])
        : null;
    if (json['memberWallet'] != null) {
      memberWallet = <MemberWallet>[];
      json['memberWallet'].forEach((v) {
        memberWallet!.add(new MemberWallet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membershipId'] = this.membershipId;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['fullname'] = this.fullname;
    data['delFlg'] = this.delFlg;
    data['insDate'] = this.insDate;
    data['updDate'] = this.updDate;
    data['memberProgramId'] = this.memberProgramId;
    data['memberLevelId'] = this.memberLevelId;
    data['gender'] = this.gender;
    if (this.memberLevel != null) {
      data['memberLevel'] = this.memberLevel!.toJson();
    }
    if (this.memberProgram != null) {
      data['memberProgram'] = this.memberProgram!.toJson();
    }
    if (this.memberWallet != null) {
      data['memberWallet'] = this.memberWallet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MemberLevel {
  String? memberLevelId;
  String? brandId;
  String? name;
  bool? delFlg;
  String? updDate;
  String? insDate;
  num? indexLevel;

  MemberLevel(
      {this.memberLevelId,
      this.brandId,
      this.name,
      this.delFlg,
      this.updDate,
      this.insDate,
      this.indexLevel});

  MemberLevel.fromJson(Map<String, dynamic> json) {
    memberLevelId = json['memberLevelId'];
    brandId = json['brandId'];
    name = json['name'];
    delFlg = json['delFlg'];
    updDate = json['updDate'];
    insDate = json['insDate'];
    indexLevel = json['indexLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberLevelId'] = this.memberLevelId;
    data['brandId'] = this.brandId;
    data['name'] = this.name;
    data['delFlg'] = this.delFlg;
    data['updDate'] = this.updDate;
    data['insDate'] = this.insDate;
    data['indexLevel'] = this.indexLevel;
    return data;
  }
}

class MemberProgram {
  String? id;
  String? brandId;
  String? nameOfProgram;
  String? startDay;
  String? endDay;
  bool? delFlg;
  String? termAndConditions;
  String? status;

  MemberProgram(
      {this.id,
      this.brandId,
      this.nameOfProgram,
      this.startDay,
      this.endDay,
      this.delFlg,
      this.termAndConditions,
      this.status});

  MemberProgram.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandId = json['brandId'];
    nameOfProgram = json['nameOfProgram'];
    startDay = json['startDay'];
    endDay = json['endDay'];
    delFlg = json['delFlg'];
    termAndConditions = json['termAndConditions'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandId'] = this.brandId;
    data['nameOfProgram'] = this.nameOfProgram;
    data['startDay'] = this.startDay;
    data['endDay'] = this.endDay;
    data['delFlg'] = this.delFlg;
    data['termAndConditions'] = this.termAndConditions;
    data['status'] = this.status;
    return data;
  }
}

class MemberWallet {
  String? id;
  String? name;
  bool? delFlag;
  String? memberId;
  String? walletTypeId;
  num? balance;
  num? balanceHistory;

  MemberWallet(
      {this.id,
      this.name,
      this.delFlag,
      this.memberId,
      this.walletTypeId,
      this.balance,
      this.balanceHistory});

  MemberWallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    delFlag = json['delFlag'];
    memberId = json['memberId'];
    walletTypeId = json['walletTypeId'];
    balance = json['balance'];
    balanceHistory = json['balanceHistory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['delFlag'] = this.delFlag;
    data['memberId'] = this.memberId;
    data['walletTypeId'] = this.walletTypeId;
    data['balance'] = this.balance;
    data['balanceHistory'] = this.balanceHistory;
    return data;
  }
}

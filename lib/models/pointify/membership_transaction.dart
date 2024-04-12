class MembershipTransaction {
  String? id;
  String? transactionJson;
  String? insDate;
  String? updDate;
  num? amount;
  String? currency;
  String? brandPartnerId;
  bool? isIncrease;
  String? type;
  String? description;
  MemberWallet? memberWallet;

  MembershipTransaction(
      {this.id,
      this.transactionJson,
      this.insDate,
      this.updDate,
      this.amount,
      this.currency,
      this.brandPartnerId,
      this.isIncrease,
      this.type,
      this.description,
      this.memberWallet});

  MembershipTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionJson = json['transactionJson'];
    insDate = json['insDate'];
    updDate = json['updDate'];
    amount = json['amount'];
    currency = json['currency'];
    brandPartnerId = json['brandPartnerId'];
    isIncrease = json['isIncrease'];
    type = json['type'];
    description = json['description'];
    memberWallet = json['memberWallet'] != null
        ? MemberWallet.fromJson(json['memberWallet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['transactionJson'] = this.transactionJson;
    data['insDate'] = this.insDate;
    data['updDate'] = this.updDate;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['brandPartnerId'] = this.brandPartnerId;
    data['isIncrease'] = this.isIncrease;
    data['type'] = this.type;
    data['description'] = this.description;
    if (this.memberWallet != null) {
      data['memberWallet'] = this.memberWallet!.toJson();
    }
    return data;
  }

  List<MembershipTransaction> fromList(dynamic jsonList) {
    var list = jsonList as List;
    return list.map((map) => MembershipTransaction.fromJson(map)).toList();
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
  WalletType? walletType;

  MemberWallet(
      {this.id,
      this.name,
      this.delFlag,
      this.memberId,
      this.walletTypeId,
      this.balance,
      this.balanceHistory,
      this.walletType});

  MemberWallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    delFlag = json['delFlag'];
    memberId = json['memberId'];
    walletTypeId = json['walletTypeId'];
    balance = json['balance'];
    balanceHistory = json['balanceHistory'];
    walletType = json['walletType'] != null
        ? WalletType.fromJson(json['walletType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['delFlag'] = this.delFlag;
    data['memberId'] = this.memberId;
    data['walletTypeId'] = this.walletTypeId;
    data['balance'] = this.balance;
    data['balanceHistory'] = this.balanceHistory;
    if (this.walletType != null) {
      data['walletType'] = this.walletType!.toJson();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['currency'] = this.currency;
    return data;
  }
}

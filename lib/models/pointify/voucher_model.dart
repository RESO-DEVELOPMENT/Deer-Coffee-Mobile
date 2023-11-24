// ignore_for_file: unnecessary_new

class VoucherModel {
  String? voucherId;
  String? voucherCode;
  String? channelId;
  String? storeId;
  String? voucherGroupId;
  String? membershipId;
  bool? isUsed;
  bool? isRedemped;
  String? usedDate;
  String? redempedDate;
  String? insDate;
  String? updDate;
  String? promotionId;
  int? index;
  String? promotionTierId;

  VoucherModel(
      {this.voucherId,
      this.voucherCode,
      this.channelId,
      this.storeId,
      this.voucherGroupId,
      this.membershipId,
      this.isUsed,
      this.isRedemped,
      this.usedDate,
      this.redempedDate,
      this.insDate,
      this.updDate,
      this.promotionId,
      this.index,
      this.promotionTierId});

  VoucherModel.fromJson(Map<String, dynamic> json) {
    voucherId = json['voucherId'];
    voucherCode = json['voucherCode'];
    channelId = json['channelId'];
    storeId = json['storeId'];
    voucherGroupId = json['voucherGroupId'];
    membershipId = json['membershipId'];
    isUsed = json['isUsed'];
    isRedemped = json['isRedemped'];
    usedDate = json['usedDate'];
    redempedDate = json['redempedDate'];
    insDate = json['insDate'];
    updDate = json['updDate'];
    promotionId = json['promotionId'];
    index = json['index'];
    promotionTierId = json['promotionTierId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['voucherId'] = voucherId;
    data['voucherCode'] = voucherCode;
    data['channelId'] = channelId;
    data['storeId'] = storeId;
    data['voucherGroupId'] = voucherGroupId;
    data['membershipId'] = membershipId;
    data['isUsed'] = isUsed;
    data['isRedemped'] = isRedemped;
    data['usedDate'] = usedDate;
    data['redempedDate'] = redempedDate;
    data['insDate'] = insDate;
    data['updDate'] = updDate;
    data['promotionId'] = promotionId;
    data['index'] = index;
    data['promotionTierId'] = promotionTierId;
    return data;
  }

  List<VoucherModel> fromList(dynamic jsonList) {
    var list = jsonList as List;
    return list.map((map) => VoucherModel.fromJson(map)).toList();
  }
}

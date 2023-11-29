class PromotionPointify {
  String? promotionId;
  String? promotionTierId;
  String? promotionName;
  String? promotionCode;
  String? description;
  num? forMembership;
  num? actionType;
  num? saleMode;
  String? imgUrl;
  num? promotionType;
  num? tierIndex;
  String? endDate;
  List<ListVoucher>? listVoucher;
  num? currentVoucherQuantity;

  PromotionPointify(
      {this.promotionId,
      this.promotionTierId,
      this.promotionName,
      this.promotionCode,
      this.description,
      this.forMembership,
      this.actionType,
      this.saleMode,
      this.imgUrl,
      this.promotionType,
      this.tierIndex,
      this.endDate,
      this.listVoucher,
      this.currentVoucherQuantity});

  PromotionPointify.fromJson(Map<String, dynamic> json) {
    promotionId = json['promotionId'];
    promotionTierId = json['promotionTierId'];
    promotionName = json['promotionName'];
    promotionCode = json['promotionCode'];
    description = json['description'];
    forMembership = json['forMembership'];
    actionType = json['actionType'];
    saleMode = json['saleMode'];
    imgUrl = json['imgUrl'];
    promotionType = json['promotionType'];
    tierIndex = json['tierIndex'];
    endDate = json['endDate'];
    if (json['listVoucher'] != null) {
      listVoucher = <ListVoucher>[];
      json['listVoucher'].forEach((v) {
        listVoucher!.add(ListVoucher.fromJson(v));
      });
    }
    currentVoucherQuantity = json['currentVoucherQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['promotionId'] = promotionId;
    data['promotionTierId'] = promotionTierId;
    data['promotionName'] = promotionName;
    data['promotionCode'] = promotionCode;
    data['description'] = description;
    data['forMembership'] = forMembership;
    data['actionType'] = actionType;
    data['saleMode'] = saleMode;
    data['imgUrl'] = imgUrl;
    data['promotionType'] = promotionType;
    data['tierIndex'] = tierIndex;
    data['endDate'] = endDate;
    if (listVoucher != null) {
      data['listVoucher'] = listVoucher!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<PromotionPointify> fromList(dynamic jsonList) {
    var list = jsonList as List;
    return list.map((map) => PromotionPointify.fromJson(map)).toList();
  }
}

class ListVoucher {
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
  num? index;
  String? promotionTierId;

  ListVoucher(
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

  ListVoucher.fromJson(Map<String, dynamic> json) {
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
}

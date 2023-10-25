class PromotionDetailsModel {
  String? promotionId;
  String? brandId;
  String? promotionCode;
  String? promotionName;
  int? actionType;
  int? postActionType;
  String? imgUrl;
  String? description;
  String? startDate;
  String? endDate;
  int? exclusive;
  int? applyBy;
  int? saleMode;
  int? gender;
  int? paymentMethod;
  int? forHoliday;
  int? forMembership;
  int? dayFilter;
  int? hourFilter;
  int? status;
  bool? delFlg;
  String? insDate;
  String? updDate;
  bool? hasVoucher;
  bool? isAuto;
  int? promotionType;

  PromotionDetailsModel(
      {this.promotionId,
      this.brandId,
      this.promotionCode,
      this.promotionName,
      this.actionType,
      this.postActionType,
      this.imgUrl,
      this.description,
      this.startDate,
      this.endDate,
      this.exclusive,
      this.applyBy,
      this.saleMode,
      this.gender,
      this.paymentMethod,
      this.forHoliday,
      this.forMembership,
      this.dayFilter,
      this.hourFilter,
      this.status,
      this.delFlg,
      this.insDate,
      this.updDate,
      this.hasVoucher,
      this.isAuto,
      this.promotionType});

  PromotionDetailsModel.fromJson(Map<String, dynamic> json) {
    promotionId = json['promotionId'];
    brandId = json['brandId'];
    promotionCode = json['promotionCode'];
    promotionName = json['promotionName'];
    actionType = json['actionType'];
    postActionType = json['postActionType'];
    imgUrl = json['imgUrl'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    exclusive = json['exclusive'];
    applyBy = json['applyBy'];
    saleMode = json['saleMode'];
    gender = json['gender'];
    paymentMethod = json['paymentMethod'];
    forHoliday = json['forHoliday'];
    forMembership = json['forMembership'];
    dayFilter = json['dayFilter'];
    hourFilter = json['hourFilter'];
    status = json['status'];
    delFlg = json['delFlg'];
    insDate = json['insDate'];
    updDate = json['updDate'];
    hasVoucher = json['hasVoucher'];
    isAuto = json['isAuto'];
    promotionType = json['promotionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['promotionId'] = promotionId;
    data['brandId'] = brandId;
    data['promotionCode'] = promotionCode;
    data['promotionName'] = promotionName;
    data['actionType'] = actionType;
    data['postActionType'] = postActionType;
    data['imgUrl'] = imgUrl;
    data['description'] = description;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['exclusive'] = exclusive;
    data['applyBy'] = applyBy;
    data['saleMode'] = saleMode;
    data['gender'] = gender;
    data['paymentMethod'] = paymentMethod;
    data['forHoliday'] = forHoliday;
    data['forMembership'] = forMembership;
    data['dayFilter'] = dayFilter;
    data['hourFilter'] = hourFilter;
    data['status'] = status;
    data['delFlg'] = delFlg;
    data['insDate'] = insDate;
    data['updDate'] = updDate;
    data['hasVoucher'] = hasVoucher;
    data['isAuto'] = isAuto;
    data['promotionType'] = promotionType;
    return data;
  }
}

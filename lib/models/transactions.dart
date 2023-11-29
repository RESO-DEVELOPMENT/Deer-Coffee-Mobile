class TransactionModel {
  String? id;
  String? createdDate;
  String? orderId;
  String? userId;
  String? status;
  String? brandId;
  num? amount;
  String? currency;
  String? brandPartnerId;
  bool? isIncrease;
  String? type;

  TransactionModel({
    this.id,
    this.createdDate,
    this.orderId,
    this.userId,
    this.status,
    this.brandId,
    this.amount,
    this.currency,
    this.brandPartnerId,
    this.isIncrease,
    this.type,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['createdDate'];
    orderId = json['orderId'];
    userId = json['userId'];
    status = json['status'];
    brandId = json['brandId'];
    amount = json['amount'];
    currency = json['currency'];
    brandPartnerId = json['brandPartnerId'];
    isIncrease = json['isIncrease'];
    type = json['type'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;

    data['createdDate'] = createdDate;
    data['orderId'] = orderId;
    data['userId'] = userId;
    data['status'] = status;
    data['brandId'] = brandId;
    data['amount'] = amount;
    data['currency'] = currency;
    data['brandPartnerId'] = brandPartnerId;
    data['isIncrease'] = isIncrease;
    data['type'] = type;
    return data;
  }

  List<TransactionModel> fromList(dynamic jsonList) {
    var list = jsonList as List;
    return list.map((map) => TransactionModel.fromJson(map)).toList();
  }
}

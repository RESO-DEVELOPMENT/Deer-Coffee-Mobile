class PaymentProvider {
  String? code;
  String? name;
  String? icon;
  bool? active;

  PaymentProvider({this.code, this.name, this.icon, this.active});

  PaymentProvider.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    icon = json['icon'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['icon'] = icon;
    data['active'] = active;
    return data;
  }

  List<PaymentProvider> fromList(dynamic jsonList) {
    var list = jsonList as List;
    return list.map((map) => PaymentProvider.fromJson(map)).toList();
  }
}

class PaymentStatusResponse {
  String? id;
  String? transactionStatus;
  PaymentStatusResponse({this.id, this.transactionStatus});
  factory PaymentStatusResponse.fromJson(Map<String, dynamic> json) {
    return PaymentStatusResponse(
      id: json['id'],
      transactionStatus: json['transactionStatus'],
    );
  }
}

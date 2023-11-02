class OrderInList {
  String? id;
  String? invoiceId;
  String? staffName;
  String? startDate;
  String? endDate;
  num? finalAmount;
  String? orderType;
  String? status;
  String? paymentType;
  String? customerName;
  String? phone;
  String? address;

  OrderInList(
      {this.id,
      this.invoiceId,
      this.staffName,
      this.startDate,
      this.endDate,
      this.finalAmount,
      this.orderType,
      this.status,
      this.paymentType,
      this.customerName,
      this.phone,
      this.address});

  OrderInList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceId = json['invoiceId'];
    staffName = json['staffName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    finalAmount = json['finalAmount'];
    orderType = json['orderType'];
    status = json['status'];
    paymentType = json['paymentType'];
    customerName = json['customerName'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['invoiceId'] = invoiceId;
    data['staffName'] = staffName;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['finalAmount'] = finalAmount;
    data['orderType'] = orderType;
    data['status'] = status;
    data['paymentType'] = paymentType;
    data['customerName'] = customerName;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}

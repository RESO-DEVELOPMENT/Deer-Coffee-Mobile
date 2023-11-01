class OrderModel {
  String? storeId;
  String? userId;
  String? address;
  String? orderType;
  String? status;
  String? paymentType;
  List<ProductsList>? productsList;
  num? totalAmount;
  num? discountAmount;
  num? finalAmount;
  List<PromotionList>? promotionList;

  OrderModel(
      {this.storeId,
      this.userId,
      this.address,
      this.orderType,
      this.status,
      this.paymentType,
      this.productsList,
      this.totalAmount,
      this.discountAmount,
      this.finalAmount,
      this.promotionList});

  OrderModel.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    userId = json['userId'];
    address = json['address'];
    orderType = json['orderType'];
    status = json['status'];
    paymentType = json['paymentType'];
    if (json['productsList'] != null) {
      productsList = <ProductsList>[];
      json['productsList'].forEach((v) {
        productsList!.add(ProductsList.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
    discountAmount = json['discountAmount'];
    finalAmount = json['finalAmount'];
    if (json['promotionList'] != null) {
      promotionList = <PromotionList>[];
      json['promotionList'].forEach((v) {
        promotionList!.add(PromotionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['storeId'] = storeId;
    data['userId'] = userId;
    data['address'] = address;
    data['orderType'] = orderType;
    data['status'] = status;
    data['paymentType'] = paymentType;
    if (productsList != null) {
      data['productsList'] = productsList!.map((v) => v.toJson()).toList();
    }
    data['totalAmount'] = totalAmount;
    data['discountAmount'] = discountAmount;
    data['finalAmount'] = finalAmount;
    if (promotionList != null) {
      data['promotionList'] = promotionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductsList {
  String? productInMenuId;
  num? quantity;
  num? sellingPrice;
  num? discount;
  String? note;
  String? promotionId;
  List<Extras>? extras;

  ProductsList(
      {this.productInMenuId,
      this.quantity,
      this.sellingPrice,
      this.discount,
      this.note,
      this.promotionId,
      this.extras});

  ProductsList.fromJson(Map<String, dynamic> json) {
    productInMenuId = json['productInMenuId'];
    quantity = json['quantity'];
    sellingPrice = json['sellingPrice'];
    discount = json['discount'];
    note = json['note'];
    promotionId = json['promotionId'];
    if (json['extras'] != null) {
      extras = <Extras>[];
      json['extras'].forEach((v) {
        extras!.add(Extras.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['productInMenuId'] = productInMenuId;
    data['quantity'] = quantity;
    data['sellingPrice'] = sellingPrice;
    data['discount'] = discount;
    data['note'] = note;
    data['promotionId'] = promotionId;
    if (extras != null) {
      data['extras'] = extras!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Extras {
  String? productInMenuId;
  num? quantity;
  num? sellingPrice;
  num? discount;

  Extras(
      {this.productInMenuId, this.quantity, this.sellingPrice, this.discount});

  Extras.fromJson(Map<String, dynamic> json) {
    productInMenuId = json['productInMenuId'];
    quantity = json['quantity'];
    sellingPrice = json['sellingPrice'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['productInMenuId'] = productInMenuId;
    data['quantity'] = quantity;
    data['sellingPrice'] = sellingPrice;
    data['discount'] = discount;
    return data;
  }
}

class PromotionList {
  String? promotionId;
  num? discountAmount;

  PromotionList({this.promotionId, this.discountAmount});

  PromotionList.fromJson(Map<String, dynamic> json) {
    promotionId = json['promotionId'];
    discountAmount = json['discountAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['promotionId'] = promotionId;
    data['discountAmount'] = discountAmount;
    return data;
  }
}

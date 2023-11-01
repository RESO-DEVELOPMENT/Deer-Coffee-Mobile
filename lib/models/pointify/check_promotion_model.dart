class CheckPromotionModel {
  num? code;
  String? message;
  Order? order;

  CheckPromotionModel({this.code, this.message, this.order});

  CheckPromotionModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    return data;
  }
}

class Order {
  List<Effects>? effects;
  CustomerOrderInfo? customerOrderInfo;
  num? totalAmount;
  num? discount;
  num? discountOrderDetail;
  num? finalAmount;
  num? bonusPoint;

  Order(
      {this.effects,
      this.customerOrderInfo,
      this.totalAmount,
      this.discount,
      this.discountOrderDetail,
      this.finalAmount,
      this.bonusPoint});

  Order.fromJson(Map<String, dynamic> json) {
    if (json['effects'] != null) {
      effects = <Effects>[];
      json['effects'].forEach((v) {
        effects!.add(Effects.fromJson(v));
      });
    }
    customerOrderInfo = json['customerOrderInfo'] != null
        ? CustomerOrderInfo.fromJson(json['customerOrderInfo'])
        : null;

    totalAmount = json['totalAmount'];
    discount = json['discount'];
    discountOrderDetail = json['discountOrderDetail'];
    finalAmount = json['finalAmount'];
    bonusPoint = json['bonusPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (effects != null) {
      data['effects'] = effects!.map((v) => v.toJson()).toList();
    }
    if (customerOrderInfo != null) {
      data['customerOrderInfo'] = customerOrderInfo!.toJson();
    }
    data['totalAmount'] = totalAmount;
    data['discount'] = discount;
    data['discountOrderDetail'] = discountOrderDetail;
    data['finalAmount'] = finalAmount;
    data['bonusPoint'] = bonusPoint;
    return data;
  }
}

class Effects {
  String? promotionId;
  String? promotionTierId;
  num? tierIndex;
  String? promotionName;
  String? conditionRuleName;
  String? imgUrl;
  String? description;
  String? effectType;
  num? promotionType;
  Prop? prop;

  Effects(
      {this.promotionId,
      this.promotionTierId,
      this.tierIndex,
      this.promotionName,
      this.conditionRuleName,
      this.imgUrl,
      this.description,
      this.effectType,
      this.promotionType,
      this.prop});

  Effects.fromJson(Map<String, dynamic> json) {
    promotionId = json['promotionId'];
    promotionTierId = json['promotionTierId'];
    tierIndex = json['tierIndex'];
    promotionName = json['promotionName'];
    conditionRuleName = json['conditionRuleName'];
    imgUrl = json['imgUrl'];
    description = json['description'];
    effectType = json['effectType'];
    promotionType = json['promotionType'];
    prop = json['prop'] != null ? Prop.fromJson(json['prop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['promotionId'] = promotionId;
    data['promotionTierId'] = promotionTierId;
    data['tierIndex'] = tierIndex;
    data['promotionName'] = promotionName;
    data['conditionRuleName'] = conditionRuleName;
    data['imgUrl'] = imgUrl;
    data['description'] = description;
    data['effectType'] = effectType;
    data['promotionType'] = promotionType;
    if (prop != null) {
      data['prop'] = prop!.toJson();
    }
    return data;
  }
}

class Prop {
  String? code;
  num? value;

  Prop({this.code, this.value});

  Prop.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['value'] = value;
    return data;
  }
}

class CustomerOrderInfo {
  String? apiKey;
  String? id;
  String? bookingDate;
  Attributes? attributes;
  List<CartItems>? cartItems;
  List<Vouchers>? vouchers;
  num? amount;
  num? shippingFee;
  Users? users;

  CustomerOrderInfo(
      {this.apiKey,
      this.id,
      this.bookingDate,
      this.attributes,
      this.cartItems,
      this.vouchers,
      this.amount,
      this.shippingFee,
      this.users});

  CustomerOrderInfo.fromJson(Map<String, dynamic> json) {
    apiKey = json['apiKey'];
    id = json['id'];
    bookingDate = json['bookingDate'];
    attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
        : null;
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
    if (json['vouchers'] != null) {
      vouchers = <Vouchers>[];
      json['vouchers'].forEach((v) {
        vouchers!.add(Vouchers.fromJson(v));
      });
    }
    amount = json['amount'];
    shippingFee = json['shippingFee'];
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['apiKey'] = apiKey;
    data['id'] = id;
    data['bookingDate'] = bookingDate;
    if (attributes != null) {
      data['attributes'] = attributes!.toJson();
    }
    if (cartItems != null) {
      data['cartItems'] = cartItems!.map((v) => v.toJson()).toList();
    }
    if (vouchers != null) {
      data['vouchers'] = vouchers!.map((v) => v.toJson()).toList();
    }
    data['amount'] = amount;
    data['shippingFee'] = shippingFee;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    return data;
  }
}

class Attributes {
  num? salesMode;
  num? paymentMethod;
  StoreInfo? storeInfo;
  Attributes({this.salesMode, this.paymentMethod, this.storeInfo});

  Attributes.fromJson(Map<String, dynamic> json) {
    salesMode = json['salesMode'];
    paymentMethod = json['paymentMethod'];
    storeInfo = json['storeInfo'] != null
        ? StoreInfo.fromJson(json['storeInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['salesMode'] = salesMode;
    data['paymentMethod'] = paymentMethod;
    if (storeInfo != null) {
      data['storeInfo'] = storeInfo!.toJson();
    }

    return data;
  }
}

class StoreInfo {
  String? storeCode;
  String? brandCode;
  String? applier;

  StoreInfo({this.storeCode, this.brandCode, this.applier});

  StoreInfo.fromJson(Map<String, dynamic> json) {
    storeCode = json['storeCode'];
    brandCode = json['brandCode'];
    applier = json['applier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeCode'] = storeCode;
    data['brandCode'] = brandCode;
    data['applier'] = applier;
    return data;
  }
}

class CartItems {
  String? productCode;
  String? categoryCode;
  String? productName;
  num? unitPrice;
  num? quantity;
  num? subTotal;
  num? discount;
  num? discountFromOrder;
  num? total;
  String? urlImg;
  String? promotionCodeApply;

  CartItems(
      {this.productCode,
      this.categoryCode,
      this.productName,
      this.unitPrice,
      this.quantity,
      this.subTotal,
      this.discount,
      this.discountFromOrder,
      this.total,
      this.urlImg,
      this.promotionCodeApply});

  CartItems.fromJson(Map<String, dynamic> json) {
    productCode = json['productCode'];
    categoryCode = json['categoryCode'];
    productName = json['productName'];
    unitPrice = json['unitPrice'];
    quantity = json['quantity'];
    subTotal = json['subTotal'];
    discount = json['discount'];
    discountFromOrder = json['discountFromOrder'];
    total = json['total'];
    urlImg = json['urlImg'];
    promotionCodeApply = json['promotionCodeApply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productCode'] = productCode;
    data['categoryCode'] = categoryCode;
    data['productName'] = productName;
    data['unitPrice'] = unitPrice;
    data['quantity'] = quantity;
    data['subTotal'] = subTotal;
    data['discount'] = discount;
    data['discountFromOrder'] = discountFromOrder;
    data['total'] = total;
    data['urlImg'] = urlImg;
    data['promotionCodeApply'] = promotionCodeApply;
    return data;
  }
}

class Vouchers {
  String? promotionCode;
  String? voucherCode;

  Vouchers({this.promotionCode, this.voucherCode});

  Vouchers.fromJson(Map<String, dynamic> json) {
    promotionCode = json['promotionCode'];
    voucherCode = json['voucherCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['promotionCode'] = promotionCode;
    data['voucherCode'] = voucherCode;
    return data;
  }
}

class Users {
  String? membershipId;
  String? userName;
  String? userEmail;
  String? userPhoneNo;
  num? userGender;
  String? userLevel;

  Users(
      {this.membershipId,
      this.userName,
      this.userEmail,
      this.userPhoneNo,
      this.userGender,
      this.userLevel});

  Users.fromJson(Map<String, dynamic> json) {
    membershipId = json['membershipId'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPhoneNo = json['userPhoneNo'];
    userGender = json['userGender'];
    userLevel = json['userLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['membershipId'] = membershipId;
    data['userName'] = userName;
    data['userEmail'] = userEmail;
    data['userPhoneNo'] = userPhoneNo;
    data['userGender'] = userGender;
    data['userLevel'] = userLevel;
    return data;
  }
}

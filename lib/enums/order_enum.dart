// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum DeliTypeEnum { TAKE_AWAY, IN_STORE, DELIVERY, NONE }

enum PrinterTypeEnum { bill, stamp }

class DeliType {
  TakeAway takeAway = TakeAway();
  EatIn eatIn = EatIn();
  Delivery delivery = Delivery();
}

class TakeAway {
  String type = 'TAKE_AWAY';
  IconData icon = Icons.home;
  String label = 'Mang đi';
}

class EatIn {
  String type = 'EAT_IN';
  IconData icon = Icons.store;
  String label = 'Tại cửa hàng';
}

class Delivery {
  String type = 'DELIVERY';
  IconData icon = Icons.delivery_dining;
  String label = 'Giao hàng';
}

class OrderStatusEnum {
  static const String PENDING = 'PENDING';
  static const String CANCELED = 'CANCELED';
  static const String PAID = 'PAID';
}

class OrderTypeEnum {
  static const String EAT_IN = 'EAT_IN';
  static const String DELIVERY = 'DELIVERY';
  static const String TAKE_AWAY = 'TAKE_AWAY';
}

String showOrderStatus(String status) {
  switch (status) {
    case OrderStatusEnum.PENDING:
      return 'Chờ thanh toán';
    case OrderStatusEnum.CANCELED:
      return 'Đã huỷ';
    case OrderStatusEnum.PAID:
      return 'Đã thanh toán';
    default:
      return 'Chờ thanh toán';
  }
}

String showPaymentType(String payment) {
  switch (payment) {
    case PaymentTypeEnums.CASH:
      return 'TIỀN MẶT';
    case PaymentTypeEnums.POINTIFY_WALLET:
      return 'THẺ THÀNH VIÊN';
    default:
      return 'TIỀN MẶT';
  }
}

dynamic showOrderType(String type) {
  DeliType deliType = DeliType();
  if (type == deliType.takeAway.type) {
    return deliType.takeAway.label;
  } else if (type == deliType.eatIn.type) {
    return deliType.eatIn.label;
  } else if (type == deliType.delivery.type) {
    return deliType.delivery.label;
  } else {
    return deliType.eatIn.label;
  }
}

class PaymentStatusEnum {
  static const String FAIL = 'Fail';
  static const String PAID = 'Paid';
  static const String PENDING = 'Pending';
  static const String CANCELED = 'Canceled';
}

class PaymentTypeEnums {
  static const String CASH = 'CASH';
  static const String VIETQR = 'VIETQR';
  static const String ZALOPAY = 'ZALOPAY';
  static const String VNPAY = 'VNPAY';
  static const String MOMO = 'MOMO';
  static const String BANKING = 'BANKING';
  static const String VISA = 'VISA';
  static const String POINTIFY_WALLET = 'POINTIFY_WALLET';
}

enum PaymentTypeEnum { CASH, VIETQR, ZALOPAY, VNPAY }

var a = PaymentTypeEnum.CASH.toString();

class PromotionTypeEnums {
  static const String AMOUNT = 'Amount';
  static const String PRODUCT = 'Product';
  static const String PERCENT = 'Percent';
  static const String AUTOAPPLY = 'AutoApply';
}

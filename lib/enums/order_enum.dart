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

class DeliStatusEnum {
  static const String PENDING = 'PENDING';
  static const String CANCELED = 'CANCELED';
  static const String DELIVERING = 'DELIVERING';
  static const String DELIVERED = 'DELIVERED';
}

class OrderTypeEnum {
  static const String EAT_IN = 'EAT_IN';
  static const String DELIVERY = 'DELIVERY';
  static const String TAKE_AWAY = 'TAKE_AWAY';
}

String showOrderStatus(String status) {
  switch (status) {
    case OrderStatusEnum.PENDING:
      return 'Đang xử lý';
    case OrderStatusEnum.CANCELED:
      return 'Đã huỷ';
    case OrderStatusEnum.PAID:
      return 'Hoành thành';
    default:
      return 'Đang xử lý';
  }
}

String showUserDeiliStatus(String status) {
  switch (status) {
    case DeliStatusEnum.PENDING:
      return 'Đang lấy hàng';
    case DeliStatusEnum.CANCELED:
      return 'Đã huỷ';
    case DeliStatusEnum.DELIVERING:
      return 'Đang giao';
    case DeliStatusEnum.DELIVERED:
      return 'Đã giao';
    default:
      return 'Đang xử lý';
  }
}

String showPaymentType(String payment) {
  switch (payment) {
    case PaymentTypeEnums.CASH:
      return 'TIỀN MẶT';
    case PaymentTypeEnums.POINTIFY:
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
  static const String POINTIFY = 'POINTIFY';
}

enum PaymentTypeEnum { CASH, VIETQR, ZALOPAY, VNPAY }

var a = PaymentTypeEnum.CASH.toString();

class PromotionTypeEnums {
  static const String AMOUNT = 'Amount';
  static const String PRODUCT = 'Product';
  static const String PERCENT = 'Percent';
  static const String AUTOAPPLY = 'AutoApply';
}

class TransactionTypeEnum {
  static const String PAYMENT = 'PAYMENT';
  static const String GET_POINT = 'GET_POINT';
  static const String TOP_UP = 'TOP_UP';
}

import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:deer_coffee/models/user.dart';
import 'package:deer_coffee/utils/share_pref.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../api/order_api.dart';
import '../enums/order_enum.dart';
import '../enums/view_status.dart';
import '../models/cart.dart';
import '../models/order.dart';
import '../models/order_response.dart';
import '../models/payment_provider.dart';
import '../widgets/other_dialogs/dialog.dart';
import 'base_view_model.dart';

class OrderViewModel extends BaseViewModel {
  int selectedTable = 01;
  String deliveryType = DeliType().takeAway.type;
  Cart? currentCart;
  late OrderAPI api = OrderAPI();
  String? currentOrderId;
  num customerMoney = 0;
  num returnMoney = 0;
  OrderResponseModel? currentOrder;
  List<PaymentProvider?> listPayment = [];
  PaymentProvider? selectedPaymentMethod;

  // List<OrderInList> listOrder = [];
  PaymentStatusResponse? paymentStatus;
  String currentPaymentStatusMessage = "Chưa thanh toán";
  String paymentCheckingStatus = PaymentStatusEnum.CANCELED;
  String? qrCodeData;

  OrderViewModel() {
    api = OrderAPI();
    listPayment = [
      PaymentProvider(
          code: "CASH",
          name: "Tiền mặt",
          icon: "assets/images/cash.png",
          active: true),
      PaymentProvider(
          code: "BANKING",
          name: "Ngân hàng",
          icon: "assets/images/bank.png",
          active: true),
      PaymentProvider(
          code: "MOMO",
          name: "MOMO",
          icon: "assets/images/momo.png",
          active: true)
    ];
    // readJsonPayment();
  }

  String getPaymentName(String paymentType) {
    for (var item in listPayment) {
      if (item!.code == paymentType) {
        return item.name!;
      }
    }
    return "Tiền mặt";
  }

  void selectPayment(PaymentProvider payment) {
    qrCodeData = null;
    selectedPaymentMethod = payment;
    currentPaymentStatusMessage = "Vui lòng tiến hành thanh toán";
    notifyListeners();
  }

  void chooseDeliveryType(String type) {
    deliveryType = type;
    hideDialog();

    notifyListeners();
  }

  void chooseTable(int table) {
    selectedTable = table;
    hideDialog();
    notifyListeners();
  }

  void setCustomerMoney(num money) {
    customerMoney = money;
    returnMoney = customerMoney - currentOrder!.finalAmount!;
    notifyListeners();
  }

  Future<bool> placeOrder(OrderModel order) async {
    showLoadingDialog();
    UserModel? userInfo = await getUserInfo();
    // await api.placeOrder(order, userInfo!.storeId).then((value) => {
    //       hideDialog(),
    //       showPaymentBotomSheet(value),
    //     });
    return true;
  }

  // void makePayment(PaymentProvider payment) async {
  //   paymentCheckingStatus = PaymentStatusEnum.PENDING;
  //   // if (listPayment.isEmpty) {
  //   paymentCheckingStatus = PaymentStatusEnum.PAID;
  //   await completeOrder(currentOrder!.orderId ?? '');
  // }

  // void updatePaymentStatus(String status) {
  //   paymentData
  //       ?.updatePayment(currentOrder!.orderId ?? '', status)
  //       .then((value) => {
  //             if (value != null)
  //               {
  //                 Get.snackbar("Cập nhật trạng thái thanh toán", value),
  //               }
  //             else
  //               {
  //                 Get.snackbar(
  //                     "Cập nhật trạng thái thanh toán", "Thanh toan that bai"),
  //               }
  //           });
  // }

  // void checkPaymentStatus(String orderId) async {
  //   paymentCheckingStatus = PaymentStatusEnum.PENDING;
  //   for (int i = 0; i < 30; i++) {
  //     await Future.delayed(Duration(seconds: 3));
  //     await paymentData?.checkPayment(orderId).then((value) => {
  //           paymentStatus = value,
  //         });
  //     if (paymentStatus != null) {
  //       if (paymentStatus!.transactionStatus == PaymentStatusEnum.PAID) {
  //         currentPaymentStatusMessage = "Thanh toán thành công";
  //         paymentCheckingStatus = PaymentStatusEnum.PAID;
  //         break;
  //       } else if (paymentStatus!.transactionStatus == PaymentStatusEnum.FAIL) {
  //         currentPaymentStatusMessage = "Thanh toán thất bại";
  //         paymentCheckingStatus = PaymentStatusEnum.FAIL;
  //         Get.snackbar("Thanh toán thất bại",
  //             "Đơn hàng thanh toán thanh toán thất bại, vui lòng thử lại");
  //         break;
  //       } else {
  //         currentPaymentStatusMessage = "Đang kiểm tra thanh toán";
  //         paymentCheckingStatus = PaymentStatusEnum.PENDING;
  //       }
  //     } else {
  //       currentPaymentStatusMessage = "Vui lòng kiểm tra lại";
  //       paymentCheckingStatus = PaymentStatusEnum.CANCELED;
  //     }
  //   }
  //   if (paymentCheckingStatus == PaymentStatusEnum.PAID) {
  //     await completeOrder(orderId);
  //   }
  //   notifyListeners();
  // }

  // void getListOrder(
  //     {bool isToday = true,
  //     bool isYesterday = false,
  //     int page = 1,
  //     String? orderStatus,
  //     String? orderType}) async {
  //   try {
  //     setState(ViewStatus.Loading);
  //     UserModel? userInfo = await getUserInfo();
  //     listOrder = await api.getListOrderOfStore(userInfo!.storeId,
  //         isToday: isToday,
  //         isYesterday: isYesterday,
  //         page: page,
  //         orderStatus: orderStatus,
  //         orderType: orderType);
  //     setState(ViewStatus.Completed);
  //   } catch (e) {
  //     setState(ViewStatus.Completed);
  //     showAlertDialog(title: "Lỗi đơn hàng", content: e.toString());
  //   }
  // }

  // void getOrderByStore(String orderId) async {
  //   setState(ViewStatus.Loading);
  //   qrCodeData = null;
  //   customerMoney = 0;
  //   Account? userInfo = await getUserInfo();

  //   await api.getOrderOfStore(userInfo!.storeId, orderId).then((value) => {
  //         currentOrder = value,
  //         value.orderStatus == OrderStatusEnum.PENDING
  //             ? currentPaymentStatusMessage =
  //                 "Vui lòng chọn phương thức thanh toán"
  //             : "Chưa thanh toán",
  //         setState(ViewStatus.Completed)
  //       });
  //   currentOrder!.discountProduct = 0;
  //   currentOrder!.productList?.forEach((element) {
  //     currentOrder!.discountProduct =
  //         currentOrder!.discountProduct! + element.discount!;
  //   });
  //   currentOrder!.discountPromotion = 0;
  //   currentOrder!.discountPromotion =
  //       currentOrder!.discount! - currentOrder!.discountProduct!;
  //   for (var element in listPayment) {
  //     if (element!.code! == currentOrder!.paymentType) {
  //       selectedPaymentMethod = element;
  //     }
  //   }
  //   paymentCheckingStatus = PaymentStatusEnum.CANCELED;
  //   setState(ViewStatus.Completed);
  // }

  // Future<void> completeOrder(
  //   String orderId,
  // ) async {
  //   Account? userInfo = await getUserInfo();
  //   if (selectedPaymentMethod == null) {
  //     await showAlertDialog(
  //         title: "Thông báo", content: "Vui lòng chọn phương thức thanh toán");
  //     return;
  //   }
  //   if (paymentCheckingStatus != PaymentStatusEnum.PAID) {
  //     await showAlertDialog(
  //         title: "Thông báo", content: "Vui lòng kiểm tra lại thanh toán");
  //     return;
  //   }
  //   await api.updateOrder(userInfo!.storeId, orderId, OrderStatusEnum.PAID,
  //       selectedPaymentMethod!.code);
  //   Get.find<PrinterViewModel>().printBill(currentOrder!, selectedTable,
  //       selectedPaymentMethod!.name ?? "Tiền mặt");
  //   clearOrder();
  //   await showAlertDialog(
  //       title: "Thanh toán thành công",
  //       content: "Đơn hàng thanh toán thành công");
  //   Duration(seconds: 2);
  //   chooseTableDialog();
  //   // Duration(seconds: 2);
  //   // await launchStoreLogo();
  // }

  clearOrder() {
    currentOrderId = null;
    currentOrder = null;
    selectedPaymentMethod = null;
    hideDialog();
  }
}

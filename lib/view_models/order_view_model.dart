import 'dart:core';

import 'package:deer_coffee/api/pointify/pointify_data.dart';
import 'package:deer_coffee/models/order_details.dart';
import 'package:deer_coffee/models/pointify/membership_transaction.dart';
import 'package:deer_coffee/utils/route_constrant.dart';
import 'package:deer_coffee/utils/share_pref.dart';
import 'package:get/get.dart';

import '../api/order_api.dart';
import '../enums/order_enum.dart';
import '../enums/view_status.dart';
import '../models/cart_model.dart';
import '../models/order_in_list.dart';
import '../models/order_response.dart';
import '../models/payment_provider.dart';
import '../widgets/other_dialogs/dialog.dart';
import 'base_view_model.dart';

class OrderViewModel extends BaseViewModel {
  int selectedTable = 01;
  late OrderAPI api = OrderAPI();
  String? currentOrderId;
  num customerMoney = 0;
  num returnMoney = 0;
  PointifyData pointifyData = PointifyData();
  OrderResponseModel? currentOrder;
  List<PaymentProvider?> listPayment = [];
  PaymentProvider? selectedPaymentMethod;

  List<OrderInList> listOrder = [];
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

  // void chooseDeliveryType(String type) {
  //   deliveryType = type;
  //   hideDialog();

  //   notifyListeners();
  // }

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

  Future<bool> placeOrder(CartModel order) async {
    showLoadingDialog();
    await api.placeOrder(order).then((value) =>
        {hideDialog(), Get.toNamed("${RouteHandler.ORDER_DETAILS}?id=$value")});
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

  void getListOrder(String orderStatus) async {
    try {
      setState(ViewStatus.Loading);

      String? userId = await getUserId();
      if (userId != null) {
        listOrder = await api.getListOrderOfUser(
          userId,
          orderStatus: orderStatus,
        );
      }
      setState(ViewStatus.Completed);
    } catch (e) {
      setState(ViewStatus.Completed);
      showAlertDialog(title: "Lỗi đơn hàng", content: e.toString());
    }
  }

  Future<List<MembershipTransaction>?> getListTransaction() async {
    try {
      setState(ViewStatus.Loading);

      String? userId = await getUserId();
      if (userId != null) {
        var listTrans = await pointifyData.getListTransactionOfUser(userId);
        if (listTrans != null) {
          setState(ViewStatus.Completed);
          return listTrans;
        }
      }
      setState(ViewStatus.Completed);
      return [];
    } catch (e) {
      setState(ViewStatus.Completed);
      showAlertDialog(title: "Lỗi đơn hàng", content: e.toString());
    }
    return null;
  }

  Future<OrderDetailsModel?> getOrderDetails(String orderId) async {
    try {
      setState(ViewStatus.Loading);
      OrderDetailsModel orderDetailsModel = await api.getOrderDetails(orderId);
      setState(ViewStatus.Completed);
      return orderDetailsModel;
    } catch (e) {
      setState(ViewStatus.Error, e.toString());
      return null;
    }
  }

  Future<void> updateOrder(
      String orderId, String? deliStatus, String? orderStatus) async {
    showLoadingDialog();
    await api.updateOrder(orderId, orderStatus, deliStatus);
    hideDialog();
  }

  clearOrder() {
    currentOrderId = null;
    currentOrder = null;
    selectedPaymentMethod = null;
    hideDialog();
  }
}

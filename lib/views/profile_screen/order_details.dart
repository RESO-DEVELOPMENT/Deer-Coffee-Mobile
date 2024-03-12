import 'package:deer_coffee/enums/order_enum.dart';
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/order_details.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/view_models/order_view_model.dart';
import 'package:deer_coffee/widgets/other_dialogs/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class OrderDetails extends StatefulWidget {
  final String id;
  const OrderDetails({super.key, required this.id});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  OrderDetailsModel? orderDetails;
  @override
  void initState() {
    Get.find<OrderViewModel>()
        .getOrderDetails(widget.id)
        .then((value) => orderDetails = value);
    super.initState();
  }

  refreshOrder() {
    Get.find<OrderViewModel>().getOrderDetails(widget.id).then((value) {
      setState(() {
        orderDetails = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: Get.find<OrderViewModel>(),
      child: ScopedModelDescendant<OrderViewModel>(
          builder: (context, build, model) {
        if (model.status == ViewStatus.Loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (orderDetails == null) {
          return const Center(
            child: Text("Đơn hàng không tồn tại"),
          );
        }
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              title: Text(orderDetails?.invoiceId ?? '',
                  style: Get.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: orderDetails?.orderStatus ==
                                              OrderStatusEnum.CANCELED
                                          ? EdgeInsets.only(left: 20.0)
                                          : EdgeInsets.zero,
                                      child: Text(
                                        showOrderStatus(
                                          orderDetails?.orderStatus !=
                                                  OrderStatusEnum.NEW
                                              ? (orderDetails?.orderStatus ==
                                                      OrderStatusEnum.CANCELED
                                                  ? OrderStatusEnum.CANCELED
                                                  : OrderStatusEnum.NEW)
                                              : OrderStatusEnum.NEW,
                                        ),
                                        style:
                                            Get.textTheme.labelSmall?.copyWith(
                                          color: orderDetails?.orderStatus !=
                                                  OrderStatusEnum.CANCELED
                                              ? ThemeColor.primary
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                    Row(),
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Text(
                                        showOrderStatus(OrderStatusEnum.PAID),
                                        style:
                                            Get.textTheme.labelSmall?.copyWith(
                                          color: orderDetails?.orderStatus !=
                                                  OrderStatusEnum.CANCELED
                                              ? ((orderDetails?.orderStatus ==
                                                      OrderStatusEnum.PAID)
                                                  ? ThemeColor.primary
                                                  : Colors.grey)
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Row(),
                                    Container(
                                      child: Text(
                                        showUserDeiliStatus(
                                            DeliStatusEnum.DELIVERED),
                                        style:
                                            Get.textTheme.labelSmall?.copyWith(
                                          color: orderDetails?.orderStatus !=
                                                  OrderStatusEnum.CANCELED
                                              ? ((orderDetails?.customerInfo
                                                          ?.deliStatus ==
                                                      DeliStatusEnum.DELIVERED)
                                                  ? ThemeColor.primary
                                                  : Colors.grey)
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(32, 0, 8, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: orderDetails?.orderStatus ==
                                              OrderStatusEnum.CANCELED
                                          ? Colors.red
                                          : ThemeColor.primary,
                                    ),
                                    Transform.rotate(
                                      angle: 0 * (3.14159265359 / 180),
                                      child: Container(
                                        height: 5,
                                        width: Get.width * 0.1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          color: (orderDetails?.orderStatus !=
                                                  OrderStatusEnum.CANCELED
                                              ? (orderDetails?.orderStatus ==
                                                      OrderStatusEnum.CANCELED
                                                  ? Colors.red
                                                  : ThemeColor.primary)
                                              : Colors.grey),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.circle,
                                      color: (orderDetails?.orderStatus !=
                                              OrderStatusEnum.CANCELED
                                          ? (orderDetails?.orderStatus ==
                                                  OrderStatusEnum.CANCELED
                                              ? Colors.red
                                              : ThemeColor.primary)
                                          : Colors.grey),
                                    ),
                                    Transform.rotate(
                                      angle: 0 * (3.14159265359 / 180),
                                      child: Container(
                                        height: 5,
                                        width: Get.width * 0.1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          color: orderDetails?.orderStatus !=
                                                  OrderStatusEnum.CANCELED
                                              ? ((orderDetails?.orderStatus ==
                                                      OrderStatusEnum.PAID)
                                                  ? ThemeColor.primary
                                                  : Colors.grey)
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.circle,
                                      color: orderDetails?.orderStatus !=
                                              OrderStatusEnum.CANCELED
                                          ? ((orderDetails?.orderStatus ==
                                                  OrderStatusEnum.PAID)
                                              ? ThemeColor.primary
                                              : Colors.grey)
                                          : Colors.grey,
                                    ),
                                    Transform.rotate(
                                      angle: 0 * (3.14159265359 / 180),
                                      child: Container(
                                        height: 5,
                                        width: Get.width * 0.1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          color: orderDetails?.orderStatus !=
                                                  OrderStatusEnum.CANCELED
                                              ? ((orderDetails?.customerInfo
                                                              ?.deliStatus ==
                                                          DeliStatusEnum
                                                              .DELIVERING ||
                                                      orderDetails?.customerInfo
                                                              ?.deliStatus ==
                                                          DeliStatusEnum
                                                              .DELIVERED)
                                                  ? ThemeColor.primary
                                                  : Colors.grey)
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.circle,
                                      color: orderDetails?.orderStatus !=
                                              OrderStatusEnum.CANCELED
                                          ? ((orderDetails?.customerInfo
                                                          ?.deliStatus ==
                                                      DeliStatusEnum
                                                          .DELIVERING ||
                                                  orderDetails?.customerInfo
                                                          ?.deliStatus ==
                                                      DeliStatusEnum.DELIVERED)
                                              ? ThemeColor.primary
                                              : Colors.grey)
                                          : Colors.grey,
                                    ),
                                    Transform.rotate(
                                      angle: 0 * (3.14159265359 / 180),
                                      child: Container(
                                        height: 5,
                                        width: Get.width * 0.1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          color: orderDetails?.orderStatus !=
                                                  OrderStatusEnum.CANCELED
                                              ? ((orderDetails?.customerInfo
                                                          ?.deliStatus ==
                                                      DeliStatusEnum.DELIVERED)
                                                  ? ThemeColor.primary
                                                  : Colors.grey)
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.circle,
                                      color: orderDetails?.orderStatus !=
                                              OrderStatusEnum.CANCELED
                                          ? ((orderDetails?.customerInfo
                                                      ?.deliStatus ==
                                                  DeliStatusEnum.DELIVERED)
                                              ? ThemeColor.primary
                                              : Colors.grey)
                                          : Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 45),
                                        child: Text(
                                          showOrderStatus(
                                            orderDetails?.orderStatus !=
                                                    OrderStatusEnum.CANCELED
                                                ? (OrderStatusEnum.CANCELED ==
                                                        OrderStatusEnum.CANCELED
                                                    ? OrderStatusEnum.PENDING
                                                    : OrderStatusEnum.CANCELED)
                                                : OrderStatusEnum.PENDING,
                                          ),
                                          style: Get.textTheme.labelSmall
                                              ?.copyWith(
                                                  color: orderDetails
                                                              ?.orderStatus !=
                                                          OrderStatusEnum
                                                              .CANCELED
                                                      ? (orderDetails
                                                                  ?.orderStatus ==
                                                              OrderStatusEnum
                                                                  .CANCELED
                                                          ? Colors.red
                                                          : ThemeColor.primary)
                                                      : Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 20),
                                        child: Text(
                                          showUserDeiliStatus(
                                              DeliStatusEnum.DELIVERING),
                                          style: Get.textTheme.labelSmall
                                              ?.copyWith(
                                            color: orderDetails?.orderStatus !=
                                                    OrderStatusEnum.CANCELED
                                                ? ((orderDetails?.customerInfo
                                                                ?.deliStatus ==
                                                            DeliStatusEnum
                                                                .DELIVERING ||
                                                        orderDetails
                                                                ?.customerInfo
                                                                ?.deliStatus ==
                                                            DeliStatusEnum
                                                                .DELIVERED)
                                                    ? ThemeColor.primary
                                                    : Colors.grey)
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        Text('Sản phẩm',
                            style: Get.textTheme.labelMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: orderDetails!.productList!
                                    .map((e) => productCard(e))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        Text('Thanh toán',
                            style: Get.textTheme.labelMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            color: Colors.white,
                          ),
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tạm tính",
                                      style: Get.textTheme.labelSmall,
                                    ),
                                    Text(
                                      formatPrice(
                                          orderDetails?.totalAmount ?? 0),
                                      style: Get.textTheme.labelSmall,
                                    )
                                  ],
                                ),
                                buildOrderPromotion(orderDetails!),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Giảm giá",
                                      style: Get.textTheme.labelSmall,
                                    ),
                                    Text(
                                      "-" +
                                          formatPrice(
                                              orderDetails?.discount ?? 0),
                                      style: Get.textTheme.labelSmall,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tổng cộng",
                                      style: Get.textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      formatPrice(
                                          orderDetails?.finalAmount ?? 0),
                                      style: Get.textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text('Chi tiết đơn hàng',
                            style: Get.textTheme.labelMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Ngày đặt hàng',
                                      style: Get.textTheme.labelSmall),
                                  Text(
                                    formatTime(orderDetails?.checkInDate ??
                                        "2023-01-01T00:00:00.00000"),
                                    style: Get.textTheme.labelSmall,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Thanh toán',
                                      style: Get.textTheme.labelSmall),
                                  Text(
                                    showPaymentType(orderDetails?.paymentType ??
                                        PaymentTypeEnums.CASH),
                                    style: Get.textTheme.labelSmall,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Loại đơn hàng',
                                      style: Get.textTheme.labelSmall),
                                  Text(
                                    showOrderType(orderDetails?.orderType ??
                                        OrderTypeEnum.EAT_IN),
                                    style: Get.textTheme.labelSmall,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Địa chỉ',
                                      style: Get.textTheme.labelSmall),
                                  Text(
                                    orderDetails?.customerInfo?.address ?? '',
                                    style: Get.textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: QrImageView(
                              data: orderDetails?.orderId ?? '',
                              version: QrVersions.auto,
                              size: 160.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: () {
                        if (orderDetails?.orderStatus == OrderStatusEnum.PAID &&
                            orderDetails?.customerInfo?.deliStatus !=
                                DeliStatusEnum.DELIVERED) {
                          showConfirmDialog(
                                  title: "Thông báo",
                                  content: "Xác nhận đã nhận được hàng",
                                  confirmText: "Xác nhận",
                                  cancelText: "Đóng")
                              .then((value) async => {
                                    if (value)
                                      {
                                        await model.updateOrder(
                                            orderDetails?.orderId ?? '',
                                            DeliStatusEnum.DELIVERED,
                                            orderDetails?.orderStatus ?? ''),
                                        refreshOrder()
                                      }
                                  });
                        } else if (orderDetails?.customerInfo?.deliStatus ==
                            DeliStatusEnum.DELIVERED) {
                          showAlertDialog(
                              title: "Thông báo",
                              content: "Đơn hàng đã được giao thành công");
                        } else if (orderDetails?.orderStatus ==
                            OrderStatusEnum.CANCELED) {
                          showAlertDialog(
                              title: "Thông báo",
                              content: "Đơn hàng đã bị huỷ");
                        } else {
                          showAlertDialog(
                              title: "Thông báo",
                              content: "Đơn hàng đang thực hiện");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            orderDetails?.customerInfo?.deliStatus ==
                                        DeliStatusEnum.DELIVERED ||
                                    orderDetails?.orderStatus ==
                                        OrderStatusEnum.CANCELED
                                ? Colors.white
                                : ThemeColor.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Đã nhận hàng',
                          style: TextStyle(
                            color: orderDetails?.customerInfo?.deliStatus ==
                                        DeliStatusEnum.DELIVERED ||
                                    orderDetails?.orderStatus ==
                                        OrderStatusEnum.CANCELED
                                ? Colors.grey
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: OutlinedButton(
                      onPressed: () {
                        if (orderDetails?.orderStatus ==
                            OrderStatusEnum.PENDING) {
                          showConfirmDialog(
                                  title: "Huỷ đơn hàng",
                                  content: "Bạn có chắc huỷ đơn hàng này",
                                  confirmText: "Huỷ đơn",
                                  cancelText: "Đóng")
                              .then((value) async => {
                                    if (value)
                                      {
                                        await model.updateOrder(
                                            orderDetails?.orderId ?? '',
                                            DeliStatusEnum.CANCELED,
                                            OrderStatusEnum.CANCELED),
                                        refreshOrder()
                                      }
                                  });
                        } else {
                          showAlertDialog(
                              title: "Thông báo",
                              content: "Đơn hàng khồn thể huỷ vào lúc này");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(
                              color: orderDetails?.orderStatus ==
                                      OrderStatusEnum.PENDING
                                  ? Colors.redAccent
                                  : Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Hủy đơn',
                          style: TextStyle(
                              color: orderDetails?.orderStatus ==
                                      OrderStatusEnum.PENDING
                                  ? Colors.redAccent
                                  : Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      }),
    );
  }

  Widget productCard(ProductList e) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: Text(e.name ?? '', style: Get.textTheme.labelSmall)),
          Text(
            ' x${e.quantity}  ',
            style: Get.textTheme.labelSmall,
          ),
          Text(
            formatPrice(e.finalAmount ?? 0),
            style: Get.textTheme.labelSmall,
          ),
        ],
      ),
    );
  }

  Widget buildOrderPromotion(OrderDetailsModel orderDetailsModel) {
    if (orderDetailsModel.promotionList == null) {
      return const Placeholder();
    }

    return Column(
        children: orderDetailsModel.promotionList!
            .map(
              (e) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    " - ${e.promotionName}",
                    style: Get.textTheme.labelSmall,
                  ),
                  Text(
                    e.effectType == "GET_POINT"
                        ? ("+${e.discountAmount} Điểm")
                        : ("- ${formatPrice(e.discountAmount ?? 0)}"),
                    style: Get.textTheme.labelSmall,
                  )
                ],
              ),
            )
            .toList());
  }
}

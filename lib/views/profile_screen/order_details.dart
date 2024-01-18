import 'package:deer_coffee/enums/order_enum.dart';
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/order_details.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/view_models/order_view_model.dart';
import 'package:deer_coffee/widgets/other_dialogs/dialog.dart';
import 'package:flutter/material.dart';
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
                  style: Get.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              showOrderStatus(orderDetails?.orderStatus ==
                                      OrderStatusEnum.CANCELED
                                  ? OrderStatusEnum.CANCELED
                                  : OrderStatusEnum.PENDING),
                              style: Get.textTheme.bodyMedium?.copyWith(
                                color: orderDetails?.orderStatus !=
                                        OrderStatusEnum.CANCELED
                                    ? ThemeColor.primary
                                    : Colors.red,
                              ),
                            ),
                            Text(
                              showOrderStatus(OrderStatusEnum.PAID),
                              style: Get.textTheme.bodyMedium?.copyWith(
                                color: orderDetails?.orderStatus !=
                                        OrderStatusEnum.CANCELED
                                    ? ((orderDetails?.orderStatus ==
                                            OrderStatusEnum.PAID)
                                        ? ThemeColor.primary
                                        : Colors.grey)
                                    : Colors.grey,
                              ),
                            ),
                            Text(
                              showUserDeiliStatus(DeliStatusEnum.DELIVERING),
                              style: Get.textTheme.bodyMedium?.copyWith(
                                color: orderDetails?.orderStatus !=
                                        OrderStatusEnum.CANCELED
                                    ? ((orderDetails?.customerInfo
                                                    ?.deliStatus ==
                                                DeliStatusEnum.DELIVERING ||
                                            orderDetails?.customerInfo
                                                    ?.deliStatus ==
                                                DeliStatusEnum.DELIVERED)
                                        ? ThemeColor.primary
                                        : Colors.grey)
                                    : Colors.grey,
                              ),
                            ),
                            Text(
                              showUserDeiliStatus(DeliStatusEnum.DELIVERED),
                              style: Get.textTheme.bodyMedium?.copyWith(
                                color: orderDetails?.orderStatus !=
                                        OrderStatusEnum.CANCELED
                                    ? ((orderDetails
                                                ?.customerInfo?.deliStatus ==
                                            DeliStatusEnum.DELIVERED)
                                        ? ThemeColor.primary
                                        : Colors.grey)
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.circle,
                                color: orderDetails?.orderStatus !=
                                        OrderStatusEnum.CANCELED
                                    ? ThemeColor.primary
                                    : Colors.red,
                              ),
                              Transform.rotate(
                                angle: 0 * (3.14159265359 / 180),
                                child: Container(
                                  height: 5,
                                  width: Get.width * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
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
                                  width: Get.width * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: orderDetails?.orderStatus !=
                                            OrderStatusEnum.CANCELED
                                        ? ((orderDetails?.customerInfo
                                                        ?.deliStatus ==
                                                    DeliStatusEnum.DELIVERING ||
                                                orderDetails?.customerInfo
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
                                                DeliStatusEnum.DELIVERING ||
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
                                  width: Get.width * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
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
                                    ? ((orderDetails
                                                ?.customerInfo?.deliStatus ==
                                            DeliStatusEnum.DELIVERED)
                                        ? ThemeColor.primary
                                        : Colors.grey)
                                    : Colors.grey,
                              ),
                            ],
                          ),
                        ),

                        Text('Sản phẩm',
                            style: Get.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Column(
                          children: orderDetails!.productList!
                              .map((e) => productCard(e))
                              .toList(),
                        ),

                        // Chi tiết đơn hàng
                        const Divider(),
                        Text('Thanh toán',
                            style: Get.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Tạm tính",
                              style: Get.textTheme.bodySmall,
                            ),
                            Text(
                              formatPrice(orderDetails?.totalAmount ?? 0),
                              style: Get.textTheme.bodySmall,
                            )
                          ],
                        ),
                        buildOrderPromotion(orderDetails!),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Giảm giá",
                              style: Get.textTheme.bodySmall,
                            ),
                            Text(
                              "-" + formatPrice(orderDetails?.discount ?? 0),
                              style: Get.textTheme.bodySmall,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Tổng cộng",
                              style: Get.textTheme.bodyMedium,
                            ),
                            Text(
                              formatPrice(orderDetails?.finalAmount ?? 0),
                              style: Get.textTheme.bodyMedium,
                            )
                          ],
                        ),
                        const Divider(),
                        Text('Chi tiết đơn hàng',
                            style: Get.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Mã đơn',
                              style: Get.textTheme.bodyMedium,
                            ),
                            Text(
                              orderDetails?.invoiceId ?? '',
                              style: Get.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Ngày đặt hàng',
                                style: Get.textTheme.bodyMedium),
                            Text(
                              formatTime(orderDetails?.checkInDate ??
                                  "2023-01-01T00:00:00.00000"),
                              style: Get.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Thanh toán', style: Get.textTheme.bodyMedium),
                            Text(
                              showPaymentType(orderDetails?.paymentType ??
                                  PaymentTypeEnums.CASH),
                              style: Get.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Loại đơn hàng',
                                style: Get.textTheme.bodyMedium),
                            Text(
                              showOrderType(orderDetails?.orderType ??
                                  OrderTypeEnum.EAT_IN),
                              style: Get.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Trạng thái', style: Get.textTheme.bodyMedium),
                            Text(
                              showOrderStatus(orderDetails?.orderStatus ??
                                  OrderStatusEnum.CANCELED),
                              style: Get.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Trạng thái giao hàng',
                                style: Get.textTheme.bodyMedium),
                            Text(
                              showUserDeiliStatus(
                                  orderDetails?.customerInfo?.deliStatus ??
                                      DeliStatusEnum.PENDING),
                              style: Get.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Địa chỉ', style: Get.textTheme.bodyMedium),
                            Text(
                              orderDetails?.customerInfo?.address ?? '',
                              style: Get.textTheme.bodyMedium,
                            ),
                          ],
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
                          height: 32,
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
              child: Text(e.name ?? '', style: Get.textTheme.bodyMedium)),
          Text(
            ' x${e.quantity}  ',
            style: Get.textTheme.bodyMedium,
          ),
          Text(
            formatPrice(e.finalAmount ?? 0),
            style: Get.textTheme.bodyMedium,
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
                    style: Get.textTheme.bodySmall,
                  ),
                  Text(
                    e.effectType == "GET_POINT"
                        ? ("+${e.discountAmount} Điểm")
                        : ("- ${formatPrice(e.discountAmount ?? 0)}"),
                    style: Get.textTheme.bodySmall,
                  )
                ],
              ),
            )
            .toList());
  }
}

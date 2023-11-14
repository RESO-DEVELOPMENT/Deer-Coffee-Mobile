import 'package:deer_coffee/enums/order_enum.dart';
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/collection.dart';
import 'package:deer_coffee/models/order_details.dart';
import 'package:deer_coffee/models/product.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/utils/route_constrant.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:deer_coffee/view_models/order_view_model.dart';
import 'package:deer_coffee/widgets/time_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('Chi tiết đơn hàng',
            style: Get.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: ScopedModel<OrderViewModel>(
        model: Get.find<OrderViewModel>(),
        child: ScopedModelDescendant<OrderViewModel>(
            builder: (context, build, model) {
          if (model.status == ViewStatus.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (orderDetails == null) {
            return Center(
              child: Text("Đơn hàng không tồn tại"),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text('Sản phẩn',
                          style: Get.textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Column(
                        children: orderDetails!.productList!
                            .map((e) => productCard(e))
                            .toList(),
                      ),

                      // Chi tiết đơn hàng
                      Divider(),
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
                      Divider(),
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
                          Text('Địa chỉ', style: Get.textTheme.bodyMedium),
                          Text(
                            orderDetails?.customerInfo?.address ?? '',
                            style: Get.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
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

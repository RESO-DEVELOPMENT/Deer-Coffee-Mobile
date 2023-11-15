import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/views/membership_screen/voucher_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../widgets/promotion_widget.dart';

class Voucher extends StatefulWidget {
  const Voucher({Key? key}) : super(key: key);

  @override
  State<Voucher> createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Ưu đãi của bạn',
            style: Get.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: ScopedModel<CartViewModel>(
        model: Get.find<CartViewModel>(),
        child: ScopedModelDescendant<CartViewModel>(
            builder: (context, build, model) {
          if (model.status == ViewStatus.Loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (model.promotions == []) {
            return Center(
              child: Text("Không có khuyến mãi nào có sẵn"),
            );
          }
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(8),
              color: Color(0xFFF5F5F5), // Màu F5F5F5 cho nền body
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Dành riêng cho bạn",
                    style: Get.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Column(
                      children: model.promotions!
                          .map((e) => buildTicketWidget(
                              e,
                              model.cart.promotionCode == e.promotionCode,
                              model))
                          .toList()),
                  Text(
                    "Khuyến mãi có sẵn",
                    style: Get.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Column(
                      children: model.promotions!
                          .map((e) => buildTicketWidget(
                              e,
                              model.cart.promotionCode == e.promotionCode,
                              model))
                          .toList()),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

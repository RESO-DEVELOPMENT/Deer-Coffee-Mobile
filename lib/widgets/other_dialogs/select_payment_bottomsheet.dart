import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../enums/view_status.dart';

Future<void> selectPayment() async {
  Get.bottomSheet(ScopedModel<CartViewModel>(
    model: Get.find<CartViewModel>(),
    child:
        ScopedModelDescendant<CartViewModel>(builder: (context, build, model) {
      if (model.status == ViewStatus.Loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (model.listPayment == []) {
        return const Center(child: Text("Không có phương thức thanh toán nào"));
      }
      return Container(
        height: 340,
        color: Color(0xFFF7F8FB),
        width: Get.width,
        child: Column(
          children: [
            Row(
              children: [
                // Căn giữa văn bản
                Expanded(
                  child: Center(
                    child: Text(
                      'Phương thức thanh toán',
                      style: Get.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                // Căn giữa biểu tượng
                Center(
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              child: Column(
                  children: model.listPayment
                      .map((e) => InkWell(
                            onTap: () {
                              model.setPayment(e.code);
                              Get.back();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 8),
                              width: Get.width,
                              height: 80,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: model.cart.paymentType == e.code
                                    ? Colors.grey[200]
                                    : Colors.white,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Image widget here
                                  Image.network(
                                    width: 60,
                                    height: 60,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    e.icon == null
                                        ? 'https://i.imgur.com/X0WTML2.jpg'
                                        : e.icon ??
                                            'https://i.imgur.com/X0WTML2.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e.name ?? '',
                                            style: Get.textTheme.bodyMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        Text(
                                          e.name ?? '',
                                          style: Get.textTheme.bodySmall,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList()),
            )
          ],
        ),
      );
    }),
  ));
}

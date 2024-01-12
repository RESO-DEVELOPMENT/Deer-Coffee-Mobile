import 'package:deer_coffee/enums/order_enum.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../enums/view_status.dart';
import '../utils/route_constrant.dart';

Future<void> showSelectStore() async {
  Get.bottomSheet(ScopedModel<MenuViewModel>(
    model: Get.find<MenuViewModel>(),
    child:
        ScopedModelDescendant<MenuViewModel>(builder: (context, build, model) {
      if (model.status == ViewStatus.Loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (model.storeList == []) {
        return const Center(child: Text("Không có cửa hàng nào"));
      }
      return Container(
        height: 300,
        color: Colors.white,
        width: Get.width,
        child: Column(
          children: [
            Row(
              children: [
                // Căn giữa văn bản
                const Expanded(
                  child: Center(
                    child: Text(
                      'Chọn cửa hàng',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  children: model.storeList!
                      .map((e) => InkWell(
                            onTap: () {
                              model.setStore(e);
                              Get.find<CartViewModel>()
                                  .setOrderType(OrderTypeEnum.EAT_IN);
                              Get.back();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 8),
                              width: Get.width,
                              height: 110,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: const Color(0xFFF7F8FB),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Image widget here
                                  Image.asset(
                                    'assets/images/logo.png',
                                    height: 80.0,
                                    width: 80.0,
                                  ),
                                  SizedBox(width: 4),
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
                                          e.address ?? '',
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

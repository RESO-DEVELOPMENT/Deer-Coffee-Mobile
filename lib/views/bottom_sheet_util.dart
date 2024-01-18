import 'package:deer_coffee/enums/order_enum.dart';
import 'package:deer_coffee/utils/theme.dart';
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
        height: 360,
        color: Color(0xFFF7F8FB),
        width: Get.width,
        padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 24,
                ),
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
            Column(
                children: model.storeList!
                    .map((e) => InkWell(
                          onTap: () {
                            model.setStore(e);
                            Get.find<CartViewModel>()
                                .setOrderType(OrderTypeEnum.TAKE_AWAY);
                            Get.back();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            width: Get.width,
                            height: 100,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: model.selectedStore?.id == e.id
                                  ? ThemeColor.primary
                                  : Colors.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Image widget here

                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.name ?? '',
                                        style: Get.textTheme.bodyMedium
                                            ?.copyWith(
                                                color:
                                                    model.selectedStore?.id ==
                                                            e.id
                                                        ? Colors.white
                                                        : Colors.black,
                                                fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                      ),
                                      Text(
                                        e.address ?? '',
                                        style:
                                            Get.textTheme.bodySmall?.copyWith(
                                          color: model.selectedStore?.id == e.id
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList())
          ],
        ),
      );
    }),
  ));
}

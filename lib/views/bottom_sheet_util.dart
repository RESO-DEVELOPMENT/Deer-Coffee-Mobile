import 'package:deer_coffee/enums/order_enum.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:deer_coffee/widgets/other_dialogs/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../enums/view_status.dart';

Future<void> showSelectStore() async {
  CartViewModel cartViewModel = Get.find<CartViewModel>();
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
        color: const Color(0xFFF7F8FB),
        width: Get.width,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 24,
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Chọn cửa hàng',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Center(
                  child: IconButton(
                    icon: const Icon(Icons.close),
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
                            showConfirmDialog(
                              title: "Thông báo",
                              content:
                                  "Giỏ hàng của bạn sẽ bị xóa sau khi thay đổi của hàng. Bạn có chắc chắn muốn thay đổi cửa hàng không?",
                              confirmText: "Xác nhận",
                            ).then((value) => {
                                  if (value)
                                    {
                                      model.setStore(e),
                                      Get.find<CartViewModel>().setOrderType(
                                          OrderTypeEnum.TAKE_AWAY),
                                      cartViewModel.clearCartData(),
                                      Get.back()
                                    }
                                  else
                                    {Get.back()}
                                });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            width: Get.width,
                            height: 120,
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
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.name ?? '',
                                        style: Get.textTheme.bodySmall
                                            ?.copyWith(
                                                color:
                                                    model.selectedStore?.id ==
                                                            e.id
                                                        ? Colors.white
                                                        : Colors.black,
                                                fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        e.address ?? '',
                                        style:
                                            Get.textTheme.labelSmall?.copyWith(
                                          color: model.selectedStore?.id == e.id
                                              ? Colors.white
                                              : Colors.black,
                                        ),
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
                    .toList())
          ],
        ),
      );
    }),
  ));
}

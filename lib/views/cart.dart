import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/views/order_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../enums/order_enum.dart';
import '../utils/route_constrant.dart';
import 'bottom_sheet_util.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  @override
  void initState() {
    Get.find<CartViewModel>().checkPromotion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CartViewModel>(
      model: Get.find<CartViewModel>(),
      child: Scaffold(
        backgroundColor: Color(0xFFF7F8FB),
        appBar: AppBar(
          title: Text("Giỏ hàng",
              style: Get.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ),
        body: ScopedModelDescendant<CartViewModel>(
            builder: (context, build, model) {
          if (model.status == ViewStatus.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  showOrderType(model.deliveryType ?? ''),
                  style: Get.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              InkWell(
                onTap: () {
                  showSelectStore();
                },
                child: Container(
                    width: Get.width,
                    height: 50,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on),
                        Expanded(
                          child: Text(
                            model.deliAddress ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Danh sách món",
                  style: Get.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: model.cartList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: Key(model.cartList[index].product.id ?? ''),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            model.removeFromCart(index);
                          },
                          borderRadius: BorderRadius.circular(10),
                          backgroundColor: Color.fromRGBO(255, 229, 229, 1.0),
                          icon: Icons.delete_outline,
                          foregroundColor: Colors.red,
                        ),
                      ],
                    ),
                    child: Container(
                      width: Get.width,
                      height: 100,
                      padding: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: Image.network(
                                model.cartList[index].product.picUrl!.isEmpty
                                    ? 'https://i.imgur.com/X0WTML2.jpg'
                                    : model.cartList[index].product.picUrl ??
                                        '',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(model.cartList[index].product.name!,
                                        style: Get.textTheme.bodyMedium),
                                    Text("x ${model.cartList[index].quantity}",
                                        style: Get.textTheme.bodyMedium)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${model.cartList[index].attributes?[0].name}' +
                                          ' ${model.cartList[index].attributes![0].value}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Get.textTheme.bodySmall,
                                    ),
                                    Text(
                                      '| ${model.cartList[index].attributes?[1].name}' +
                                          ' ${model.cartList[index].attributes![1].value}',
                                      style: Get.textTheme.bodySmall,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Text(
                                  model.cartList[index].note ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Get.textTheme.bodySmall,
                                ),
                                Text(
                                    formatPrice(
                                        model.cartList[index].totalAmount),
                                    style: Get.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Thanh toán",
                  style: Get.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              buildPromotionEffect(model),
            ],
          );
        }),
        bottomNavigationBar: ScopedModelDescendant<CartViewModel>(
            builder: (context, build, model) {
          return Container(
            width: Get.width,
            color: Colors.white,
            height: 140,
            padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            showPaymentType(model.paymentType),
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            Get.toNamed(RouteHandler.VOUCHER);
                          },
                          child: Text(
                              model.selectPromotionCode ?? ' THÊM KHUYẾN MÃI')),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Tổng cộng"),
                          Text(
                            formatPrice(model.finalAmount),
                            style: Get.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  isDismissible: false,
                                  builder: (context) {
                                    return BottomSheetContent();
                                  });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              backgroundColor: Colors.lightBlue,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Đặt Hàng",
                                  style: Get.textTheme.titleMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
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

  Widget buildPromotionEffect(CartViewModel model) {
    if (model.selectedPromotionChecked == null ||
        model.selectedPromotionChecked?.order?.effects == null) {
      return SizedBox(
        width: 1,
      );
    }
    return Container(
      width: Get.width,
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tạm tính",
                style: Get.textTheme.bodyLarge,
              ),
              Text(
                formatPrice(model.totalAmount),
                style: Get.textTheme.bodyLarge,
              )
            ],
          ),
          Column(
              children: model.selectedPromotionChecked!.order!.effects!
                  .map(
                    (e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(e.promotionName ?? ''),
                        Text(e.effectType == "GET_POINT"
                            ? (model.pointRedeem.toInt().toString())
                            : formatPrice(e.prop?.value ?? 0))
                      ],
                    ),
                  )
                  .toList()),
        ],
      ),
    );
  }
}

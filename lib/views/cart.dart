import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:deer_coffee/views/order_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../enums/order_enum.dart';
import '../utils/route_constrant.dart';
import '../widgets/other_dialogs/dialog.dart';
import '../widgets/other_dialogs/select_payment_bottomsheet.dart';
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
    Get.find<CartViewModel>().prepareOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CartViewModel>(
      model: Get.find<CartViewModel>(),
      child: Scaffold(
        backgroundColor: Color(0xFFF7F8FB),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.offAllNamed(RouteHandler.HOME);
              },
              icon: Icon(Icons.arrow_back_ios)),
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
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      showOrderType(
                          model.cart.orderType ?? 'Vui lòng chọn địa chỉ'),
                      style: Get.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 36,
                    child: TextButton(
                        onPressed: () {
                          if (model.cart.orderType == OrderTypeEnum.EAT_IN) {
                            inputDialog(
                                    "Giao hàng đến",
                                    "Vui lòng nhập địa chỉ",
                                    model.cart.deliveryAddress,
                                    isNum: false)
                                .then((value) => {
                                      if (value != null)
                                        {
                                          model.setAddress(value),
                                        }
                                    });
                            model.setOrderType(OrderTypeEnum.DELIVERY);
                          } else {
                            showSelectStore();
                          }
                        },
                        child: Text(
                          "Thay đổi",
                          style: Get.textTheme.bodyMedium
                              ?.copyWith(color: ThemeColor.primary),
                        )),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  if (model.cart.orderType == OrderTypeEnum.DELIVERY) {
                    inputDialog("Giao hàng đến", "Vui lòng nhập địa chỉ",
                            model.cart.deliveryAddress,
                            isNum: false)
                        .then((value) => {
                              if (value != null) {model.setAddress(value)}
                            });
                  } else {
                    showSelectStore();
                  }
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
                            model.cart.orderType == OrderTypeEnum.DELIVERY
                                ? (model.cart.deliveryAddress ??
                                    "Vui lòng chọn địa chỉ nhận hàng")
                                : (Get.find<MenuViewModel>()
                                        .selectedStore
                                        ?.name ??
                                    ''),
                            maxLines: 2,
                            style: Get.textTheme.bodySmall,
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
                  style: Get.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: model.cart.productList!.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: Key(
                        model.cart.productList![index].productInMenuId ?? ''),
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
                      height: 80,
                      padding: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: Image.network(
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                                model.cart.productList![index].picUrl == null
                                    ? 'https://i.imgur.com/X0WTML2.jpg'
                                    : model.cart.productList![index].picUrl ??
                                        'https://i.imgur.com/X0WTML2.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${model.cart.productList![index].name!}   x${model.cart.productList![index].quantity}",
                                        style: Get.textTheme.bodyMedium),
                                    Text(
                                        formatPrice(model
                                                .cart
                                                .productList![index]
                                                .finalAmount ??
                                            0),
                                        style: Get.textTheme.bodyMedium),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${model.cart.productList![index].attributes?[0].name} ${model.cart.productList![index].attributes![0].value} ${model.cart.productList![index].attributes?[1].name} ${model.cart.productList![index].attributes![1].value}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Get.textTheme.bodySmall,
                                    ),
                                    Text(
                                        model.cart.productList![index]
                                                    .discount ==
                                                0
                                            ? ""
                                            : "-${formatPrice(model.cart.productList![index].discount ?? 0)}",
                                        style: Get.textTheme.bodySmall),
                                  ],
                                ),
                                Text(
                                  model.cart.productList![index].note ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Get.textTheme.bodySmall,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: model
                                      .cart.productList![index].extras?.length,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Text(
                                            " +${model.cart.productList![index].extras![i].name!}",
                                            style: Get.textTheme.bodySmall,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional.centerEnd,
                                            child: Text(
                                              formatPrice(model
                                                  .cart
                                                  .productList![index]
                                                  .extras![i]
                                                  .sellingPrice!),
                                              style: Get.textTheme.bodySmall,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
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
                  style: Get.textTheme.bodyMedium
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
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextButton.icon(
                          onPressed: () {
                            selectPayment();
                          },
                          icon: Icon(Icons.arrow_drop_down,
                              color: ThemeColor.primary),
                          label: Text(
                            showPaymentType(model.cart.paymentType ??
                                PaymentTypeEnums.CASH),
                            style: Get.textTheme.bodySmall
                                ?.copyWith(color: ThemeColor.primary),
                          )),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextButton.icon(
                          onPressed: () {
                            Get.toNamed(RouteHandler.VOUCHER);
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: ThemeColor.primary,
                          ),
                          label: Text(
                            model.cart.promotionCode ?? 'THÊM KHUYẾN MÃI',
                            style: Get.textTheme.bodySmall
                                ?.copyWith(color: ThemeColor.primary),
                          )),
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
                          Text(
                            "Tổng cộng",
                            style: Get.textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            formatPrice(model.cart.finalAmount ?? 0),
                            style: Get.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              // if (model.deliAddress == null) {
                              //   showAlertDialog(
                              //       title: "Chọn địa chỉ",
                              //       content: "Vui lòng chọn địa chỉ nhận hàng");
                              // } else {
                              //   model.createOrder();
                              // }
                              model.createOrder();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              backgroundColor: ThemeColor.primary,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
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
    if (model.cart.promotionList == null) {
      return const SizedBox(
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
                style: Get.textTheme.bodyMedium,
              ),
              Text(
                formatPrice(model.cart.totalAmount ?? 0),
                style: Get.textTheme.bodyMedium,
              )
            ],
          ),
          Column(
              children: model.cart.promotionList!
                  .map(
                    (e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          " - ${e.name}",
                          style: Get.textTheme.bodySmall,
                        ),
                        Text(
                          e.effectType == "GET_POINT"
                              ? ("+${e.discountAmount} Bean")
                              : ("-${formatPrice(e.discountAmount ?? 0)}"),
                          style: Get.textTheme.bodySmall,
                        )
                      ],
                    ),
                  )
                  .toList()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Giảm giá",
                style: Get.textTheme.bodyMedium,
              ),
              Text(
                "-${formatPrice(model.cart.discountAmount ?? 0)}",
                style: Get.textTheme.bodyMedium,
              )
            ],
          ),
        ],
      ),
    );
  }
}

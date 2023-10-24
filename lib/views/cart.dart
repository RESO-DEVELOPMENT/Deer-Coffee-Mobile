import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/views/order_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final itemList = [
    {
      'image': 'assets/images/coffee1.png',
      'title': 'Americano',
      'desc': '50% | medium | full ice',
      'sl': 'x 1',
    },
    {
      'image': 'assets/images/coffee1.png',
      'title': 'Cappuchino',
      'desc': '70% | medium | full ice',
      'sl': 'x 1',
    },
    {
      'image': 'assets/images/coffee1.png',
      'title': 'Flat White',
      'desc': 'single | iced | medium | full ice',
      'sl': 'x 1',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng",
            style: Get.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: ScopedModel<CartViewModel>(
        model: Get.find<CartViewModel>(),
        child: ScopedModelDescendant<CartViewModel>(
            builder: (context, build, model) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: model.cartList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(8),
                      child: Slidable(
                        key: Key(model.cartList[index].product.id ?? ''),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                model.removeFromCart(index);
                              },
                              borderRadius: BorderRadius.circular(10),
                              backgroundColor:
                                  Color.fromRGBO(255, 229, 229, 1.0),
                              icon: Icons.delete_outline,
                              foregroundColor: Colors.red,
                            ),
                          ],
                        ),
                        child: Container(
                          width: Get.width,
                          height: 96,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color(0xFFF7F8FB),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Image.network(
                                    model.cartList[index].product.picUrl!
                                            .isEmpty
                                        ? 'https://i.imgur.com/X0WTML2.jpg'
                                        : model.cartList[index].product
                                                .picUrl ??
                                            '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            model.cartList[index].product.name!,
                                            style: Get.textTheme.bodyLarge),
                                        Text(
                                            "x ${model.cartList[index].quantity}")
                                      ],
                                    ),
                                    Text(
                                      model.cartList[index].note ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                        formatPrice(
                                            model.cartList[index].totalAmount),
                                        style: Get.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: Get.width,
                height: 100,
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tổng cộng',
                          style: Get.textTheme.titleSmall,
                        ),
                        Text(formatPrice(model.totalAmount),
                            style: Get.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 16),
                        height: 50,
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
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

import 'package:deer_coffee/views/order_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
        title: Text("Giỏ hàng", style: Get.textTheme.titleLarge),
        backgroundColor: const Color(0xFFE5EDFF),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                final item = itemList[index];
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Slidable(
                    key: Key('$item'),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            setState(() {
                              itemList.removeAt(index);
                            });
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
                      height: 90,
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
                            child: Container(
                              width: 60,
                              height: 60,
                              child: Image.network(
                                item['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title']!,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                item['desc']!,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    item['sl']!,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Color.fromARGB(255, 108, 107, 107),
                                    ),
                                  ),
                                  Text(
                                    "35.000 đ",
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                    Text('200.000đ',
                        style: Get.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                Expanded(
                  flex: 2,
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
      ),
    );
  }
}

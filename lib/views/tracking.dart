import 'package:deer_coffee/models/collection.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:deer_coffee/views/order_determination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import 'home_page.dart';

class Tracking extends StatefulWidget {
  Tracking({Key? key}) : super(key: key);

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  int _currentIndex = 0;

  static Widget buildCircularButton(
      String text1, String image, Color textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            // Xử lý khi nhấn vào hình tròn ở đây
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
                image: DecorationImage(image: NetworkImage(image))),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          text1,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5EDFF),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/waving_hand.png',
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chào buổi sáng",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "Quốc Khánh",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 55,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.blue,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.confirmation_num_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 3),
                Container(
                  width: 50,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Ionicons.notifications_outline,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 1,
      ),
      body: ScopedModel<MenuViewModel>(
        model: Get.find<MenuViewModel>(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 240,
                    width: Get.width,
                    padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
                    child: ScopedModelDescendant<MenuViewModel>(
                        builder: (context, child, model) {
                      return GridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        padding: EdgeInsets.all(4),
                        children: model.categories!
                            .map(
                              (e) => buildCircularButton(
                                  e.name ?? '', e.picUrl ?? '', Colors.black),
                            )
                            .toList(),
                      );
                    })),
                SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: Get.width,
                  padding: EdgeInsets.all(16),
                  child: ScopedModelDescendant<MenuViewModel>(
                      builder: (context, child, model) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: model.collections!
                            .map((e) => collectionCard(e, model))
                            .toList());
                  }),
                ),
                // Đây là cột mới
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _changeItem(int value) {
    print(value);
    setState(() {
      _currentIndex = value;
    });
  }

  Widget collectionCard(Collection collection, MenuViewModel model) {
    List<Product> products = model.getProductsByCollection(collection.id);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          collection.name ?? '',
          style: Get.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.left, // Đặt chữ ở bên trái
        ),
        Column(
          children: products.map((e) => productCard(e)).toList(),
        )
      ],
    );
  }

  Widget productCard(Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // Đặt căn chỉnh các phần tử trong hàng lên trên cùng
        children: [
          Container(
            height: 80,
            width: 80,
            child: Image.network(product.picUrl ?? ''),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Đặt căn chỉnh theo chiều ngang sang trái
              children: [
                Text(
                  product.name ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                    height:
                        10), // Đặt khoảng cách giữa "Kiwi Yogurt" và "49.000đ"
                Text(
                  formatPrice(product.sellingPrice ?? 0),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Thêm nút "Add" và xử lý khi được nhấn
          IconButton.filled(
            icon: const Icon(
              Icons.add,
              size: 32,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      Option(), // Replace with your VoucherQr page
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

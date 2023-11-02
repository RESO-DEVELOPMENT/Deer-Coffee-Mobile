import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/product.dart';
import '../utils/format.dart';
import '../utils/route_constrant.dart';

class CollectionDetailsScreen extends StatefulWidget {
  final String id;
  const CollectionDetailsScreen({super.key, required this.id});

  @override
  State<CollectionDetailsScreen> createState() =>
      _CollectionDetailsScreenState();
}

class _CollectionDetailsScreenState extends State<CollectionDetailsScreen> {
  List<Product> productList = [];
  @override
  void initState() {
    productList = Get.find<MenuViewModel>().getProductsByCollection(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách sản phẩm",
          style:
              Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: productList.map((e) => productCard(e)).toList(),
      ),
    );
  }

  Widget productCard(Product product) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Get.toNamed("${RouteHandler.PRODUCT_DETAIL}?id=${product.id}");
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment
              .start, // Đặt căn chỉnh các phần tử trong hàng lên trên cùng
          children: [
            Container(
              width: 80,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Image.network(
                product.picUrl!.isEmpty
                    ? 'https://i.imgur.com/X0WTML2.jpg'
                    : product.picUrl!,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Đặt căn chỉnh theo chiều ngang sang trái
              children: [
                Text(product.name ?? "", style: Get.textTheme.titleSmall),
                SizedBox(
                    height:
                        10), // Đặt khoảng cách giữa "Kiwi Yogurt" và "49.000đ"
                Text(formatPrice(product.sellingPrice ?? 0),
                    style: Get.textTheme.titleMedium),
              ],
            ),
            // Thêm nút "Add" và xử lý khi được nhấn
          ],
        ),
      ),
    );
  }
}

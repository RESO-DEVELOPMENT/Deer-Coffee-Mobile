import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../models/product.dart';
import '../../utils/format.dart';
import '../../utils/route_constrant.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final String id;
  const CategoryDetailsScreen({super.key, required this.id});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  List<Product> productList = [];
  @override
  void initState() {
    productList =
        Get.find<MenuViewModel>().getNormalProductsByCategory(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sản phẩm trong danh mục",
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
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
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

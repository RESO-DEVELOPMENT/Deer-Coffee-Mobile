import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../models/product.dart';
import '../../utils/format.dart';
import '../../utils/route_constrant.dart';
import 'product_card.dart';

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
        children: productList.map((e) => ProductCard(product: e)).toList(),
      ),
    );
  }
}

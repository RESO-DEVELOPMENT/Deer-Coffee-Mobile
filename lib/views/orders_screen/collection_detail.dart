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
        centerTitle: true,
        title: Text(
          "Sản phẩm trong bộ sưu tập",
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

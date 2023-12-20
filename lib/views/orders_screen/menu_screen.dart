import 'package:deer_coffee/models/category.dart';
import 'package:deer_coffee/models/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/product.dart';
import '../../models/user.dart';
import '../../utils/route_constrant.dart';
import '../../utils/share_pref.dart';
import '../../utils/theme.dart';
import '../../view_models/account_view_model.dart';
import '../../view_models/cart_view_model.dart';
import '../../view_models/menu_view_model.dart';
import '../../widgets/other_dialogs/dialog.dart';
import 'product_card.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  ScrollController? _autoScrollController;

  String? userId;
  @override
  void initState() {
    _autoScrollController = ScrollController();
    getUserId().then((value) => userId = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ScopedModel<CartViewModel>(
        model: Get.find<CartViewModel>(),
        child: ScopedModelDescendant<CartViewModel>(
            builder: (context, build, model) {
          return FloatingActionButton(
              elevation: 2,
              backgroundColor: ThemeColor.primary,
              onPressed: () {
                if (model.cart.productList == null ||
                    model.cart.productList!.isEmpty) {
                  showAlertDialog(
                      title: "Giỏ hàng trống",
                      content:
                          "Giỏ hàng đang trống, vui lòng đặt sản phảm bạn nhé");
                } else if (userId == null) {
                  showAlertDialog(
                      title: "Người dùng chưa đăng nhập",
                      content:
                          "Vui lòng đăng nhập để đặt đơn và nhận ưu đãi nhé");
                } else {
                  Get.toNamed(RouteHandler.CART);
                }
              },
              tooltip: "1",
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ));
        }),
      ),
      body: ScopedModel<MenuViewModel>(
        model: Get.find<MenuViewModel>(),
        child: ScopedModelDescendant<MenuViewModel>(
            builder: (context, build, model) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                    width: Get.width * 0.2,
                    height: Get.height,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: model.categories!
                              .map((e) => collectionButton(e))
                              .toList(),
                        ),
                      ),
                    )),
                SizedBox(
                    width: Get.width * 0.75,
                    height: Get.height,
                    child: ListView(
                      shrinkWrap: true,
                      controller: _autoScrollController,
                      children: model.categories!
                          .map((e) => categoryCard(e, model))
                          .toList(),
                    ))
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget collectionButton(Category category) {
    return SizedBox(
      width: Get.width * 0.18,
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              // Xử lý khi nhấn vào hình tròn ở đây
              Get.toNamed(
                "${RouteHandler.CATEGORY_DETAIL}?id=${category.id}",
              );
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage(category.picUrl!.isEmpty
                          ? 'https://i.imgur.com/X0WTML2.jpg'
                          : category.picUrl!))),
            ),
          ),
          Text(
            category.name ?? '',
            style: Get.textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget categoryCard(Category category, MenuViewModel model) {
    List<Product> products = model.getNormalProductsByCategory(category.id);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            Get.toNamed("${RouteHandler.CATEGORY_DETAIL}?id=${category.id}");
          },
          child: Text(
            category.name ?? '',
            style:
                Get.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left, // Đặt chữ ở bên trái
          ),
        ),
        Column(
          children: products.map((e) => ProductCard(product: e)).toList(),
        )
      ],
    );
  }
}

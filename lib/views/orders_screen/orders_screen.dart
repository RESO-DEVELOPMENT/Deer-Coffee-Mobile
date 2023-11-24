import 'package:deer_coffee/models/collection.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:deer_coffee/views/orders_screen/product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/product.dart';
import '../../utils/route_constrant.dart';
import '../../utils/theme.dart';
import '../../view_models/account_view_model.dart';
import '../../widgets/app_bar/user_app_bar.dart';
import 'product_card.dart';
import '../home_screen/home_page.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModel<MenuViewModel>(
        model: Get.find<MenuViewModel>(),
        child: CustomScrollView(
          slivers: [
            ScopedModel<AccountViewModel>(
              model: Get.find<AccountViewModel>(),
              child: SliverAppBar(
                floating: true,
                pinned: true,
                title: ScopedModelDescendant<AccountViewModel>(
                    builder: (context, build, model) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Chào ngày mới!",
                                  style: Get.textTheme.bodyMedium),
                              Text(model.memberShipModel?.fullName ?? '',
                                  style: Get.textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.bold)),
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
                              borderRadius: BorderRadius.circular(12),
                              color: ThemeColor.primary,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.confirmation_num_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Get.toNamed(RouteHandler.VOUCHER);
                              },
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ThemeColor.primary,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.notifications_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ),
            ),
            SliverList.list(
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    child: ScopedModelDescendant<MenuViewModel>(
                        builder: (context, child, model) {
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        padding: const EdgeInsets.all(4),
                        children: model.categories!
                            .map(
                              (e) => buildCircularButton(
                                e.name ?? '',
                                e.picUrl ?? '',
                                e.id ?? '',
                              ),
                            )
                            .toList(),
                      );
                    })),
                Container(
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
              ],
            )

            // Đây là cột mới
          ],
        ),
      ),
    );
  }

  void _changeItem(int value) {
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
        TextButton(
          onPressed: () {
            Get.toNamed(
                "${RouteHandler.COLLECTION_DETAIL}?id=${collection.id}");
          },
          child: Text(
            collection.name ?? '',
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

  Widget buildCircularButton(
    String text1,
    String image,
    String categoryId, // Thêm tham số categoryId
  ) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              // Xử lý khi nhấn vào hình tròn ở đây
              Get.toNamed(
                "${RouteHandler.CATEGORY_DETAIL}?id=$categoryId",
              );
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage(image.isEmpty
                          ? 'https://i.imgur.com/X0WTML2.jpg'
                          : image))),
            ),
          ),
          Text(
            text1,
            style: Get.textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

import 'dart:js_interop';

import 'package:deer_coffee/models/category.dart';
import 'package:deer_coffee/models/collection.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:deer_coffee/views/orders_screen/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/product.dart';
import '../../models/user.dart';
import '../../utils/route_constrant.dart';
import '../../utils/share_pref.dart';
import '../../utils/theme.dart';
import '../../view_models/account_view_model.dart';
import '../../view_models/cart_view_model.dart';
import '../../widgets/app_bar/user_app_bar.dart';
import '../../widgets/other_dialogs/dialog.dart';
import '../bottom_sheet_util.dart';
import 'product_card.dart';
import '../home_screen/home_page.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String? userId;
  @override
  void initState() {
    getUserId().then((value) => userId = value);
    super.initState();
  }

  final ScrollController _scrollControllerOnCategory = ScrollController();
  final ScrollController _scrollControllerOnProduct = ScrollController();
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
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: ThemeColor.primary,
              pinned: true,
              title: ScopedModelDescendant<MenuViewModel>(
                  builder: (context, build, model) {
                return Container(
                  width: Get.width,
                  child: Row(children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () => {showSelectStore()},
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${model.selectedStore!.name}",
                                style: Get.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(children: [
                                Flexible(
                                  child: Text(
                                    model.selectedStore?.address ?? '',
                                    style: Get.textTheme.bodySmall
                                        ?.copyWith(color: Colors.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Icon(
                                  Icons.expand_more,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ]),
                            ]),
                      ),
                    )),
                    InkWell(
                        child: Stack(children: [
                          Icon(
                            CupertinoIcons.bell,
                            size: 25,
                            color: Colors.white,
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.white,
                                    ),
                                  )))
                        ]),
                        onTap: () => {}),
                  ]),
                );
              }),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: Get.height * 0.8,
                        color: Colors.white,
                        child: Scrollbar(
                          controller: _scrollControllerOnCategory,
                          child: ListView(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            controller: _scrollControllerOnCategory,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: [
                              ...Get.find<MenuViewModel>()
                                  .categories!
                                  .asMap()
                                  .entries
                                  .map(
                                    (entry) => buildCircularButton(
                                      entry.value.name ?? '',
                                      entry.value.picUrl ?? '',
                                      entry.value.id ?? '',
                                    ),
                                  )
                                  .toList(),
                                  ...Get.find<MenuViewModel>()
                                  .collections!
                                  .asMap()
                                  .entries
                                  .map(
                                    (entry) => buildCircularButton1(
                                      entry.value.name ?? '',
                                      entry.value.picUrl ?? '',
                                      entry.value.id ?? '',
                                    ),
                                  )
                                  .toList(),
                              // ...Get.find<MenuViewModel>()
                              //     .collections!
                              //     .map((e) => categoryCard(
                              //           e,
                              //           Get.find<MenuViewModel>(),
                              //         ))
                              //     .toList(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        color: Color.fromARGB(255, 255, 255, 255),
                        height: Get.height * 0.8,
                        child: ListView(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            controller: _scrollControllerOnProduct,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              ...Get.find<MenuViewModel>()
                                  .collections!
                                  .map((e) => collectionCard(
                                        e,
                                        Get.find<MenuViewModel>(),
                                      ))
                                  .toList(),
                              ...Get.find<MenuViewModel>()
                                  .categories!
                                  .map((e) => categoryCard(
                                        e,
                                        Get.find<MenuViewModel>(),
                                      ))
                                  .toList(),
                                 
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Đây là cột mới
          ],
        ),
      ),
    );
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

  Widget categoryCard(Category collection, MenuViewModel model) {
    List<Product>? products = model.getNormalProductsByCategory(collection.id);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            Get.toNamed(
                "${RouteHandler.CATEGORY_DETAIL}?id=${collection.id}");
          },
          child: Text(
            collection.name ?? '',
            style:
                Get.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
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
    return Container(
      width: 72,
      height: 72,
      margin: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              height: 50,
              width: 50,
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

    Widget buildCircularButton1(
    String text1,
    String image,
    String collectionId, // Thêm tham số categoryId
  ) {
    return Container(
      width: 72,
      height: 72,
      margin: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              // Xử lý khi nhấn vào hình tròn ở đây
              Get.toNamed(
                "${RouteHandler.COLLECTION_DETAIL}?id=$collectionId",
              );
            },
            child: Container(
              height: 50,
              width: 50,
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

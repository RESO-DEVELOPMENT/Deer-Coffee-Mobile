import 'package:deer_coffee/models/category.dart';
import 'package:deer_coffee/models/collection.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/product.dart';
import '../../utils/route_constrant.dart';
import '../../utils/share_pref.dart';
import '../../utils/theme.dart';
import '../../view_models/cart_view_model.dart';
import '../../widgets/other_dialogs/dialog.dart';
import '../bottom_sheet_util.dart';
import 'product_card.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String? userId;
  int selectedIndex = 0;
  late MenuViewModel menuViewModel;
  final List<GlobalKey> _keys = List.generate(
      Get.find<MenuViewModel>().categories?.length ?? 0,
      (index) => GlobalKey());

  final ScrollController _scrollControllerOnProduct = ScrollController();
  final ScrollController _scrollControllerOnCategory = ScrollController();

  @override
  void initState() {
    getUserId().then((value) => userId = value);
    menuViewModel = Get.find<MenuViewModel>();
    super.initState();
    _scrollControllerOnProduct.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollControllerOnProduct.removeListener(_scrollListener);
    _scrollControllerOnProduct.dispose();

    super.dispose();
  }

  void _scrollListener() {
    for (int i = 0; i < _keys.length; i++) {
      final keyContext = _keys[i].currentContext;
      if (keyContext != null) {
        final box = keyContext.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);
        if (position.dy >= 0 && position.dy <= Get.size.height) {
          setState(() {
            selectedIndex = i;
          });
          break;
        }
      }
    }
  }

  void scrollToWidget(int index) {
    setState(() {
      selectedIndex = index;
    });
    final context = _keys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          // alignment: 0.2,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: menuViewModel,
      child: Scaffold(
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
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ));
          }),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: ScopedModelDescendant<MenuViewModel>(
              builder: (context, build, model) {
            return Row(children: [
              Icon(
                Icons.location_on,
                color: ThemeColor.primary,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  child: InkWell(
                onTap: () => {showSelectStore()},
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${model.selectedStore!.name}",
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(color: ThemeColor.primary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(children: [
                        Flexible(
                          child: Text(
                            model.selectedStore?.address ?? '',
                            style: Get.textTheme.bodySmall
                                ?.copyWith(color: ThemeColor.primary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.expand_more,
                          color: ThemeColor.primary,
                          size: 18,
                        ),
                      ]),
                    ]),
              )),
              InkWell(
                  child: Stack(children: [
                    Icon(
                      CupertinoIcons.bell,
                      size: 25,
                      color: ThemeColor.primary,
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
                                color: ThemeColor.primary,
                              ),
                            )))
                  ]),
                  onTap: () => {}),
            ]);
          }),
        ),
        body: ScopedModelDescendant<MenuViewModel>(
          builder: (context, build, model) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.grey[200],
                          height: Get.height * 0.8,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(
                              parent: NeverScrollableScrollPhysics(),
                            ),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            controller:
                                _scrollControllerOnCategory, // Sử dụng _scrollControllerOnCategory cho ListView này
                            itemCount: model.categories?.length,
                            itemBuilder: (context, index) {
                              return buildCircularButton(
                                index,
                                model.categories![index].name ?? '',
                                model.categories![index].picUrl ?? '',
                                model.categories![index].id ?? '',
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: Get.height * 0.8,
                          color: Colors.white,
                          padding: const EdgeInsets.all(4),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            itemCount: model.categories?.length,
                            controller:
                                _scrollControllerOnProduct, // Sử dụng _scrollControllerOnProduct cho ListView này
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return categoryCard(
                                model.categories![index],
                                index,
                                model,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget collectionCard(Collection collection, MenuViewModel model) {
    List<Product> products = model.getProductsByCollection(collection.id);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            collection.name ?? '',
            style:
                Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 4,
          ),
          Column(
            children: products.map((e) => ProductCard(product: e)).toList(),
          )
        ],
      ),
    );
  }

  Widget categoryCard(Category collection, int idx, MenuViewModel model) {
    List<Product>? products = model.getNormalProductsByCategory(collection.id);
    return Column(
      key: _keys[idx],
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            collection.name ?? '',
            style: idx == selectedIndex
                ? Get.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: idx == selectedIndex ? Colors.blue : null,
                  )
                : Get.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
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
    int idx,
    String text1,
    String image,
    String categoryId,
  ) {
    return InkWell(
      onTap: () {
        scrollToWidget(idx);
      },
      child: Container(
        color: idx == selectedIndex ? Colors.white : Colors.transparent,
        width: 70,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: idx == 0 ? 0 : 10,
              decoration: BoxDecoration(
                color: idx == 0 ? Colors.transparent : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            Container(
              height: 4,
              color: Colors.white,
              child: SizedBox(),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage(image.isEmpty
                          ? 'https://i.imgur.com/X0WTML2.jpg'
                          : image))),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              text1,
              style: Get.textTheme.labelMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}

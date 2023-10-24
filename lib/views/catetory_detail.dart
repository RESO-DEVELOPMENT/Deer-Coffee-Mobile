import 'package:deer_coffee/models/collection.dart';
import 'package:deer_coffee/models/product.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/utils/route_constrant.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({Key? key}) : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  final MenuViewModel menuViewModel = Get.find<MenuViewModel>();
  List<Product>? normalProducts;
  String? categoryId;
 @override
  void initState() {
    super.initState();
    normalProducts = menuViewModel.normalProducts;
    categoryId = '4e2e32a5-4b0d-44af-a91a-5d0494c15ca3';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Category Page')),
      ),
     
      body: ScopedModel<MenuViewModel>(
        model: Get.find<MenuViewModel>(),
        child: CustomScrollView(
          slivers: [
            SliverList.list(
              children: [
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
          ],
        ),
      ),
    );
  }
Widget collectionCard(Collection collection, MenuViewModel model) {
   List<Product> products = model.getNormalProductsByCategory(categoryId);
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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
            .spaceBetween, 
        children: [
          SizedBox(
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
                  .start,
              children: [
                Text(product.name ?? "", style: Get.textTheme.titleSmall),
                SizedBox(
                    height:
                        10), 
                Text(formatPrice(product.sellingPrice ?? 0),
                    style: Get.textTheme.titleMedium),
              ],
            ),
          ),
         
          IconButton.filled(
            icon: const Icon(
              Icons.add,
              size: 32,
            ),
            onPressed: () {
              Get.toNamed("${RouteHandler.PRODUCT_DETAIL}?id=${product.id}");
            },
          ),
        ],
      ),
    );
  }

  Widget buildCircularButton(
    String image,
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
             
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(image: NetworkImage(image))),
            ),
          ),
        ],
      ),
    );
  }
List<Product> getNormalProductsByCategory(String? categoryId) {
    return normalProducts!
        .where((element) => element.categoryId == categoryId)
        .toList();
  }
}

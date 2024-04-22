import 'dart:ui';

import 'package:deer_coffee/models/product_attribute.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:deer_coffee/view_models/product_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../enums/product_enum.dart';
import '../../models/category.dart';
import '../../models/product.dart';
import '../../utils/format.dart';

class ProductDetail extends StatefulWidget {
  final String id;

  const ProductDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

final _scrollController = ScrollController();

class _ProductDetailState extends State<ProductDetail> {
  late Product product;
  String currentVariant = '';
  TextEditingController noteController = TextEditingController();
  MenuViewModel menuViewModel = Get.find<MenuViewModel>();
  ProductViewModel productViewModel = ProductViewModel();
  List<Product> childProducts = [];
  List<Category> extraCategory = [];
  String? selectedSize;
  List<Attribute> listVariants = [];
  List<Variant> selectedAttributes = [];

  @override
  void initState() {
    product = Get.find<MenuViewModel>().getProductById(widget.id);
    productViewModel.addProductToCartItem(product);
    extraCategory = menuViewModel.getExtraCategoryByNormalProduct(product)!;

    if (product.type == ProductTypeEnum.PARENT) {
      childProducts = menuViewModel.getChildProductByParentProduct(product.id)!;
      if (childProducts.isNotEmpty) {
        selectedSize = childProducts[0].id;
      }
      productViewModel.addProductToCartItem(childProducts[0]);
    }

    for (var attribute in product.variants!) {
      List<String> values = attribute.value!.split("_");
      listVariants.add(Attribute(
        attribute.name.toString(),
        values,
      ));
      selectedAttributes.add(Variant(name: attribute.name, value: ""));
    }
    super.initState();
  }

  setSelectedRadio(String val) {
    setState(() {
      selectedSize = val;
    });
  }

  setAttributes(int idx, String val) {
    setState(() {
      selectedAttributes[idx].value = val;
    });
  }

  removeAttributes(int idx) {
    setState(() {
      selectedAttributes[idx].value = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
              expandedHeight: 300.0,
              backgroundColor: Colors.white,
              pinned: true,
              elevation: 0.0,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
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
                      : product.picUrl ?? '',
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                ),
                stretchModes: const [
                  StretchMode.blurBackground,
                  StretchMode.zoomBackground,
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: Container(
                  height: 32.0,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40.0,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              leadingWidth: 80.0,
              leading: Container(
                margin: const EdgeInsets.only(left: 24.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      height: 56,
                      width: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.50),
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          child:
                              Image.asset('assets/images/arrow-back-ios.png'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: ScopedModel<ProductViewModel>(
          model: productViewModel,
          child: ScopedModelDescendant<ProductViewModel>(
              builder: (context, child, model) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name ?? '',
                              style: Get.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: ThemeColor.primary,
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      model.decreaseQuantity();
                                    },
                                    icon: Icon(
                                      CupertinoIcons.minus,
                                      color: ThemeColor.primary,
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    model.productInCart.quantity.toString(),
                                    style: Get.textTheme.bodyMedium,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      model.increaseQuantity();
                                    },
                                    icon: Icon(
                                      CupertinoIcons.plus,
                                      color: ThemeColor.primary,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        productSize(model),
                        productAttributes(model),
                        addExtra(model),
                        buildNote(model)
                      ],
                    ),
                  ),
                ),
                buildButton(model)
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget productAttributes(ProductViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (int i = 0; i < listVariants.length; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(listVariants[i].name,
                  style: Get.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: listVariants[i]
                    .options
                    .toList()
                    .map((option) => TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              option == selectedAttributes[i].value
                                  ? ThemeColor.primary
                                  : Colors.transparent),
                        ),
                        onPressed: () {
                          setAttributes(i, option);
                          model.setAttributes(selectedAttributes[i]);
                        },
                        child: Text(
                          option,
                          style: Get.textTheme.labelSmall?.copyWith(
                              color: option == selectedAttributes[i].value
                                  ? Colors.white
                                  : Colors.black),
                        )))
                    .toList(),
              ),
            ],
          ),
      ],
    );
  }

  Widget addExtra(ProductViewModel model) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: extraCategory.map((e) {
          List<Product> extraProduct =
              menuViewModel.getProductsByCategory(e.id);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(e.name!,
                  style: Get.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: extraProduct.length,
                physics: const ScrollPhysics(),
                itemBuilder: (context, i) {
                  return CheckboxListTile(
                    activeColor: ThemeColor.primary,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.maximumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(extraProduct[i].name!),
                        Text("+ ${formatPrice(extraProduct[i].sellingPrice!)}",
                            style: Get.textTheme.labelSmall),
                      ],
                    ),
                    value: model.isExtraExist(
                      extraProduct[i].menuProductId ?? "",
                    ),
                    selected:
                        model.isExtraExist(extraProduct[i].menuProductId ?? ""),
                    onChanged: (value) {
                      model.addOrRemoveExtra(extraProduct[i]);
                    },
                  );
                },
              ),
            ],
          );
        }).toList());
  }

  Widget productSize(ProductViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Kích cỡ",
            style:
                Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
        ListView.builder(
          shrinkWrap: true,
          itemCount: childProducts.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            return RadioListTile(
              activeColor: ThemeColor.primary,
              dense: true,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.maximumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Size ${childProducts[i].size!}",
                      style: Get.textTheme.labelSmall),
                  Text(formatPrice(childProducts[i].sellingPrice!),
                      style: Get.textTheme.labelSmall),
                ],
              ),
              value: childProducts[i].id,
              groupValue: selectedSize,
              selected: selectedSize == childProducts[i].id,
              onChanged: (value) {
                model.addProductToCartItem(childProducts[i]);
                setSelectedRadio(value!);
              },
            );
          },
        ),
      ],
    );
  }

  Widget buildButton(ProductViewModel model) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: ThemeColor.primary,
          ),
          onPressed: () {
            model.addProductToCart();
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
            child: Text(
                "Thêm ${formatPrice(model.productInCart.finalAmount ?? 0)}",
                style: Get.textTheme.bodyMedium
                    ?.copyWith(color: Get.theme.colorScheme.background)),
          )),
    );
  }

  Widget buildNote(ProductViewModel model) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Ghi chú', // Đây là tiêu đề yêu cầu khác
              style: Get.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: Get.width * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F5F7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: Get.textTheme.labelSmall,
                          controller: noteController,
                          decoration: const InputDecoration(
                            hintText: 'Hãy nói gì đó...',
                            border: InputBorder.none, // Bỏ gạch dưới chân
                          ),
                          onChanged: (value) {
                            model.setNotes(value);
                          },
                        ),
                      ),
                      SizedBox(
                          width: 4), // Tạo khoảng cách giữa văn bản và icon
                      Icon(Icons.edit, // Icon cây viết
                          color: ThemeColor.primary // Màu của icon
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

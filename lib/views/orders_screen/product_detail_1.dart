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
  List<bool> isSelectedAttributes = [];
  bool isIconVisible = false;

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
      selectedAttributes
          .add(Variant(name: attribute.name, value: attribute.value));
    }
    isSelectedAttributes = List.filled(selectedAttributes.length, false);
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
            expandedHeight: 300.0,
            backgroundColor: Colors.grey[100],
            pinned: true,
            elevation: 0.0,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
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
              preferredSize: const Size.fromHeight(20.0),
              child: Container(
                height: 32.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                ),
                child: Container(
                  height: 4.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
            ),
            leadingWidth: 60.0,
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
                        child: Image.asset('assets/images/arrow-back-ios.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          productDetail(productViewModel),
        ],
      ),
      floatingActionButton: buildButton(productViewModel),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget productDetail(ProductViewModel model) {
    return ScopedModel<ProductViewModel>(
      model: productViewModel,
      child: ScopedModelDescendant<ProductViewModel>(
        builder: (context, child, model) {
          return SliverToBoxAdapter(
            child: Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0),
                    child: Row(
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
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: productSize(model),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                    ),
                  ),
                  Container(
                    child: productAttributes(model),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  addExtra(model),
                  Container(
                    child: buildNote(model),
                    margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget productAttributes(ProductViewModel model) {
    return Column(
      children: [
        for (int i = 0; i < listVariants.length; i++)
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          listVariants[i].name,
                          style: Get.textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: List.generate(
                        listVariants[i].options.length,
                        (index) {
                          final option = listVariants[i].options[index];
                          return GestureDetector(
                            onTap: () {
                              model.setNotes(option);
                              setAttributes(i, option);
                              model.setAttributes(selectedAttributes[i]);
                              setState(() {
                                isSelectedAttributes[i] = true;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              decoration:
                                  index != (listVariants[i].options.length - 1)
                                      ? BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey.shade300,
                                              width: 1.0,
                                            ),
                                          ),
                                        )
                                      : null,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    option,
                                    style: Get.textTheme.labelSmall?.copyWith(
                                      color:
                                          option == selectedAttributes[i].value
                                              ? Colors.black
                                              : Colors.grey[900],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  option == selectedAttributes[i].value
                                      ? Icon(
                                          size: 20,
                                          Icons.check_circle,
                                          color: ThemeColor.primary,
                                        )
                                      : const Icon(
                                          size: 20,
                                          Icons.circle_outlined,
                                          color: Colors.grey,
                                        ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 18, child: Container(color: Colors.grey[100])),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Kích cỡ",
                style: Get.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: List.generate(
              childProducts.length,
              (index) {
                bool isSelected = selectedSize == childProducts[index].id;
                return GestureDetector(
                  onTap: () {
                    model.addProductToCartItem(childProducts[index]);
                    setSelectedRadio(childProducts[index].id != null
                        ? childProducts[index].id!
                        : childProducts[index].id!);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    decoration: index != (childProducts.length - 1)
                        ? BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
                          )
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Size ${childProducts[index].size!}",
                            style: Get.textTheme.labelSmall),
                        Row(
                          children: [
                            Text(
                              formatPrice(childProducts[index].sellingPrice!),
                              style: Get.textTheme.labelSmall,
                            ),
                            SizedBox(width: 8),
                            isSelected == true
                                ? Icon(
                                    size: 20,
                                    Icons.check_circle,
                                    color: ThemeColor.primary,
                                  )
                                : const Icon(
                                    size: 20,
                                    Icons.circle_outlined,
                                    color: Colors.grey,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildButton(ProductViewModel model) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
            padding: const EdgeInsets.all(12),
            child: Text(
                "Thêm ${formatPrice(model.productInCart.finalAmount ?? 0)}",
                style: Get.textTheme.bodyLarge
                    ?.copyWith(color: Get.theme.colorScheme.surface)),
          )),
    );
  }

  Widget buildNote(ProductViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Ghi chú',
                style: Get.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: Get.width * 0.85,
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
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              model.setNotes(value);
                            },
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.edit, color: ThemeColor.primary),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

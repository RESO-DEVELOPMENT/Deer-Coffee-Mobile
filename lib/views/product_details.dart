import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:deer_coffee/view_models/product_view_model.dart';
import 'package:deer_coffee/views/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../enums/product_enum.dart';
import '../models/cart.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../models/product_attribute.dart';
import '../utils/format.dart';

class Option extends StatefulWidget {
  final String id;

  const Option({Key? key, required this.id}) : super(key: key);

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  late Product product;
  MenuViewModel menuViewModel = Get.find<MenuViewModel>();
  ProductViewModel productViewModel = ProductViewModel();
  List<Product> childProducts = [];
  List<Category> extraCategory = [];
  String? selectedSize;
  List<Attribute> listAttribute = [];
  List<ProductAttribute> selectedAttributes = [];
  @override
  void initState() {
    // TODO: implement initState
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
    listAttribute = productViewModel.listAttribute;
    selectedAttributes = productViewModel.currentAttributes;
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
      appBar: AppBar(
        title:
            Text(product.name ?? 'Sản phẩm', style: Get.textTheme.titleMedium),
      ),
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
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            product.picUrl!.isEmpty
                                ? 'https://i.imgur.com/X0WTML2.jpg'
                                : product.picUrl ?? '',
                            width: Get.width,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name ?? '',
                            style: Get.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    model.decreaseQuantity();
                                  },
                                  child: Icon(CupertinoIcons.minus),
                                ),
                                Text(model.quantity.toString()),
                                GestureDetector(
                                  onTap: () {
                                    model.increaseQuantity();
                                  },
                                  child: Icon(CupertinoIcons.plus),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      productSize(model),
                      buildAttribute(listAttribute, model),
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
    );
  }

  Widget buildAttribute(List<Attribute> attributes, ProductViewModel model) {
    return Column(
        children: attributes
            .map(
              (e) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.name,
                      style: Get.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: e.options
                        .map((option) => Padding(
                              padding: const EdgeInsets.all(4),
                              child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<
                                        Color>(option ==
                                            selectedAttributes[e.id].value
                                        ? Get.theme.colorScheme.primaryContainer
                                        : Colors.transparent),
                                  ),
                                  onPressed: () {
                                    setAttributes(e.id, option);
                                    model.setAttributes(
                                        selectedAttributes[e.id]);
                                  },
                                  child: Text(
                                    option,
                                    style: Get.textTheme.bodySmall,
                                  )),
                            ))
                        .toList(),
                  ),
                  Divider()
                ],
              ),
            )
            .toList());
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
                  style: Get.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: extraProduct.length,
                physics: const ScrollPhysics(),
                itemBuilder: (context, i) {
                  return CheckboxListTile(
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.maximumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(extraProduct[i].name!),
                        Text("+ ${formatPrice(extraProduct[i].sellingPrice!)}"),
                      ],
                    ),
                    value: model.isExtraExist(extraProduct[i].id ?? ""),
                    selected: model.isExtraExist(extraProduct[i].id ?? ""),
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
            style: Get.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        ListView.builder(
          shrinkWrap: true,
          itemCount: childProducts.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            return RadioListTile(
              dense: true,
              visualDensity: VisualDensity(
                horizontal: VisualDensity.maximumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Size ${childProducts[i].size!}"),
                  Text(formatPrice(childProducts[i].sellingPrice!)),
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
      child: FilledButton(
          onPressed: () {
            model.addProductToCart();
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
            child: Text("Thêm ${formatPrice(model.totalAmount!)}",
                style: Get.textTheme.titleMedium
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
              'Yêu cầu khác', // Đây là tiêu đề yêu cầu khác
              style: Get.textTheme.bodyMedium
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
              Text('Ghi chú', style: Get.textTheme.bodyMedium),
              Container(
                height: 50,
                width: Get.width * 0.7,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F5F7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Hãy nói gì đó...',
                            border: InputBorder.none, // Bỏ gạch dưới chân
                          ),
                          onChanged: (value) {
                            model.setNotes(value);
                          },
                        ),
                      ),
                      SizedBox(
                          width: 10), // Tạo khoảng cách giữa văn bản và icon
                      Icon(
                        Icons.edit, // Icon cây viết
                        color: Colors.grey, // Màu của icon
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

import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/cart_model.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:deer_coffee/view_models/product_view_model.dart';
import 'package:deer_coffee/views/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../enums/product_enum.dart';
import '../../models/category.dart';
import '../../models/product.dart';
import '../../models/product_attribute.dart';
import '../../utils/format.dart';

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
  List<Attributes> selectedAttributes = [];
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
    selectedAttributes = productViewModel.productInCart.attributes!;
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
        centerTitle: true,
        title: Text(
          'Tuỳ chọn',
          style:
              Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          product.picUrl!.isEmpty
                              ? 'https://i.imgur.com/X0WTML2.jpg'
                              : product.picUrl ?? '',
                          width: Get.width,
                          height: 240,
                          fit: BoxFit.cover,
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
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: ThemeColor.primary,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    model.decreaseQuantity();
                                  },
                                  child: Icon(
                                    CupertinoIcons.minus,
                                    color: ThemeColor.primary,
                                  ),
                                ),
                                Text(model.productInCart.quantity.toString()),
                                GestureDetector(
                                  onTap: () {
                                    model.increaseQuantity();
                                  },
                                  child: Icon(
                                    CupertinoIcons.plus,
                                    color: ThemeColor.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
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
    );
  }

  // Widget buildAttribute(List<Attribute> attributes, ProductViewModel model) {
  //   return Column(
  //       children: attributes
  //           .map(
  //             (e) => Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(e.name,
  //                     style: Get.textTheme.bodyMedium
  //                         ?.copyWith(fontWeight: FontWeight.bold)),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: e.options
  //                       .map((option) => TextButton(
  //                           style: ButtonStyle(
  //                             backgroundColor: MaterialStateProperty.all<Color>(
  //                                 option == selectedAttributes[i].value
  //                                     ? Get.theme.colorScheme.primaryContainer
  //                                     : Colors.transparent),
  //                           ),
  //                           onPressed: () {
  //                             setAttributes(e.id, option);
  //                             model.setAttributes(selectedAttributes[e.id]);
  //                           },
  //                           child: Text(
  //                             option,
  //                             style: Get.textTheme.bodySmall,
  //                           )))
  //                       .toList(),
  //                 ),
  //                 Divider()
  //               ],
  //             ),
  //           )
  //           .toList());
  // }

  Widget productAttributes(ProductViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (int i = 0; i < listAttribute.length; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(listAttribute[i].name,
                  style: Get.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: listAttribute[i]
                    .options
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
                          style: Get.textTheme.bodySmall?.copyWith(
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
                  style: Get.textTheme.bodyMedium
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
                        Text("+ ${formatPrice(extraProduct[i].sellingPrice!)}"),
                      ],
                    ),
                    value:
                        model.isExtraExist(extraProduct[i].menuProductId ?? ""),
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
            style: Get.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        ListView.builder(
          shrinkWrap: true,
          itemCount: childProducts.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            return RadioListTile(
              activeColor: ThemeColor.primary,
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
              'Ghi chú', // Đây là tiêu đề yêu cầu khác
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

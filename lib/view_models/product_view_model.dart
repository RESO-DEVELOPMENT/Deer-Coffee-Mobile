import 'package:deer_coffee/models/cart_model.dart';
import 'package:get/get.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../models/product_attribute.dart';
import 'base_view_model.dart';
import 'cart_view_model.dart';
import 'menu_view_model.dart';

class ProductViewModel extends BaseViewModel {
  ProductList productInCart = ProductList();
  List<Attribute> listAttribute = Get.find<CartViewModel>().listAttribute;
  List<Category>? listCategory = Get.find<MenuViewModel>().categories;

  void addProductToCartItem(Product product) {
    productInCart = ProductList(
      productInMenuId: product.menuProductId,
      parentProductId: product.parentProductId,
      name: product.name,
      type: product.type,
      quantity: 1,
      code: product.code,
      picUrl: product.picUrl,
      categoryCode: listCategory!
          .firstWhereOrNull((element) => element.id == product.categoryId)
          ?.code,
      sellingPrice: product.sellingPrice,
      totalAmount: product.sellingPrice,
      finalAmount: product.sellingPrice,
      discount: 0,
      extras: [],
      attributes: [],
    );
    countAmount();
    notifyListeners();
  }

  void addProductToCart() {
    Get.find<CartViewModel>().addToCart(productInCart);
    Get.back();
  }

  void setAttributes(Variant variant) {
    bool isExist = false;
    for (var element in productInCart.attributes!) {
      if (element.name == variant.name) {
        element.value = variant.value;
        isExist = true;
      }
    }
    if (isExist == false) {
      productInCart.attributes!.add(variant);
    }
    notifyListeners();
  }

  void increaseQuantity() {
    productInCart.quantity = (productInCart.quantity! + 1);
    countAmount();
    notifyListeners();
  }

  void decreaseQuantity() {
    if (productInCart.quantity == 1) {
      return;
    } else {
      productInCart.quantity = (productInCart.quantity! - 1);
      countAmount();
      notifyListeners();
    }
  }

  void addOrRemoveExtra(Product extra) {
    if (isExtraExist(extra.menuProductId!)) {
      productInCart.extras?.removeWhere(
          (element) => element.productInMenuId == extra.menuProductId);
      countAmount();
    } else {
      productInCart.extras?.add(Extras(
          productInMenuId: extra.menuProductId,
          name: extra.name,
          quantity: 1,
          totalAmount: extra.sellingPrice,
          sellingPrice: extra.sellingPrice));
      countAmount();
    }
    notifyListeners();
  }

  countAmount() {
    productInCart.totalAmount =
        productInCart.sellingPrice! * productInCart.quantity!;
    addExtraAmount();
    productInCart.finalAmount =
        productInCart.totalAmount! - productInCart.discount!;
  }

  addExtraAmount() {
    for (int index = 0; index < productInCart.extras!.length; index++) {
      productInCart.totalAmount = productInCart!.totalAmount! +
          productInCart.extras![index].sellingPrice!;
    }
    notifyListeners();
  }

  void setNotes(String note) {
    if (productInCart.attributes != null) {
      String attributeValues = '';
      for (int i = 0; i < productInCart.attributes!.length; i++) {
        if (productInCart.attributes![i].value != null) {
          attributeValues += '${productInCart.attributes![i].value!}, ';
        }
      }
      productInCart.note = '$attributeValues$note';
    } else {
      productInCart.note = note;
    }
    notifyListeners();
  }

  bool isExtraExist(String id) {
    for (int index = 0; index < productInCart.extras!.length; index++) {
      if (productInCart.extras![index].productInMenuId == id) {
        return true;
      }
    }
    return false;
  }

  void getCartItemToUpdate(ProductList cartItem) {
    // countAmount();
    productInCart = cartItem;
    notifyListeners();
  }

  void updateCartItemInCart(int idx) {
    ProductList cartItem = productInCart;
    Get.find<CartViewModel>().updateCart(cartItem, idx);
    Get.back();
  }

  void deleteCartItemInCart(int idx) {
    Get.find<CartViewModel>().removeFromCart(idx);
    Get.back();
  }
}

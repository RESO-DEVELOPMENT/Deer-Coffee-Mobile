import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../models/product_attribute.dart';
import 'base_view_model.dart';
import 'cart_view_model.dart';

class ProductViewModel extends BaseViewModel {
  num? totalAmount;
  Product? productInCart;
  int quantity = 1;
  List<Product> extras = [];
  String? notes;
  List<ProductAttribute> currentAttributes = [];
  List<Attribute> listAttribute = [];
  ProductViewModel() {
    listAttribute = [
      Attribute(0, "Mức đường", ["0%", "30%", "50%", "70%", "100%"], "100%"),
      Attribute(1, "Mức đá", ["0%", "30%", "50%", "70%", "100%"], "100%")
    ];
    for (var attribute in listAttribute) {
      currentAttributes
          .add(ProductAttribute(attribute.name, attribute.options.last));
    }
  }
  void addProductToCartItem(Product product) {
    productInCart = product;
    countAmount();
    notifyListeners();
  }

  void addProductToCart() {
    CartItem cartItem = CartItem(
      productInCart!,
      quantity,
      totalAmount!,
      note: notes,
      extras: extras,
      attributes: currentAttributes,
    );
    Get.find<CartViewModel>().addToCart(cartItem);
    Get.back();
  }

  void setAttributes(ProductAttribute attribute) {
    currentAttributes
        .firstWhere((element) => element.name == attribute.name)
        .value = attribute.value;
    notifyListeners();
  }

  void increaseQuantity() {
    quantity += 1;
    countAmount();
    notifyListeners();
  }

  void decreaseQuantity() {
    if (quantity == 0) {
      return;
    }
    quantity -= 1;
    countAmount();
    notifyListeners();
  }

  void addOrRemoveExtra(Product extra) {
    if (isExtraExist(extra.id!)) {
      extras.removeWhere((element) => element.id == extra.id);
      countAmount();
    } else {
      extras.add(extra);
      countAmount();
    }
    notifyListeners();
  }

  countAmount() {
    totalAmount = productInCart!.sellingPrice! * quantity;
    addExtraAmount();
  }

  addExtraAmount() {
    for (int index = 0; index < extras.length; index++) {
      totalAmount = totalAmount! + extras[index].sellingPrice!;
    }
    notifyListeners();
  }

  void setNotes(String note) {
    notes = note;
    notifyListeners();
  }

  bool isExtraExist(String id) {
    for (int index = 0; index < extras.length; index++) {
      if (extras[index].id == id) {
        return true;
      }
    }
    return false;
  }

  void getCartItemToUpdate(CartItem cartItem) {
    notes = cartItem.note;
    productInCart = cartItem.product;
    quantity = cartItem.quantity;
    extras = cartItem.extras!;
    // notes = cartItem.note;
    totalAmount = cartItem.totalAmount;
    currentAttributes = cartItem.attributes!;
    // countAmount();
    notifyListeners();
  }

  void updateCartItemInCart(int idx) {
    CartItem cartItem = CartItem(
      productInCart!,
      quantity,
      totalAmount!,
      note: notes,
      extras: extras,
      attributes: currentAttributes,
    );
    Get.find<CartViewModel>().updateCart(cartItem, idx);
    Get.back();
  }

  void deleteCartItemInCart(int idx) {
    Get.find<CartViewModel>().removeFromCart(idx);
    Get.back();
  }
}

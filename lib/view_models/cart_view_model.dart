import 'package:deer_coffee/models/pointify/promotion_details_model.dart';
import 'package:deer_coffee/models/store.dart';
import 'package:deer_coffee/models/user.dart';
import 'package:deer_coffee/utils/share_pref.dart';
import 'package:deer_coffee/widgets/other_dialogs/dialog.dart';
import 'package:get/get.dart';

import '../api/order_api.dart';
import '../api/pointify/pointify_data.dart';
import '../enums/order_enum.dart';
import '../enums/view_status.dart';
import '../models/cart_model.dart';
import '../models/payment_provider.dart';
import '../models/pointify/promotion_model.dart';
import '../models/product_attribute.dart';
import 'base_view_model.dart';
import 'order_view_model.dart';

class CartViewModel extends BaseViewModel {
  CartModel cart = CartModel();
  int? peopleNumber;
  List<Attribute> listAttribute = [
    Attribute("Đường", ["0%", "30%", "50%", "70%", "100%"]),
    Attribute("Đá", ["0%", "30%", "50%", "70%", "100%"])
  ];
  late OrderAPI orderAPI = OrderAPI();
  PointifyData? promotionData = PointifyData();
  List<PromotionPointify>? promotions = [];
  StoreModel? selectedStore;
  String? deliAddress;
  CartViewModel() {
    cart.orderType = OrderTypeEnum.EAT_IN;
    cart.productList = [];
    cart.promotionList = [];
    cart.paymentType = PaymentTypeEnums.CASH;
    cart.totalAmount = 0;
    cart.finalAmount = 0;
    cart.bonusPoint = 0;
    cart.shippingFee = 0;
  }

  void getListPromotion() async {
    try {
      setState(ViewStatus.Loading);
      promotions = await promotionData?.getListPromotionOfPointify();
      promotions?.removeWhere((element) => element.promotionType == 1);
      setState(ViewStatus.Completed);
    } catch (e) {
      setState(ViewStatus.Error, e.toString());
    }
  }

  Future<PromotionDetailsModel?> getPromotionDetailsById(String id) async {
    try {
      setState(ViewStatus.Loading);
      PromotionDetailsModel? promotionDetailsModel =
          await promotionData?.getPromotionDetailsById(id);
      setState(ViewStatus.Completed);
      return promotionDetailsModel;
    } catch (e) {
      setState(ViewStatus.Error, e.toString());
    }
    return null;
  }

  void addToCart(ProductList cartModel) {
    cart.productList!.add(cartModel);
    countCartAmount();
    countCartQuantity();
    notifyListeners();
  }

  void updateCart(ProductList cartModel, int cartIndex) {
    cart.productList![cartIndex] = cartModel;
    countCartAmount();
    countCartQuantity();
    notifyListeners();
  }

  void countCartAmount() {
    cart.totalAmount = 0;
    cart.discountAmount = 0;
    for (ProductList item in cart.productList!) {
      cart.totalAmount = cart.totalAmount! + item.totalAmount!;
    }
    cart.finalAmount = cart.totalAmount! - cart.discountAmount!;
    notifyListeners();
  }

  countCartQuantity() {
    num quantity = 0;
    for (ProductList item in cart.productList!) {
      quantity = quantity + item.quantity!;
    }
    return quantity;
  }

  void removeFromCart(int idx) {
    cart.productList!.remove(cart.productList![idx]);
    countCartAmount();
    notifyListeners();
  }

  bool isPromotionApplied(String code) {
    return cart.promotionCode == code;
  }

  void clearCartData() {
    cart.productList = [];
    cart.finalAmount = 0;
    cart.totalAmount = 0;
    cart.discountAmount = 0;
    cart.promotionList = [];
    cart.promotionCode = null;
    cart.voucherCode = null;
    notifyListeners();
  }

  bool isPromotionExist(String code) {
    return cart.promotionCode == code;
  }

  Future<void> removePromotion() async {
    cart.promotionCode = null;
    await prepareOrder();
    notifyListeners();
  }

  Future<void> selectPromotion(String code) async {
    cart.promotionCode = code;
    await prepareOrder();
    notifyListeners();
  }

  List<PaymentProvider?> getListPayment() {
    List<PaymentProvider?> listPayment = [];
    listPayment = Get.find<OrderViewModel>().listPayment;
    return listPayment;
  }

  Future<bool> prepareOrder() async {
    UserModel? userInfo = await getUserInfo();
    cart.paymentType = PaymentTypeEnums.CASH;
    cart.storeId = selectedStore?.id ?? '';
    cart.customerId = userInfo?.userInfo?.id;
    cart.discountAmount = 0;
    cart.finalAmount = cart.totalAmount;
    cart.deliveryAddress = deliAddress;
    for (var element in cart.productList!) {
      element.discount = 0;
      element.finalAmount = element.totalAmount;
      element.promotionCodeApplied = null;
    }
    cart.promotionList!.clear();
    await orderAPI.prepareOrder(cart).then((value) => {
          cart = value,
        });
    notifyListeners();
    return true;
  }

  void setAddress(String? address) {
    deliAddress = address;
    notifyListeners();
  }

  void setOrderType(String? type) {
    cart.orderType = type;
    notifyListeners();
  }

  void setStore(StoreModel store) {
    selectedStore = store;
    notifyListeners();
  }

  PromotionPointify? getPromotionById(String id) {
    return promotions?.firstWhere((element) => element.promotionId == id);
  }

  Future<void> createOrder() async {
    bool res = false;
    await Get.find<OrderViewModel>()
        .placeOrder(cart)
        .then((value) => res = value);
    if (res) {
      clearCartData();
    }
  }

  // List<PaymentProvider?> getListPayment() {
  //   List<PaymentProvider?> listPayment = [];
  //   listPayment = Get.find<OrderViewModel>().listPayment;
  //   return listPayment;
  // }

  // void increasePromotionQuantity(String id) {
  //   int idx = promotionApplyList.indexWhere((element) => element.id == id);
  //   if (idx == -1) {
  //     showAlertDialog(
  //       title: "Thông báo",
  //       content: "Khuyến mãi đã bị xoá",
  //     );
  //     return;
  //   }
  //   promotionApplyList[idx].quantity = (promotionApplyList[idx].quantity! + 1);
  //   promotionApplyList[idx].discountInOrder =
  //       (promotionApplyList[idx].discountAmount! *
  //           promotionApplyList[idx].quantity!);
  //   checkAvailablePromotion();
  // }

  // void decreasePromotionQuantity(String id) {
  //   int idx = promotionApplyList.indexWhere((element) => element.id == id);
  //   if (idx == -1) {
  //     showAlertDialog(
  //       title: "Thông báo",
  //       content: "Khuyến mãi đã bị xoá",
  //     );
  //     return;
  //   }
  //   if (promotionApplyList[idx].quantity == 1) {
  //     removePromotion(id);
  //     checkAvailablePromotion();
  //     return;
  //   } else {
  //     promotionApplyList[idx].quantity =
  //         (promotionApplyList[idx].quantity! - 1);
  //     promotionApplyList[idx].discountInOrder =
  //         (promotionApplyList[idx].discountAmount! *
  //             promotionApplyList[idx].quantity!);
  //     checkAvailablePromotion();
  //   }
  // }

  // Promotion? selectedPromotion(String id) {
  //   for (var promotion in promotionApplyList) {
  //     if (promotion.id == id) {
  //       return promotion;
  //     }
  //   }
  //   return null;
  // }
}

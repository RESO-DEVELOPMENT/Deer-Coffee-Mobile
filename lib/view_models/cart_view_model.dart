// ignore_for_file: unnecessary_import

import 'package:deer_coffee/models/pointify/check_promotion_model.dart';
import 'package:deer_coffee/models/pointify/membership_model.dart';
import 'package:deer_coffee/models/pointify/promotion_details_model.dart';
import 'package:deer_coffee/models/store.dart';
import 'package:deer_coffee/models/user.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:deer_coffee/views/store.dart';
import 'package:deer_coffee/widgets/other_dialogs/dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../api/pointify/pointify_data.dart';
import '../enums/order_enum.dart';
import '../enums/view_status.dart';
import '../models/cart.dart';
import '../models/order.dart';
import '../models/pointify/promotion_model.dart';
import 'base_view_model.dart';
import 'order_view_model.dart';

class CartViewModel extends BaseViewModel {
  List<CartItem> _cartList = [];
  List<Effects> promotionApplyList = [];
  num _finalAmount = 0;
  num _totalAmount = 0;
  String? deliveryType;
  String? deliAddress;
  String paymentType = PaymentTypeEnums.CASH;
  num _discountAmount = 0;
  num _productDiscount = 0;
  int _quantity = 0;
  num pointRedeem = 0;
  StoreModel? selectedStore;
  String? selectPromotionCode;
  PointifyData api = PointifyData();
  // PromotionData? promotionData = PromotionData();
  // List<Promotion>? promotions = [];
  PointifyData? promotionData = PointifyData();
  List<PromotionPointify>? promotions = [];
  List<CartItem> get cartList => _cartList;
  num get finalAmount => _finalAmount;
  CheckPromotionModel? selectedPromotionChecked;
  num get totalAmount => _totalAmount;
  num? get discountAmount => _discountAmount;
  int? get quantity => _quantity;
  num? get productDiscount => _productDiscount;

  set setTotalAmount(int value) {
    _totalAmount = value;
  }

  int isExistInCart(
    int productId,
    String? variationType,
    bool isUpdate,
    int? cartIndex,
  ) {
    for (int index = 0; index < _cartList.length; index++) {
      if (_cartList[index].product.id == productId) {
        if ((isUpdate && index == cartIndex)) {
          return -1;
        } else {
          return index;
        }
      }
    }
    return -1;
  }

  // void getListPromotion() async {
  //   try {
  //     setState(ViewStatus.Loading);
  //     promotions = await promotionData?.getListPromotionOfStore();
  //     setState(ViewStatus.Completed);
  //   } catch (e) {
  //     setState(ViewStatus.Error, e.toString());
  //   }
  // }
  void getListPromotion() async {
    try {
      setState(ViewStatus.Loading);
      promotions = await promotionData?.getListPromotionOfPointify();
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

  void addToCart(CartItem cartModel) {
    _cartList.add(cartModel);
    // checkAvailablePromotion();
    countCartAmount();
    countCartQuantity();
    notifyListeners();
  }

  void updateCart(CartItem cartModel, int cartIndex) {
    _cartList[cartIndex] = cartModel;
    // checkAvailablePromotion();
    countCartAmount();
    countCartQuantity();
    notifyListeners();
  }

  void countCartAmount() {
    _totalAmount = 0;
    _productDiscount = 0;
    _discountAmount = 0;
    for (CartItem cart in _cartList) {
      _totalAmount = _totalAmount + cart.totalAmount;
      _productDiscount =
          _productDiscount + cart.product.discountPrice! * cart.quantity;
    }
    // for (Promotion promotion in promotionApplyList) {
    //   _discountAmount += ((promotion.discountInOrder ?? 0));
    // }
    _finalAmount = _totalAmount - _discountAmount - _productDiscount;
    notifyListeners();
  }

  countCartQuantity() {
    _quantity = 0;
    for (CartItem cart in _cartList) {
      _quantity = _quantity + cart.quantity;
    }
    notifyListeners();
  }

  selectPromotion(String? code) {
    selectPromotionCode = code;
    notifyListeners();
  }

  void removeFromCart(int idx) {
    _totalAmount = _totalAmount - (_cartList[idx].totalAmount);
    _cartList.remove(_cartList[idx]);
    // checkAvailablePromotion();
    countCartAmount();
    countCartQuantity();
    notifyListeners();
  }

  // bool isPromotionApplied(String promotionId) {
  //   for (var promotion in promotionApplyList) {
  //     if (promotion.id == promotionId) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  void clearCartData() {
    _cartList = [];
    _finalAmount = 0;
    _totalAmount = 0;
    _discountAmount = 0;
    _productDiscount = 0;
    _quantity = 0;
    selectPromotionCode;

    // promotionApplyList = [];
    notifyListeners();
  }

  Future<void> checkPromotion() async {
    try {
      setState(ViewStatus.Loading);
      MemberShipModel? memberShip =
          Get.find<AccountViewModel>().memberShipModel;
      List<CartItems> cartItems = <CartItems>[];
      for (CartItem cart in _cartList) {
        CartItems product = CartItems(
          productCode: cart.product.code,
          quantity: cart.quantity,
          unitPrice: cart.product.sellingPrice,
          total: cart.totalAmount,
          discountFromOrder: 0,
          subTotal: cart.totalAmount,
          discount: cart.discount,
        );
        cartItems.add(product);
      }
      CustomerOrderInfo checkPromotionModel = CustomerOrderInfo(
          apiKey: "7F77CA43-940B-403D-813A-38B3B3A7B667",
          id: "DC-VH",
          bookingDate: DateTime.now().toIso8601String(),
          attributes: Attributes(
            salesMode: 7,
            paymentMethod: 63,
            storeInfo: StoreInfo(
                storeCode: 'DC-VH', brandCode: "DeerCoffee", applier: "3"),
          ),
          cartItems: cartItems,
          vouchers: [Vouchers(promotionCode: selectPromotionCode)],
          amount: _totalAmount,
          shippingFee: 0,
          users: Users(
              membershipId: memberShip?.membershipId ?? '',
              userGender: memberShip?.gender ?? 3));
      await api
          .checkPromotion(checkPromotionModel)
          .then((value) => selectedPromotionChecked = value);
      if (selectedPromotionChecked != null ||
          selectedPromotionChecked?.order != null) {
        selectedPromotionChecked!.order!.effects
            ?.removeWhere((element) => element.promotionType == null);

        _discountAmount = selectedPromotionChecked!.order!.discount ?? 0;

        if (selectedPromotionChecked?.order?.effects != null) {
          for (var element in selectedPromotionChecked!.order!.effects!) {
            promotionApplyList.add(element);
          }
        }
        print(promotionApplyList.length);
        _productDiscount =
            selectedPromotionChecked!.order!.discountOrderDetail ?? 0;
        _finalAmount = selectedPromotionChecked!.order!.finalAmount ?? 0;
        pointRedeem = selectedPromotionChecked!.order!.bonusPoint ?? 0;
      }

      print(selectedPromotionChecked?.message.toString());
      setState(ViewStatus.Completed);
    } on DioException catch (e) {
      showAlertDialog(
          title: e.response!.data["code"].toString(),
          content: e.response!.data["message"].toString());
      setState(ViewStatus.Error, e.response.toString());
    }
  }

  void setAddress(String? address) {
    deliAddress = address;
    notifyListeners();
  }

  void setPromotion(String promotion) {
    selectPromotionCode = promotion;
    notifyListeners();
  }

  void setStore(StoreModel store) {
    selectedStore = store;
    notifyListeners();
  }

  Future<void> createOrder() async {
    String deliType = Get.find<OrderViewModel>().deliveryType;
    UserModel user = Get.find<AccountViewModel>().user!;
    List<ProductsList> productList = <ProductsList>[];
    List<PromotionList> promotionList = [];
    if (promotionApplyList.isNotEmpty) {
      for (var element in promotionApplyList) {
        promotionList.add(PromotionList(
            promotionId: element.promotionId,
            discountAmount: element.effectType == "GET_POINT"
                ? pointRedeem
                : element.prop?.value ?? 0));
      }
    }
    for (CartItem cart in _cartList) {
      List<Extras> extraList = <Extras>[];
      cart.extras?.forEach((element) {
        Extras extra = Extras(
            productInMenuId: element.menuProductId,
            quantity: 1,
            sellingPrice: element.sellingPrice,
            discount: element.discountPrice! * cart.quantity);
        extraList.add(extra);
      });
      ProductsList product = ProductsList(
        productInMenuId: cart.product.menuProductId,
        quantity: cart.quantity,
        sellingPrice: cart.product.sellingPrice,
        discount: cart.product.discountPrice! * cart.quantity,
        note: cart.attributes == null && cart.note == null
            ? null
            : ("${cart.attributes!.map((e) => '${e.name}:${e.value}').join(" ")} ${cart.note ?? ''}"),
        extras: extraList,
      );
      productList.add(product);
    }
    OrderModel order = OrderModel(
        storeId: selectedStore?.id ?? '',
        userId: user.userInfo?.id ?? '',
        orderType: deliType,
        address: deliAddress,
        paymentType: paymentType,
        productsList: productList,
        status: OrderStatusEnum.PENDING,
        totalAmount: _totalAmount,
        discountAmount: _discountAmount + _productDiscount,
        finalAmount: _finalAmount,
        promotionList: promotionList);
    bool res = false;
    await Get.find<OrderViewModel>()
        .placeOrder(order)
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

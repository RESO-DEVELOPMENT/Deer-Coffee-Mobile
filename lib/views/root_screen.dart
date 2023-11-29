import 'dart:async';

import 'package:deer_coffee/models/user.dart';
import 'package:deer_coffee/utils/route_constrant.dart';
import 'package:deer_coffee/utils/share_pref.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/views/orders_screen/product_details.dart';
import 'package:deer_coffee/views/stores_screen/store.dart';
import 'package:deer_coffee/views/orders_screen/orders_screen.dart';
import 'package:deer_coffee/views/membership_screen/promotions_screen.dart';
import 'package:deer_coffee/widgets/other_dialogs/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';
import '../utils/theme.dart';
import '../view_models/menu_view_model.dart';
import 'home_screen/banner_home.dart';
import 'home_screen/home_page.dart';
import 'order.dart';
import 'profile_screen/profile.dart';
import 'home_page_order_method.dart';
import 'bottom_sheet_util.dart';
import 'home_page_order_method.dart';

class RootScreen extends StatefulWidget {
  final int idx;
  const RootScreen({super.key, required this.idx});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;
  UserModel? userModel;

  List<Widget> portraitViews = [
    HomePage(),
    OrdersScreen(),
    PromotionsScreen(),
    Store(),
    OtherPage(),
  ];

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
    BottomNavigationBarItem(
        icon: Icon(Icons.coffee_outlined), label: 'Đặt hàng'),
    BottomNavigationBarItem(
        icon: Icon(Icons.confirmation_number), label: 'Ưu đãi'),
    BottomNavigationBarItem(
        icon: Icon(Icons.store_outlined), label: 'Cửa hàng'),
    BottomNavigationBarItem(icon: Icon(Icons.segment_sharp), label: 'Khác'),
  ];
  @override
  void initState() {
    _selectedIndex = widget.idx;
    getUserInfo().then((value) => userModel = value);
    Get.find<AccountViewModel>().getMembershipInfo();
    if (Get.find<MenuViewModel>().blogList != null &&
        (Get.find<MenuViewModel>()
                .blogList!
                .firstWhere((element) => element.isDialog == true) !=
            null)) {
      Timer.run(showImageDialog);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ScopedModel<CartViewModel>(
        model: Get.find<CartViewModel>(),
        child: ScopedModelDescendant<CartViewModel>(
            builder: (context, build, model) {
          return Visibility(
            visible: _selectedIndex == 0 ||
                _selectedIndex == 1 ||
                _selectedIndex == 2,
            child: FloatingActionButton(
                elevation: 10,
                backgroundColor: ThemeColor.primary,
                onPressed: () {
                  if (model.cart.productList == null ||
                      model.cart.productList!.isEmpty) {
                    showAlertDialog(
                        title: "Giỏ hàng trống",
                        content:
                            "Giỏ hàng đang trống, vui lòng đặt sản phảm bạn nhé");
                  } else if (userModel == null) {
                    showAlertDialog(
                        title: "Người dùng chưa đăng nhập",
                        content:
                            "Vui lòng đăng nhập để đặt đơn và nhận ưu đãi nhé");
                  } else {
                    Get.toNamed(RouteHandler.CART);
                  }
                },
                tooltip: "1",
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                )),
          );
        }),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: portraitViews[_selectedIndex],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: items,
        currentIndex: _selectedIndex,
        selectedItemColor: ThemeColor.primary,
        unselectedItemColor: Colors.grey[700],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

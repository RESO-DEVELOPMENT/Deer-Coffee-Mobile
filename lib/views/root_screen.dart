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
import 'orders_screen/menu_screen.dart';
import 'profile_screen/order_history.dart';
import 'profile_screen/profile.dart';
import 'home_page_order_method.dart';
import 'bottom_sheet_util.dart';
import 'home_page_order_method.dart';
import 'qr_screen/qr_screen.dart';

class RootScreen extends StatefulWidget {
  final int idx;
  const RootScreen({super.key, required this.idx});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;
  String? userId;
  List<Widget> portraitViews = [
    HomePage(),
    OrdersScreen(),
    // MenuScreen(),
    QrScreen(),
    OrderHistory(),
    OtherPage(),
  ];

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined), label: 'Trang chủ'),
    BottomNavigationBarItem(
        icon: Icon(Icons.coffee_outlined), label: 'Đặt hàng'),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.qr_code_scanner,
        color: ThemeColor.primary,
        size: 32,
      ),
      label: 'Quét mã',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.history_outlined,
        ),
        label: 'Hoạt động'),
    BottomNavigationBarItem(
        icon: Icon(Icons.person_2_outlined), label: 'Tài khoản'),
  ];
  @override
  void initState() {
    _selectedIndex = widget.idx;

    getUserId().then((value) => {userId = value});
    // Get.find<AccountViewModel>().getMembershipInfo();
    // if (Get.find<MenuViewModel>().blogList != null &&
    //     // ignore: unnecessary_null_comparison
    //     (Get.find<MenuViewModel>()
    //             .blogList!
    //             .firstWhere((element) => element.isDialog == true) !=
    //         null)) {
    //   Timer.run(showImageDialog);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: portraitViews[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: items,
        iconSize: 24,
        currentIndex: _selectedIndex,
        selectedItemColor: ThemeColor.primary,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

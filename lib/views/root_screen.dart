import 'package:deer_coffee/utils/route_constrant.dart';
import 'package:deer_coffee/views/product_details.dart';
import 'package:deer_coffee/views/store.dart';
import 'package:deer_coffee/views/orders_screen.dart';
import 'package:deer_coffee/views/voucher_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_models/menu_view_model.dart';
import 'home_page.dart';
import 'order.dart';
import 'other_page.dart';
import 'home_page_order_method.dart';
import 'bottom_sheet_util.dart';
import 'home_page_order_method.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;

  List<Widget> portraitViews = [
    HomePage(),
    OrdersScreen(),
    Store(),
    VoucherLogin(),
    OtherPage(),
  ];

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
    BottomNavigationBarItem(
        icon: Icon(Icons.coffee_outlined), label: 'Đặt hàng'),
    BottomNavigationBarItem(
        icon: Icon(Icons.store_outlined), label: 'Cửa hàng'),
    BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Ưu đãi'),
    BottomNavigationBarItem(icon: Icon(Icons.segment_sharp), label: 'Khác'),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible:
            _selectedIndex == 0 || _selectedIndex == 1 || _selectedIndex == 2,
        child: Align(
          heightFactor: 0,
          alignment: const Alignment(0, 3.5),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                  ),
                ]),
            padding: EdgeInsets.all(8),
            width: Get.width * 0.95,
            height: 50,
            child: InkWell(
              onTap: () => Get.toNamed(RouteHandler.CART),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Giao hàng",
                              style: Get.textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Text(
                          "Các sản phẩm sẽ được giao đến địa chỉ của bạn",
                          style: Get.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(RouteHandler.CART);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 24.0, // Kích thước của hình tròn
                          height: 24.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              "2",
                              style: Get.textTheme.bodySmall,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '10.000đ',
                          style: Get.textTheme.bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: portraitViews[_selectedIndex],
              ),
              BottomNavigationBar(
                showUnselectedLabels: true,
                items: items,
                currentIndex: _selectedIndex,
                selectedItemColor: Get.theme.colorScheme.primary,
                unselectedItemColor: Colors.grey[700],
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

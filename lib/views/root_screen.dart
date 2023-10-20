import 'package:deer_coffee/views/store.dart';
import 'package:deer_coffee/views/tracking.dart';
import 'package:deer_coffee/views/voucher_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    Tracking(),
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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible:
            _selectedIndex == 0 || _selectedIndex == 1 || _selectedIndex == 2,
        child: Align(
          heightFactor: 0,
          alignment: const Alignment(0, 3.5),
          child: SizedBox(
            width: Get.width * 0.9,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                showCustomBottomSheet(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Giao hàng",
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.0),
                          ),
                          Text(
                            "Các sản phẩm sẽ được giao đến địa chỉ của bạn",
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.0),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    FilledButton(onPressed: () {}, child: Text("10000 d"))
                  ],
                ),
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

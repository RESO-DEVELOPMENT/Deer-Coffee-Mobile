import 'package:deer_coffee/views/order_determination.dart';
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
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.black, // Màu của biểu tượng
                              size: 24.0, // Kích thước của biểu tượng
                            ),
                            Text(
                              "Giao hàng",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 12.0),
                            ),
                          ],
                        ),
                        Text(
                          "Các sản phẩm sẽ được giao đến địa chỉ của bạn",
                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Option(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      child: Row(
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
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            '10.000đ',
                            style: TextStyle(
                              color: Colors.white,
                            ),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page.dart';
import 'order.dart';
import 'other_page.dart';
import 'home_page_order_method.dart';
import 'bottom_sheet_util.dart'; 
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;

  List<Widget> portraitViews = [
    HomePage(),
    OrderMethod(),
    OrderScreen(),
    OtherPage(),
    OrderMethod(),
  ];

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
    BottomNavigationBarItem(icon: Icon(Icons.coffee_outlined), label: 'Đặt hàng'),
    BottomNavigationBarItem(icon: Icon(Icons.store_outlined), label: 'Cửa hàng'),
    BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Ưu đãi'),
    BottomNavigationBarItem(icon: Icon(Icons.segment_sharp), label: 'Khác'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: portraitViews[_selectedIndex],
              ),
              BottomNavigationBar(
                items: items,
                currentIndex: _selectedIndex,
                selectedItemColor: Get.theme.primaryColor,
                unselectedItemColor: Colors.grey,
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Visibility(
              visible: _selectedIndex == 0, // Show only on the "Trang chủ" page
              child: Padding(
                padding: const EdgeInsets.only(top: 550),
                child: Container(
                  width: 350,
                  height: 70,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      showCustomBottomSheet(context);
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, right: 10),
                          child: Center(
                            child: Row(
                              children: [
                                Image.asset('assets/images/shipper.png', height: 18, width: 18),
                                SizedBox(width: 3),
                                Text(
                                  "Giao hàng",
                                  style: TextStyle(color: Colors.black, fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 0,
                          child: Text(
                            "Các sản phẩm sẽ được giao đến địa chỉ của bạn",
                            style: TextStyle(color: Colors.black, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

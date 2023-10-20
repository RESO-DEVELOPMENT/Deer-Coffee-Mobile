import 'package:deer_coffee/views/order_determination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import 'home_page.dart';

class Tracking extends StatefulWidget {
  Tracking({Key? key}) : super(key: key);

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  int _currentIndex = 0;

  final List<Widget> buttons = [
    buildCircularButton('Trà', Colors.black),
    buildCircularButton('Cà Phê', Colors.black),
    buildCircularButton('CloudTea', Colors.black),
    buildCircularButton('Hi-Tea ', Colors.black),
    buildCircularButton('Trà Trái Cây', Colors.black),
    buildCircularButton('Trà Xanh ', Colors.black),
    buildCircularButton('Đá xay ', Colors.black),
    buildCircularButton('Xem thêm', Colors.black),
  ];

  static Widget buildCircularButton(String text1, Color textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            // Xử lý khi nhấn vào hình tròn ở đây
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          text1,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5EDFF),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/waving_hand.png',
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chào buổi sáng",
                          style: GoogleFonts.getFont(
                            'Inter',
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          "Quốc Khánh",
                          style: GoogleFonts.getFont(
                            'Inter',
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 55,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.confirmation_num_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 03),
                    Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Ionicons.notifications_outline,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 240,
                width: Get.width,
                padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  padding: EdgeInsets.all(4),
                  children: buttons,
                )),
            SizedBox(
              height: 24,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              width: Get.width,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Siêu Deal -39k FREESHIP",
                    style: Get.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.left, // Đặt chữ ở bên trái
                  ),
                  SizedBox(height: 10,),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Đặt căn chỉnh các phần tử trong hàng lên trên cùng
                          children: [
                            Container(
                              height: 100,
                              child: Image.asset("assets/images/4.png"),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            const Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Đặt căn chỉnh theo chiều ngang sang trái
                                children: [
                                  Text(
                                    "Kiwi Yogurt",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          10), // Đặt khoảng cách giữa "Kiwi Yogurt" và "49.000đ"
                                  Text(
                                    "49.000 đ",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Thêm nút "Add" và xử lý khi được nhấn
                            IconButton.filled(
                              icon: const Icon(
                                Icons.add,
                                size: 32,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Option(), // Replace with your VoucherQr page
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Đặt căn chỉnh các phần tử trong hàng lên trên cùng
                          children: [
                            Container(
                              height: 100,
                              child: Image.asset("assets/images/4.png"),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Đặt căn chỉnh theo chiều ngang sang trái
                                children: [
                                  Text(
                                    "Kiwi Yogurt",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          10), // Đặt khoảng cách giữa "Kiwi Yogurt" và "49.000đ"
                                  Text(
                                    "49.000 đ",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Thêm nút "Add" và xử lý khi được nhấn
                            IconButton.filled(
                              icon: const Icon(
                                Icons.add,
                                size: 32,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Option(), // Replace with your VoucherQr page
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Đây là cột mới
          ],
        ),
      ),
    );
  }

  void _changeItem(int value) {
    print(value);
    setState(() {
      _currentIndex = value;
    });
  }

  Widget buildRowWithButtons(int startIndex, int endIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (int i = startIndex; i <= endIndex; i++)
          if (i < buttons.length) buttons[i], // Thêm chữ dưới hình tròn
      ],
    );
  }
}

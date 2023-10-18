import 'package:deer_coffee/views/order_determination.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class Tracking extends StatefulWidget {
  Tracking({Key? key}) : super(key: key);

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  int _currentIndex = 0;

  final List<Widget> buttons = [
    buildCircularButton('Siêu Deal-', '39k', 'FREESHIP', Colors.black),
    buildCircularButton('', 'Cà Phê', '', Colors.black),
    buildCircularButton('', 'CloudTea', '', Colors.black),
    buildCircularButton('Hi-Tea ', 'Healthy', '', Colors.black),
    buildCircularButton('Trà Trái Cây', '-Trà Sữa', '', Colors.black),
    buildCircularButton('Trà Xanh ', 'Tây Bắc', '', Colors.black),
    buildCircularButton('Đá xay ', 'Frosty', '', Colors.black),
    buildCircularButton('Xem thêm', '', '', Colors.black),
  ];

  static Widget buildCircularButton(
      String text1, String text2, String text3, Color textColor) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // Xử lý khi nhấn vào hình tròn ở đây
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 70,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
        Text(
          text1,
          style: TextStyle(
            color: textColor,
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            color: textColor,
          ),
        ),
        Text(
          text3,
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/5.png', // Đường dẫn đến ảnh chào buổi sáng
              width: 40, // Đặt kích thước của ảnh
              height: 40,
            ),
            SizedBox(width: 10), // Khoảng cách giữa ảnh và dòng chữ
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chào buổi sáng',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Quốc khánh',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Container(
              width: 70, // Đặt chiều cao và rộng của Container để tạo hình tròn
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle, // Đặt hình dạng thành hình tròn
                  color: Colors.blue, // Màu nền xanh
                  borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                icon: Icon(
                  Icons.confirmation_number,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Xử lý khi biểu tượng được nhấn
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue, // Màu nền xanh
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Xử lý khi nút biểu tượng thứ nhất được nhấn
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            buildRowWithButtons(0, 3),
            buildRowWithButtons(4, 7),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: Row(
                children: [
                  Text(
                    "Siêu Deal -39k FREESHIP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left, // Đặt chữ ở bên trái
                  ),
                ],
              ),
            ),
            // Đây là cột mới
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Đặt căn chỉnh các phần tử trong hàng lên trên cùng
                    children: [
                      Container(
                        height: 130,
                        child: Image.asset("assets/images/4.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
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
                              "49.000đ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      // Thêm nút "Add" và xử lý khi được nhấn
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    Option(), // Replace with your VoucherQr page
                              ),
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue[300],
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Đặt căn chỉnh các phần tử trong hàng lên trên cùng
                    children: [
                      Container(
                        height: 130,
                        child: Image.asset("assets/images/4.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
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
                              "49.000đ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      // Thêm nút "Add" và xử lý khi được nhấn
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    Option(), // Replace with your VoucherQr page
                              ),
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue[300],
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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

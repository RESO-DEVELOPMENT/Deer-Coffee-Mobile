import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Khác",
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 185,
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tiện ích",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GridView.count(
                crossAxisCount: 2, // 2 cột
                shrinkWrap: true,
                childAspectRatio:
                    3 / 1, // Tỷ lệ 2:1 giữa chiều ngang và chiều cao
                children: [
                  // Ô 1
                  Positioned(
                    top: 10, // Điều chỉnh vị trí theo chiều dọc
                    left: 10, // Điều chỉnh vị trí theo chiều ngang
                    child: Transform.scale(
                      scale: 0.9, // Thay đổi tỷ lệ kích thước của hình chữ nhật
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, // Màu của bóng đổ
                              offset: Offset(0,
                                  0.5), // Điều chỉnh vị trí bóng đổ theo chiều ngang và dọc
                              // Độ mờ của bóng đổ
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10, left: 10),
                                child: Text(
                                  'Lịch sử đơn hàng',
                                  style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Các nội dung bên trong ô 1
                      ),
                    ),
                  ),
                  // Ô 2
                  Positioned(
                    top: 20, // Điều chỉnh vị trí theo chiều dọc
                    left: 20, // Điều chỉnh vị trí theo chiều ngang
                    child: Transform.scale(
                      scale: 0.9, // Thay đổi tỷ lệ kích thước của hình chữ nhật
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, // Màu của bóng đổ
                              offset: Offset(0, 0.5),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10, left: 10),
                                child: Text(
                                  'Điều khoản',
                                  style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Các nội dung bên trong ô 2
                      ),
                    ),
                  ),
                  // Ô 3
                  Positioned(
                    top: 30, // Điều chỉnh vị trí theo chiều dọc
                    left: 30, // Điều chỉnh vị trí theo chiều ngang
                    child: Transform.scale(
                      scale: 0.9, // Thay đổi tỷ lệ kích thước của hình chữ nhật
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, // Màu của bóng đổ
                              offset: Offset(0, 0.5),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10, left: 10),
                                child: Text(
                                  'Về tôi',
                                  style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Các nội dung bên trong ô 3
                      ),
                    ),
                  ),
                  // Ô 4
                  Positioned(
                    top: 40, // Điều chỉnh vị trí theo chiều dọc
                    left: 40, // Điều chỉnh vị trí theo chiều ngang
                    child: Transform.scale(
                      scale: 0.9, // Thay đổi tỷ lệ kích thước của hình chữ nhật
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, // Màu của bóng đổ
                              offset: Offset(0, 0.5),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10, left: 10),
                                child: Text(
                                  'Điều khoản VNPay',
                                  style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Các nội dung bên trong ô 4
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Hỗ trợ",
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              GridView.count(
                crossAxisCount: 1, // 2 cột
                shrinkWrap: true,
                childAspectRatio: 7 / 1,
                children: [
                  Positioned(
                    child: Transform.scale(
                      scale: 0.9, // Thay đổi tỷ lệ kích thước của hình chữ nhật
                      child: Container(
                        height: 100, // Điều chỉnh chiều cao của hộp
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, // Màu của bóng đổ
                              offset: Offset(0, 0.5),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10, left: 10),
                                child: Text(
                                  'Đánh giá đơn hàng',
                                  style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Các nội dung bên trong ô 4
                      ),
                    ),
                  ),
                  Positioned(
                    child: Transform.scale(
                      scale: 0.9, // Thay đổi tỷ lệ kích thước của hình chữ nhật
                      child: Container(
                        height: 100, // Điều chỉnh chiều cao của hộp
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, // Màu của bóng đổ
                              offset: Offset(0, 0.5),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10, left: 10),
                                child: Text(
                                  'Liên hệ và góp ý',
                                  style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Các nội dung bên trong ô 4
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Tài Khoản",
                style: GoogleFonts.inter(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 15),
                child: Container(
                  height: 240,
                  width: 355,
                  padding: EdgeInsets.symmetric(
                      horizontal: 10), // Khoảng cách xung quanh nội dung
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    //   border: Border.all(
                    // color: Colors.grey, // Màu của đường viền nếu cần

                    //   ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white, // Màu của bóng đổ
                        offset: Offset(0, 0.5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Thông tin cá nhân',
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              // Xử lý khi nút mũi tên được nhấn
                            },
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Địa chỉ đã lưu',
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              // Xử lý khi nút mũi tên được nhấn
                            },
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cài đặt',
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              // Xử lý khi nút mũi tên được nhấn
                            },
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Đăng xuất',
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              // Xử lý khi nút mũi tên được nhấn
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
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
}

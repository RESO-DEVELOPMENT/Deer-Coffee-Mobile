import 'package:barcode_widget/barcode_widget.dart';
import 'package:deer_coffee/views/order_history.dart';
import 'package:deer_coffee/views/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:scoped_model/scoped_model.dart';

import '../enums/view_status.dart';
import '../utils/route_constrant.dart';
import '../view_models/account_view_model.dart';

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
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        title: Text(
          "Tài khoản" ,
          style:
              Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.find<AccountViewModel>().processSignOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHandler.ORDER);
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 10, left: 10),
                                    child: Text(
                                      'Lịch sử đơn hàng',
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UpdateProfilePage(),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.white,
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 10, left: 10),
                                    child: Text(
                                      'Thông tin cá nhân',
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: Get.width,
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
                          const Divider(),
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
                                'Điều khoản',
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
                                  Get.find<AccountViewModel>().processSignOut();
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

  Widget loginCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 120, 16, 16),
      padding: const EdgeInsets.all(24),
      width: Get.width * 0.9,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Đăng nhập',
            style:
                Get.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Text(
              'Sử dụng app để tích điểm và đổi những ưu đãi chỉ dành riêng cho thành viên bạn nhé !',
              style: Get.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/hinhchunhat.png',
                height: 100,
                width: 329,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: -15,
                child: Container(
                  width: Get.width * 0.6,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment(-1, -1.133),
                      end: Alignment(1, 1.367),
                      colors: <Color>[Color(0xff549ffd), Color(0xffc8ddff)],
                      stops: <double>[0.014, 1],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(RouteHandler.LOGIN);
                    },
                    child: Text(
                      'Đăng nhập',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 70,
                child: Container(
                  width: Get.width * 0.6,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment(-1, -1.133),
                      end: Alignment(1, 1.367),
                      colors: <Color>[Color(0xff549ffd), Color(0xffc8ddff)],
                      stops: <double>[0.014, 1],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Deer Coffee Reward',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffffffff),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            clipBehavior: Clip.none,
          ),
        ],
      ),
    );
  }

  Widget userCard(AccountViewModel model) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 80, 16, 16),
      padding: const EdgeInsets.all(16),
      width: Get.width * 0.9,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/homepage.png'),
          fit: BoxFit.cover,
        ),
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            model.user?.userInfo?.fullName ?? '',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.payment, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            "Số dư : 100.000 đ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.card_giftcard, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            "Điểm : 0 BEAN",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Card(
            child: Container(
              height: 120,
              width: Get.width, // Chỉnh độ cao của container chứa ảnh
              padding: const EdgeInsets.all(16), // Loại bỏ padding
              child: BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: "0358817512",
                  style: Get.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

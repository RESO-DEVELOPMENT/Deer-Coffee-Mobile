import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class OrderMethod extends StatefulWidget {
  const OrderMethod({super.key});

  @override
  State<OrderMethod> createState() => _OrderMethodState();
}

final List<String> imageList = [
  'assets/images/1.png',
  'assets/images/2.png',
  'assets/images/3.png',
];

class _OrderMethodState extends State<OrderMethod> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5EDFF),
      appBar: AppBar(
        title: Row(
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
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "Quốc Khánh",
                      style: GoogleFonts.inter(
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
                SizedBox(width: 3),
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
        backgroundColor: Colors.transparent,
        elevation: 1,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // sau sccaff
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.coffee_outlined), label: 'Đặt hàng'),
          BottomNavigationBarItem(
              icon: Icon(Icons.store_outlined), label: 'Cửa hàng'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Ưu đãi'),
          BottomNavigationBarItem(
              icon: Icon(Icons.segment_sharp), label: 'Khác'),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _changeItem, // Đổi màu khi nổi lên (chọn)
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/homepage.png'),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 291,
                width: 356,
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Positioned(
                      left: 30,
                      right: 50,
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Nguyễn Quốc Khánh",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.payment, color: Colors.white),
                                      SizedBox(width: 5),
                                      Text(
                                        "Trả trước :  0 đồng",
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
                    ),
                    SizedBox(height: 50),
                    Container(
                      width: 600,
                      child: Card(
                        margin: const EdgeInsets.all(15),
                        child: Container(
                          height: 120,
                          width: 500, // Chỉnh độ cao của container chứa ảnh
                          padding: EdgeInsets.all(0), // Loại bỏ padding
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/scan.png',
                                width: 200, // Chỉnh chiều rộng của ảnh
                                height: 60,
                              ),
                              Text(
                                'D123456789',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // hop trang ben duoi
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              padding: EdgeInsets.only(bottom: 120),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30, top: 30),
                    child: Transform.rotate(
                      angle: 0 * (3.14159265359 / 180),
                      child: Container(
                        height: 5,
                        width: 49,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    width: 280,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // Add your onTap logic here
                              },
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.transparent),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.local_shipping_outlined,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Giao hàng",
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 45),
                              child: Transform.rotate(
                                angle: 90 * (3.14159265359 / 180),
                                child: Container(
                                  height: 2,
                                  width: 49,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                // Add your onTap logic here
                              },
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.transparent),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delivery_dining_outlined,
                                      color: Colors.black,
                                      size: 36,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Mang đi",
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        height: 155.0,
                        aspectRatio: 9,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: imageList.map((image) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage(image),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.map((url) {
                      int index = imageList.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: _currentIndex == index
                              ? Colors.blueAccent
                              : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height:
                        32, // Điều này tạo một khoảng trống để cuộn nội dung
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 30), // Thêm khoảng cách bên phải
                        child: Text(
                          'Khám phá thêm',
                          style: GoogleFonts.getFont(
                            'Inter',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Image.asset(
                        'assets/images/star.png',
                        height: 32,
                        width: 32,
                      ),
                      // Các phần tử khác ở dưới
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: LinearGradient(
                              begin: Alignment(-1, -1.133),
                              end: Alignment(1, 1.367),
                              colors: <Color>[
                                Color(0xff549ffd),
                                Color(0xffc8ddff)
                              ],
                              stops: <double>[0.014, 1],
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30.0),
                            onTap: () {
                              // Xử lý khi nút được nhấn
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                'Ưu đãi đặc biệt',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: LinearGradient(
                              begin: Alignment(-1, -1.133),
                              end: Alignment(1, 1.367),
                              colors: <Color>[
                                Color(0xff549ffd),
                                Color(0xffc8ddff)
                              ],
                              stops: <double>[0.014, 1],
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30.0),
                            onTap: () {
                              // Xử lý khi nút được nhấn
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                'Cập nhập từ Nhà',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0), // Khoảng cách giữa nút 2 và 3
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: LinearGradient(
                              begin: Alignment(-1, -1.133),
                              end: Alignment(1, 1.367),
                              colors: <Color>[
                                Color(0xff549ffd),
                                Color(0xffc8ddff)
                              ],
                              stops: <double>[0.014, 1],
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30.0),
                            onTap: () {
                              // Xử lý khi nút được nhấn
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                '#Coffee',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        for (int i = 0; i < 4; i++)
                          Row(
                            children: [
                              for (int j = 0; j < 2; j++)
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(
                                          10), // Add margin for spacing
                                      child: Card(
                                        child: Container(
                                          width:
                                              150, // Adjust the width as needed
                                          height:
                                              150, // Adjust the height as needed
                                          // Add other card content here
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "HÔNG CẦN ĐI XA\n",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              decoration: TextDecoration
                                                  .none, // Remove underline
                                            ),
                                          ),
                                          TextSpan(
                                            text: "CHILL NGAY TẠI NHÀ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              decoration: TextDecoration
                                                  .none, // Remove underline
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start, // Align the children to the right
                                      children: [
                                        Icon(Icons.calendar_today),
                                        // Your date text
                                        SizedBox(width: 5),
                                        Text(
                                            "01/08"), // Add spacing between the text and icon
                                      ],
                                    )
                                  ],
                                ),
                            ],
                          ),
                      ],
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
    setState(() {
      _currentIndex = value;
    });
  }
}

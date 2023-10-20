import 'package:deer_coffee/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<String> imageList = [
  'assets/images/1.png',
  'assets/images/2.png',
  'assets/images/3.png',
  // Thêm các đường dẫn đến hình ảnh của bạn tại đây
];

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5EDFF),
      body: Padding(
        padding: const EdgeInsets.all(8),
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
              height: 24,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 260,
              width: Get.width,
              padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Đăng nhập',
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
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
                              colors: <Color>[
                                Color(0xff549ffd),
                                Color(0xffc8ddff)
                              ],
                              stops: <double>[0.014, 1],
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              LoginScreen loginScreen = LoginScreen();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => loginScreen,
                                ),
                              );
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
                              colors: <Color>[
                                Color(0xff549ffd),
                                Color(0xffc8ddff)
                              ],
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
                                  'Deer Coffee House\'s Reward',
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
            ),
            // hop trang ben duoi
            SizedBox(
              height: 8,
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
                    width: Get.width * 0.6,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Get.theme.colorScheme.secondary,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.local_shipping_outlined,
                                  color: Colors.black,
                                  size: 40,
                                ),
                                Text("Giao hàng",
                                    style: Get.textTheme.titleSmall),
                              ],
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          width: 3,
                          indent: 4,
                          endIndent: 4,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.delivery_dining_outlined,
                                  color: Colors.black,
                                  size: 40,
                                ),
                                Text("Mang đi",
                                    style: Get.textTheme.titleSmall),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        height: 155.0, // Điều chỉnh chiều cao của slider
                        aspectRatio: 9,
                        autoPlay: true, // Tự động chuyển đổi ảnh
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
                        24, // Điều này tạo một khoảng trống để cuộn nội dung
                  ),
                  Text('Khám phá thêm',
                      style: Get.textTheme.titleLarge,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr),
                  SingleChildScrollView(
                    padding: EdgeInsets.all(8),
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
                        SizedBox(width: 8.0), // Khoảng cách giữa nút 1 và 2
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
                            onTap: () {},
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
                        // Thêm các phần tử khác ở đây
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: Colors.grey,
                        clipBehavior: Clip.none,
                        child: Container(),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: Colors.grey,
                        clipBehavior: Clip.none,
                        child: Container(),
                      ),
                    ],
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
}

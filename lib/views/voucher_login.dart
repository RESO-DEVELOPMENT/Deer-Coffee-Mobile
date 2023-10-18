import 'package:deer_coffee/views/drips.dart';
import 'package:deer_coffee/views/reward.dart';
import 'package:deer_coffee/views/reward_coffee.dart';
import 'package:deer_coffee/views/voucher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    home: VoucherLogin(),
  ));
}

class VoucherLogin extends StatefulWidget {
  const VoucherLogin({Key? key}) : super(key: key);

  @override
  State<VoucherLogin> createState() => _VoucherLoginState();
}

class _VoucherLoginState extends State<VoucherLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/tree1.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 55, left: 20),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Ưu đãi',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Mới',
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                               Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Voucher(), // Replace with your OrderMethod page
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.confirmation_number,
                                  color: Colors.lightBlue,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'Voucher của tôi',
                                  style: TextStyle(
                                    color: Colors.lightBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '0 BEAN',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 400,
                        child: Card(
                          margin: const EdgeInsets.all(15),
                          child: Container(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/scan.png',
                                  width: 200,
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
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
               
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Tiện ích",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      childAspectRatio: 2 / 1,
                      children: <Widget>[
                        buildUtilityWidget("Hạng thành viên"),
                        buildUtilityWidget("Đổi Bean"),
                        buildUtilityWidget("Lịch sử BEAN"),
                        buildUtilityWidget("Quyền lợi của bạn"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
           
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Phần thưởng khả dụng',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                       color: Color(0xFFF5F5F5),
                    ),
                    child: DropdownButton<String>(
                      items: <String?>[null, 'Option 1', 'Option 2', 'Option 3']
                          .map((String? value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value ?? 'Xem tất cả',
                            style: TextStyle(color: Colors.lightBlue),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          // Handle the event when a dropdown option is selected
                        }
                      },
                      underline: Container(),
                    ),
                  ),
                ],
              ),
            ),
            buildTicketWidget(
                "Dòng giảm 40% + FREESHIP", "Đơn 4 ly", "Hết hạn: 9/9/2023"),
            buildTicketWidget(
                "Dòng giảm 40% + FREESHIP", "Đơn 4 ly", "Hết hạn: 9/9/2023"),
            buildTicketWidget(
                "Dòng giảm 40% + FREESHIP", "Đơn 4 ly", "Hết hạn: 9/9/2023"),
            buildTicketWidget(
                "Dòng giảm 40% + FREESHIP", "Đơn 4 ly", "Hết hạn: 9/9/2023"),
            buildTicketWidget(
                "Dòng giảm 40% + FREESHIP", "Đơn 4 ly", "Hết hạn: 9/9/2023"),
            buildTicketWidget(
                "Dòng giảm 40% + FREESHIP", "Đơn 4 ly", "Hết hạn: 9/9/2023"),
            // Add more TicketWidgets as needed
          ],
        ),
      ),
    );
  }

 Widget buildUtilityWidget(String title) {
  return GestureDetector(
    onTap: () {
      if (title == "Lịch sử BEAN") {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RewardCoffee(),
          ),
        );
      } else if (title == "Hạng thành viên") {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Reward(),
          ),
        );
      } else if (title == "Đổi Bean") {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Drip(),
          ),
        );
      }
    },
    child: Positioned(
      top: 10,
      left: 10,
      child: Transform.scale(
        scale: 0.9,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 0.5),
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 10),
                  child: Text(
                    title,
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
  );
}



  Widget buildTicketWidget(String title, String subTitle1, String subTitle2) {
    return Container(
      width: double.infinity,
      height: 127.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CustomPaint(
            size: Size(150.0, 120.0),
            painter: TicketPainter(),
            foregroundPainter: DotPainter(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  subTitle1,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Text(
                    subTitle2,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Custom ticket drawing code here
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Color(0xFFF5F5F5);
    final double dotSpacing = 15.0;
    final double edgeDotSpacing = 30.0;
    final double leftOffset = 120.0;
    final double bottomOffset = size.height - 25.0;

    for (int i = 0; i < 10; i++) {
      double y = i * dotSpacing;

      if (i == 0 || i == 8) {
        canvas.drawCircle(Offset(leftOffset, y), 10.0, paint);
      } else if (i == 1 || i == 8) {
        canvas.drawCircle(Offset(leftOffset, y), 3.0, paint);
      } else {
        canvas.drawCircle(Offset(leftOffset, y), 3.0, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

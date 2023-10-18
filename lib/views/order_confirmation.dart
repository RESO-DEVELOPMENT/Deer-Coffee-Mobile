import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetContent extends StatefulWidget {
  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  String selectedPaymentMethod = "Tiền mặt";

  @override
  Widget build(BuildContext context) {  
    return Container(
      height: 680,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 36),
                      Text(
                        "Xác nhận đơn hàng",
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Địa chỉ giao hàng",
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Image(
                            image: AssetImage('assets/images/xe.png'),
                            width: 70,
                            height: 90,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Khách'),
                              SizedBox(height: 10),
                              Text(
                                'S202 Vinhomes Grand Par Nguyễn Xiển, Long \nThạnh Mỹ, Quận 9, Thành phố Hồ Chí Minh',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.border_color_outlined,
                              size: 30,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
               width: 350,
              padding: EdgeInsets.all(8), 
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
              child: RadioListTile<String>(
                title: Text(
                  'Tiền mặt',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Thanh toán khi nhận hàng',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                value: "Tiền mặt",
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
                secondary: Image(
                  image: AssetImage('assets/images/cash.png'),
                  width: 70,
                  height: 90,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
               width: 350,
              padding: EdgeInsets.all(8), // Tùy chỉnh lề cho hộp trắng
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
              child: RadioListTile<String>(
                title: Text(
                  'Credit Card',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '2540 xxxx xxxx 2648',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                value: "Credit Card",
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
                secondary: Image(
                  image: AssetImage('assets/images/visa.png'),
                  width: 100,
                  height: 90,
                ),
              ),
            ),
            SizedBox(height: 50,),
          Row(
  children: [
    Padding(
      padding: const EdgeInsets.only( left: 30,right: 205),
      child: Text(
        'Tổng phụ',
        style: GoogleFonts.inter(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Text(
      '180.000',
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),
SizedBox(height: 20,),
 Row(
  children: [
    Padding(
      padding: const EdgeInsets.only( left: 30,right: 185),
      child: Text(
        'Phí giao hàng',
        style: GoogleFonts.inter(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Text(
      '20.000',
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),
SizedBox(height: 20,),
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 0,left: 4),
        child: Text(
          'Chọn khuyến mãi',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(width: 15,),
      Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(width: 4),
            Text(
              'Tiết kiệm hơn với ưu đãi',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 10,
              ),
            )
          ],
        ),
      ),
    ],
  ),
),
SizedBox(height: 20,),
Row(
  children: [
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.only( left: 30,right: 60),
          child: Text(
            'Tổng cộng',
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(height: 5,),
        Text(
      '200.000',
      style: GoogleFonts.inter(
        color: const Color.fromRGBO(0, 0, 0, 1),
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
      ],
    ),
    SizedBox(height: 50,width: 50,),
    SizedBox(
  height: 55, 
  child: ElevatedButton(
    onPressed: () {
     
    },
    style: ElevatedButton.styleFrom(
      primary: Colors.blue, 
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Thanh toán',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 10,),
        Icon(
          Icons.payment,
          color: Colors.white,
          size: 24, 
        ),
      ],
    ),
  ),
)

  ],

),


          ],
          
        ),
      ),
    );
  }
}

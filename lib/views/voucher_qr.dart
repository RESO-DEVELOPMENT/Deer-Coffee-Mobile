import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class voucherQr extends StatefulWidget {
  const voucherQr({super.key});

  @override
  State<voucherQr> createState() => _voucherQrState();
}

class _voucherQrState extends State<voucherQr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            color: Colors.grey,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Color(0xFFF5F5F5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.cancel,
                              color: Colors.grey,
                              size: 30,
                            ),
                            SizedBox(width: 16),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Create the ticket-like UI
                        Container(
                          width: 320,
                          height: 663,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // Để căn giữa theo chiều ngang
                            children: [
                              Text(
                                'Deer Coffee',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Giảm 40% + FREESHIP đơn 4 ly',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              CustomPaint(
                                size: Size(500,
                                    12), // Điều chỉnh kích thước của đường kẻ
                                painter: DotPainter(),
                              ),
                              SizedBox(height: 40),
                              Image.asset(
                                'assets/images/QR.png', // Thay đổi đường dẫn tới tệp ảnh của bạn
                                width: 180, // Điều chỉnh chiều rộng của ảnh
                                height: 180, // Điều chỉnh chiều cao của ảnh
                              ),
                              SizedBox(height: 10),
                              Text(
                                'DEERCOFFEE20',
                                style: TextStyle(fontSize: 16),
                              ),
                              TextButton(
                                onPressed: () {
                                  final String textToCopy =
                                      'DEERCOFFEE20'; // Chuỗi bạn muốn sao chép
                                  Clipboard.setData(
                                      ClipboardData(text: textToCopy));
                                  // Hiển thị thông báo hoặc thực hiện các hành động khác sau khi sao chép thành công.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Đã sao chép: $textToCopy'),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Sao chép',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.lightBlue),
                                ),
                              ),
                              
                              SizedBox(
                                width: 200,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => Tracking(), // Thay thế "SecondPage" bằng tên trang mới của bạn
                                    //   ),
                                    // );
                                  },
                                  child: Text(
                                    "Bắt đầu đặt hàng",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(
                                color: Colors.grey[300],
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Căn giữa và đặt cách đều hai phần tử
                                children: [
                                  Text(
                                    'Ngày hết hạn :',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  Text(
                                    '24/9/2023',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.grey[300],
                                thickness: 1,
                              ),
                          
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Để căn bên trái theo chiều ngang
                                children: [
                                  Text(
                                    'Giảm 40% đơn từ 4 ly nước trở lên kèm FREESHIP',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    '• Áp dụng tất cả nước',  
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    '• Không áp dụng cho chai và topping',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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

class DotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Color(0xFFF5F5F5);
    final double dotSpacing = 22;
    final double edgeDotSpacing = 15;
    final double topOffset = 25.0;

    for (int i = 0; i < 15; i++) {
      double x = i * dotSpacing;

      if (i == 0) {
        x -= edgeDotSpacing;
        canvas.drawCircle(Offset(x, topOffset), 10.0, paint);
      } else if (i == 13) {
        x += edgeDotSpacing;
        canvas.drawCircle(Offset(x, topOffset), 10.0, paint);
      } else {
        canvas.drawCircle(Offset(x, topOffset), 4.0, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

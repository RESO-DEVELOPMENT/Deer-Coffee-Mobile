import 'dart:async';

import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:deer_coffee/views/home_page_order_method.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:pinput/pinput.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({super.key});

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  int _countdown = 60; // Đếm ngược từ 60 giây
  late Timer _timer;
  String? phoneNumber;

  @override
  void initState() {
    phoneNumber = Get.find<AccountViewModel>().phoneNumber;
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer.cancel(); // Hủy bỏ timer khi đếm ngược kết thúc
          // Thực hiện hành động khi đếm ngược kết thúc
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      body: Stack(
        children: [
          // Hình ảnh làm background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage('assets/images/image.png'), ////////fffffff/ffff
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Nội dung trên hình ảnh
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      )
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
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end, // Di chuyển icon sang bên trái
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.grey,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Navigate back to the previous screen (LoginScreen)
                              },
                            ),
                            // Đặt khoảng trống giữa icon và phần còn lại
                            SizedBox(width: 16),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                          // child: Image.asset("assets/login.png"),
                        ),
                        Text(
                          "Xác Nhận Mã OTP",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "Một mã xác định gồm 6 số đã gửi đến số điện thoại $phoneNumber",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Nhập mã để tiếp tục ",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          children: [],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50.0,
                            vertical: 5.0,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Pinput(
                          length: 6,
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onSubmitted: (input) {
                            Get.find<AccountViewModel>().verifyOTPCode(input);
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Bạn không nhận mã?"),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _countdown = 180;
                                });
                                startCountdown();
                              },
                              child: Text('Gửi lại '),
                            ),
                            Text(
                              '($_countdown)',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        )
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

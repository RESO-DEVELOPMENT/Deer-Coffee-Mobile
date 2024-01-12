import 'dart:async';

import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../utils/theme.dart';

class MyOtp extends StatefulWidget {
  final String type;
  final String phone;
  const MyOtp({super.key, required this.phone, required this.type});

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  int _countdown = 6; // Đếm ngược từ 60 giây
  late Timer _timer;
  String? phoneNumber;
  String? pin;
  TextEditingController? pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    phoneNumber = Get.find<AccountViewModel>().phoneNumber;
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    pinController?.dispose();
    focusNode.dispose();
    _timer.cancel();
    super.dispose();
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          // Hình ảnh làm background
          Container(
            decoration: const BoxDecoration(
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
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end, // Di chuyển icon sang bên trái
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.grey,
                                size: 30,
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            // Đặt khoảng trống giữa icon và phần còn lại
                            const SizedBox(width: 16),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                          // child: Image.asset("assets/login.png"),
                        ),
                        Text(
                          widget.type == "RESETPASS"
                              ? "Cập nhật mã PIN"
                              : widget.type == "SIGNIN"
                                  ? "Xác Nhận Mã PIN"
                                  : "Tạo mã PIN",
                          style: Get.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "Mã pin là mật gồm 6 số dùng để đăng nhập với số điện thoại ${widget.phone}",
                                style: Get.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Nhập mã để tiếp tục ",
                                style: Get.textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Pinput(
                          length: 6,
                          controller: pinController,
                          showCursor: true,
                          focusNode: focusNode,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (pinController?.text.length == 6) {
                                Get.find<AccountViewModel>().onLogin(
                                    widget.phone,
                                    pinController?.text ?? '213458',
                                    widget.type);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: pinController?.text.length != 6
                                    ? Colors.grey
                                    : ThemeColor.primary,
                                textStyle: Get.textTheme.titleMedium
                                    ?.copyWith(color: Colors.white)),
                            child: Text(
                                widget.type == "RESETPASS"
                                    ? "Cập nhật"
                                    : widget.type == "SIGNIN"
                                        ? "Đăng nhập"
                                        : "Đăng kí",
                                style: Get.textTheme.titleMedium
                                    ?.copyWith(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     const Text("Bạn không nhận mã?"),
                        //     TextButton(
                        //       onPressed: () {
                        //         if (_countdown == 0) {
                        //           Get.find<AccountViewModel>().resendOtp();
                        //         }
                        //       },
                        //       child: const Text('Gửi lại'),
                        //     ),
                        //     const Text("sau "),
                        //     Text(
                        //       '($_countdown)',
                        //       style: const TextStyle(color: Colors.black),
                        //     ),
                        //   ],
                        // )
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

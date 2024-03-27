import 'dart:async';

import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:deer_coffee/widgets/other_dialogs/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../utils/theme.dart';

class SignUp extends StatefulWidget {
  final String type;
  final String phone;
  const SignUp({super.key, required this.phone, required this.type});

  @override
  State<SignUp> createState() => _SignUpState();
}

extension StringValidation on String {
  bool get isValidEmail {
    if (this == null) return false;
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    if (this == null) return false;
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }
}

class _SignUpState extends State<SignUp> {
  int _countdown = 6; // Đếm ngược từ 60 giây
  late Timer _timer;
  String? phoneNumber;
  String? pin;
  TextEditingController? pinController = TextEditingController();
  TextEditingController? reenterPinController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _selectedGender = 'ORTHER';
  String? downloadURL;
  String fullName = '';
  String? gender = '';
  String? email = '';

  final focusNode = FocusNode();
  final reFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final reFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    phoneNumber = Get.find<AccountViewModel>().phoneNumber;
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    pinController?.dispose();
    reenterPinController?.dispose();
    focusNode.dispose();
    reFocusNode.dispose();
    _timer.cancel();
    super.dispose();
  }

  Widget _buildPinStatus() {
    return Center(
      key: formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            pinController?.text.length == 6
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: pinController?.text.length == 6 ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            'Mã PIN ${pinController?.text.length == 6 ? 'hợp lệ' : 'không hợp lệ'}',
            style: TextStyle(
              color:
                  pinController?.text.length == 6 ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReenterPinStatus() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            reenterPinController?.text.length == 6
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: reenterPinController?.text.length == 6
                ? Colors.green
                : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            'Re-entered PIN is ${reenterPinController?.text.length == 6 ? 'valid' : 'invalid'}',
            style: TextStyle(
              color: reenterPinController?.text.length == 6
                  ? Colors.green
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
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
          // Container(
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage('assets/images/image.png'),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          // Nội dung trên hình ảnh
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    // padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment
                        //       .end, // Di chuyển icon sang bên trái
                        //   children: [
                        //     IconButton(
                        //       icon: const Icon(
                        //         Icons.cancel,
                        //         color: Colors.grey,
                        //         size: 30,
                        //       ),
                        //       onPressed: () {
                        //         Get.back();
                        //       },
                        //     ),
                        //     // Đặt khoảng trống giữa icon và phần còn lại
                        //     const SizedBox(width: 16),
                        //   ],
                        // ),
                        Text(
                          "Đăng ký tài khoản",
                          style: Get.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints(
                            maxHeight: 70,
                          ),
                          width: double.infinity,
                          margin: EdgeInsets.all(6),
                          child: TextFormField(
                            maxLength: 100,
                            validator: (value) {
                              if (value != null &&
                                  value.isNotEmpty &&
                                  value.trim().isEmpty) {
                                return 'Vui lòng nhập tên';
                              }
                              return null;
                            },
                            controller: _nameController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                              fullName = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Họ và tên',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),

                        // Email
                        Container(
                          constraints: const BoxConstraints(
                            minHeight: 40,
                          ),
                          width: double.infinity,
                          margin: EdgeInsets.all(6),
                          child: TextFormField(
                            validator: (value) {
                              if (value != null && !value.isValidEmail) {
                                return 'Vui lòng nhập email hợp lệ';
                              }
                              return null;
                            },
                            controller: _emailController,
                            onChanged: (value) {
                              email = value;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints(
                            minHeight: 50,
                          ),
                          width: double.infinity,
                          margin: EdgeInsets.all(8),
                          child: DropdownButtonFormField<String>(
                            value: _selectedGender,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedGender = newValue!;
                              });
                            },
                            items: ['MALE', 'FEMALE', 'ORTHER']
                                .map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value == "MALE"
                                        ? "Nam"
                                        : value == "FEMALE"
                                            ? 'Nữ'
                                            : "Khác",
                                  ),
                                );
                              },
                            ).toList(),
                            decoration: InputDecoration(
                                labelText: 'Giới tính',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                prefixIcon: _selectedGender == "ORTHER"
                                    ? const Icon(Icons.person_pin)
                                    : (_selectedGender == "FEMALE"
                                        ? const Icon(Icons.female)
                                        : const Icon(Icons.male))),
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // const SizedBox(
                        //   height: 30,
                        //   // child: Image.asset("assets/login.png"),
                        // ),
                        // Text(
                        //   widget.type == "RESETPASS"
                        //       ? "Cập nhật mã PIN"
                        //       : widget.type == "SIGNIN"
                        //           ? "Xác Nhận Mã PIN"
                        //           : "Đăng ký tài khoản",
                        //   style: Get.textTheme.titleLarge?.copyWith(
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.black,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // Text.rich(
                        //   TextSpan(
                        //     children: [
                        //       TextSpan(
                        //         text:
                        //             "Mã pin là mật gồm 6 số dùng để đăng nhập với số điện thoại ${widget.phone}",
                        //         style: Get.textTheme.bodyMedium,
                        //       ),
                        //     ],
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                        SizedBox(
                          height: 5,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Tạo mã PIN",
                                style: Get.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // _buildPinStatus(),

                        // _buildReenterPinStatus(),

                        // const SizedBox(
                        //   height: 16,
                        // ),
                        Pinput(
                          length: 6,
                          controller: pinController,
                          showCursor: true,
                          focusNode: focusNode,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        widget.type == "SIGNUP"
                            ? Column(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Xác nhận mã pin",
                                          style: Get.textTheme.titleMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  // _buildPinStatus(),

                                  // _buildReenterPinStatus(),

                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Pinput(
                                    length: 6,
                                    controller: reenterPinController,
                                    showCursor: true,
                                    focusNode: reFocusNode,
                                  ),
                                ],
                              )
                            : SizedBox(),
                        const SizedBox(
                          height: 11,
                        ),
                        SizedBox(
                          width: 200,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              formKey.currentState?.validate();
                              if (pinController?.text.length == 6) {
                                if (widget.type != "SIGNIN" &&
                                    (pinController?.text !=
                                        reenterPinController?.text)) {
                                  showAlertDialog(
                                      title: "Lỗi",
                                      content: "Mã pin không trùng khớp");
                                } else {
                                  Get.find<AccountViewModel>().onLogin(
                                    widget.phone,
                                    pinController?.text ?? '213458',
                                    widget.type,
                                    fullName,
                                    _selectedGender,
                                    email!,
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ThemeColor.primary,
                                textStyle: Get.textTheme.titleMedium
                                    ?.copyWith(color: Colors.white)),
                            child: Text("Tạo tài khoản",
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

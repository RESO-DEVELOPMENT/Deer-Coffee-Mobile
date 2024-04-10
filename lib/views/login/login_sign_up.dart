import 'dart:async';

import 'package:deer_coffee/enums/membership_gender.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:deer_coffee/widgets/other_dialogs/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../utils/theme.dart';

class SignUp extends StatefulWidget {
  final String phone;
  final String pinCode;
  final String fullName;
  final String gender;
  final String email;
  final String? referralPhone;

  SignUp({
    required this.phone,
    required this.pinCode,
    required this.fullName,
    required this.gender,
    required this.email,
    this.referralPhone,
  });

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
  String? phoneNumber = '';
  String? pin;
  TextEditingController? pinController = TextEditingController();
  TextEditingController? reenterPinController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _referalPhoneController = TextEditingController();
  String _selectedGender = 'MALE';
  String? downloadURL;
  int? gender;

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
            pinController?.text.length == 4
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: pinController?.text.length == 4 ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            'Mã PIN ${pinController?.text.length == 4 ? 'hợp lệ' : 'không hợp lệ'}',
            style: TextStyle(
              color:
                  pinController?.text.length == 4 ? Colors.green : Colors.grey,
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
            reenterPinController?.text.length == 4
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: reenterPinController?.text.length == 4
                ? Colors.green
                : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            'Re-entered PIN is ${reenterPinController?.text.length == 4 ? 'valid' : 'invalid'}',
            style: TextStyle(
              color: reenterPinController?.text.length == 4
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
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.cancel,
            color: Colors.grey.shade400,
            size: 30,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            children: [
              Expanded(
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
                      "Đăng kí tài khoản",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: ThemeColor.primary,
                              ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.1,
                        vertical: 0.15,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().isEmpty) {
                                  return 'Vui lòng nhập tên';
                                }
                                return null;
                              },
                              controller: _nameController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                hintText: "Tên",
                                hintStyle: Get.textTheme.bodyMedium,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                isDense: true,
                                labelStyle: Get.textTheme.labelLarge,
                                fillColor: Get.theme.colorScheme.background,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Get.theme.colorScheme.onBackground,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _nameController.clear();
                                  },
                                  icon: const Icon(Icons.clear),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: ThemeColor.primary,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: ThemeColor.primary,
                                    width: 2.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: ThemeColor.primary,
                                    width: 2.0,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(16),
                                isCollapsed: true,
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Get.theme.colorScheme.error,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.1,
                        vertical: 15.0,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || !value.isValidEmail) {
                            return 'Vui lòng nhập email hợp lệ';
                          }
                          return null;
                        },
                        controller: _emailController,
                        onChanged: (value) {},
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _nameController.clear();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          hintStyle: Get.textTheme.bodyMedium,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          labelStyle: Get.textTheme.labelLarge,
                          fillColor: Get.theme.colorScheme.background,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: ThemeColor.primary,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: ThemeColor.primary,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: ThemeColor.primary,
                              width: 2.0,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          isCollapsed: true,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Get.theme.colorScheme.error,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.1,
                        vertical: 0.10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
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
                                  if (value == 'MALE') {
                                    gender = MembershipGenderEnum.MALE;
                                  } else if (value == 'FEMALE') {
                                    gender = MembershipGenderEnum.FEMALE;
                                  } else {
                                    gender = MembershipGenderEnum.OTHER;
                                  }
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value == "MALE"
                                          ? "Nam"
                                          : value == "FEMALE"
                                              ? 'Nữ'
                                              : "Khác",
                                      style: Get.textTheme.bodyMedium,
                                    ),
                                  );
                                },
                              ).toList(),
                              decoration: InputDecoration(
                                  hintStyle: Get.textTheme.bodyMedium,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  filled: true,
                                  isDense: true,
                                  prefixIcon: _selectedGender == "ORTHER"
                                      ? const Icon(Icons.person_pin)
                                      : (_selectedGender == "FEMALE"
                                          ? const Icon(Icons.female)
                                          : const Icon(Icons.male)),
                                  labelStyle: Get.textTheme.labelLarge,
                                  fillColor: Get.theme.colorScheme.background,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: ThemeColor.primary,
                                          width: 2.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: ThemeColor.primary,
                                          width: 2.0)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: ThemeColor.primary,
                                          width: 2.0)),
                                  contentPadding: const EdgeInsets.all(16),
                                  isCollapsed: true,
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: Get.theme.colorScheme.error,
                                          width: 2.0))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.1,
                        vertical: 15.0,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (!value!.isPhoneNumber) {
                            return 'Vui lòng nhập số điện thoại hợp lệ';
                          }
                          return null;
                        },
                        controller: _referalPhoneController,
                        onChanged: (value) {},
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Mã giới thiệu',
                          prefixIcon: const Icon(Icons.phone),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _nameController.clear();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          hintStyle: Get.textTheme.bodyMedium,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          labelStyle: Get.textTheme.labelLarge,
                          fillColor: Get.theme.colorScheme.background,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: ThemeColor.primary,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: ThemeColor.primary,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: ThemeColor.primary,
                              width: 2.0,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          isCollapsed: true,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Get.theme.colorScheme.error,
                              width: 2.0,
                            ),
                          ),
                        ),
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
                    const SizedBox(
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
                    const SizedBox(
                      height: 5,
                    ),
                    // _buildPinStatus(),

                    // _buildReenterPinStatus(),

                    // const SizedBox(
                    //   height: 16,
                    // ),
                    Pinput(
                      length: 4,
                      controller: pinController,
                      showCursor: true,
                      focusNode: focusNode,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Xác nhận mã pin",
                                style: Get.textTheme.titleMedium?.copyWith(
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
                          length: 4,
                          controller: reenterPinController,
                          showCursor: true,
                          focusNode: reFocusNode,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    SizedBox(
                      width: 200,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          formKey.currentState?.validate();
                          if (pinController?.text.length == 4) {
                            if ((pinController?.text !=
                                reenterPinController?.text)) {
                              showAlertDialog(
                                  title: "Lỗi",
                                  content: "Mã pin không trùng khớp");
                            } else {
                              Get.find<AccountViewModel>().onSignUp(
                                widget.phone,
                                pinController?.text ?? '213458',
                                _nameController.text,
                                gender?.toInt() ?? 0,
                                _emailController.text,
                                _referalPhoneController.text,
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
            ],
          ),
        ),
      ),
    );
  }
}

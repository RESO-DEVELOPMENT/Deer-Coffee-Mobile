import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:deer_coffee/views/login/login_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../utils/route_constrant.dart';

enum Language {
  Vietnamese,
  English,
}

Language currentLanguage = Language.Vietnamese;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController countrycode = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  void toggleLanguage() {
    if (currentLanguage == Language.Vietnamese) {
      currentLanguage = Language.English;
    } else {
      currentLanguage = Language.Vietnamese;
    }
    setState(() {});
  }

  @override
  void initState() {
    countrycode.text = "+84";
    super.initState();
  }

  // bool isValidPhoneNumber() {
  //   RegExp regex = RegExp('/(84[3|5|7|8|9])+([0-9]{8})\b/g');
  //   return regex.hasMatch(phoneNumber.text);
  // }

  bool isValidPhoneNumber(String input) {
    RegExp regex = RegExp('/([3|5|7|8|9])+([0-9]{8})\b/g');
    if (regex.hasMatch(input)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> phoneKey = GlobalKey<FormState>();
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: phoneKey,
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, // Không cho phép resize khi bàn phím xuất hiện
        body: Stack(
          children: [
            Container(
              height: 240,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/image.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Container(
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Text.rich(
                          TextSpan(children: [
                            TextSpan(
                                text: "Chào mừng bạn đến với ",
                                style: TextStyle(color: Colors.grey)),
                          ]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Deer Coffee",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: ThemeColor.primary,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.15,
                            vertical: 20.0,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: phoneNumber,
                                  maxLengthEnforcement: MaxLengthEnforcement
                                      .truncateAfterCompositionEnds,
                                  enableSuggestions: false,
                                  maxLength: 10,
                                  // onChanged: (value) {
                                  //   phoneKey.currentState?.validate();
                                  // },
                                  onSaved: (value) {
                                    phoneKey.currentState?.validate();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Bạn đang để trống số điện thoại";
                                    } else if (!RegExp(
                                            '(01|02|03|05|07|08|09|01[2|6|8|9])+([0-9]{8})')
                                        .hasMatch(value)) {
                                      return "Số điện thoại không hợp lệ";
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: "Số điện thoại",
                                      hintStyle: Get.textTheme.bodyMedium,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      isDense: true,
                                      labelStyle: Get.textTheme.labelLarge,
                                      fillColor:
                                          Get.theme.colorScheme.background,
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color:
                                            Get.theme.colorScheme.onBackground,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          phoneNumber.text = "";
                                        },
                                        icon: Icon(Icons.clear),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: ThemeColor.primary,
                                              width: 2.0)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: ThemeColor.primary,
                                              width: 2.0)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: ThemeColor.primary,
                                              width: 2.0)),
                                      contentPadding: EdgeInsets.all(16),
                                      isCollapsed: true,
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color:
                                                  Get.theme.colorScheme.error,
                                              width: 2.0))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          // final isPhoneNumberValid = isValidPhoneNumber(phoneNumber.text),
                          width: 240,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeColor.primary,
                              textStyle: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              // Get.toNamed(RouteHandler.OTP);
                              Get.find<AccountViewModel>()
                                  .checkUser(phoneNumber.text);
                            },
                            child: Text('Đăng nhập',
                                style: Get.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        // SizedBox(
                        //   child: InkWell(
                        //     onTap: () {
                        //       toggleLanguage();
                        //     },
                        //     child: Text(
                        //       currentLanguage == Language.Vietnamese
                        //           ? "Tiếng Việt"
                        //           : "English",
                        //       style: const TextStyle(
                        //         fontSize: 16.0,
                        //         color: Colors.black,
                        //         decoration: TextDecoration.underline,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

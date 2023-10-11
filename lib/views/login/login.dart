import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../utils/route_constrant.dart';

enum Language {
  Vietnamese,
  English,
}

Language currentLanguage =
    Language.Vietnamese; // Ngôn ngữ mặc định là Tiếng Việt

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
    setState(() {}); // Cập nhật giao diện
  }

  @override
  void initState() {
    // TODO: implement initState
    countrycode.text = "+84";
    super.initState();
  }

  bool isPhoneNumberValid() {
    // Biểu thức chính quy để kiểm tra số điện thoại
    // Kiểm tra số điện thoại có ít nhất 10 chữ số và chỉ chứa số không chữ
    RegExp regex = RegExp(r'^\d{10}$');
    return regex.hasMatch(phoneNumber.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Hình ảnh làm background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Nội dung trên hình ảnh
          SafeArea(
            child: Column(
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
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 150,
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
                        SizedBox(
                          height: 50,
                          // child: Image.asset("assets/login.png"),
                        ),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                                text: "Chào mừng bạn đến với ",
                                style: TextStyle(color: Colors.grey)),
                          ]),
                        ),
                        SizedBox(
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
                                color: Colors.blue[900],
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50.0,
                            vertical: 30.0,
                          ),
                          child: Container(
                            width: 550,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 40,
                                  child: TextField(
                                    controller: countrycode,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                Text(
                                  "|",
                                  style: TextStyle(
                                    fontSize: 33,
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Nhập số điện thoại",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 385,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(RouteHandler.OTP);
                            },
                            child: Text("Đăng nhập"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 145,
                        ),
                        SizedBox(
                          child: InkWell(
                            onTap: () {
                              toggleLanguage();
                            },
                            child: Text(
                              currentLanguage == Language.Vietnamese
                                  ? "Tiếng Việt"
                                  : "English",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
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

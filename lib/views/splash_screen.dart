import 'package:deer_coffee/utils/route_constrant.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'root_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 2), () {
    //   Get.offAllNamed(RouteHandler.HOME);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 200.0,
              width: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}

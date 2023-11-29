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
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 140.0,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

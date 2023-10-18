import 'package:deer_coffee/views/available_rewards.dart';
import 'package:deer_coffee/views/cart.dart';
import 'package:deer_coffee/views/delivering.dart';
import 'package:deer_coffee/views/drips.dart';
import 'package:deer_coffee/views/notification.dart';
import 'package:deer_coffee/views/order_determination.dart';
import 'package:deer_coffee/views/reward.dart';
import 'package:deer_coffee/views/store.dart';
import 'package:deer_coffee/views/t.dart';
import 'package:deer_coffee/views/voucher.dart';
import 'package:deer_coffee/views/voucher_login.dart';
import 'package:deer_coffee/views/voucher_qr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/route_constrant.dart';
import 'views/login/login.dart';
import 'views/not_found_screen.dart';
import 'views/root_screen.dart';
import 'views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Deer Coffee',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF2182F2),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      themeMode: ThemeMode.light,
      // getPages: [
      //   GetPage(
      //       name: RouteHandler.WELCOME,
      //       page: () => SplashScreen(),
      //       transition: Transition.zoom),
      //   GetPage(
      //       name: RouteHandler.LOGIN,
      //       page: () => LoginScreen(),
      //       transition: Transition.zoom),
      //   GetPage(
      //       name: RouteHandler.HOME,
      //       page: () => RootScreen(),
      //       transition: Transition.cupertino),
      // ],
      // initialRoute: RouteHandler.WELCOME,
      // unknownRoute:
      //     GetPage(name: RouteHandler.NOT_FOUND, page: () => NotFoundScreen()),
      home: Reward(
        
      ),
    );
  }
}

import 'package:deer_coffee/views/login/login_otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:deer_coffee/views/cart.dart';
import 'package:deer_coffee/views/home_page.dart';
import 'package:deer_coffee/views/home_page_order_method.dart';
import 'package:deer_coffee/views/order_confirmation.dart';
import 'package:deer_coffee/views/order_determination.dart';
import 'package:deer_coffee/views/available_rewards.dart';
import 'package:deer_coffee/views/cart.dart';
import 'package:deer_coffee/views/delivering.dart';
import 'package:deer_coffee/views/drips.dart';
import 'package:deer_coffee/views/notification.dart';
import 'package:deer_coffee/views/order_determination.dart';
import 'package:deer_coffee/views/reward.dart';
import 'package:deer_coffee/views/store.dart';

import 'package:deer_coffee/views/voucher.dart';
import 'package:deer_coffee/views/voucher_login.dart';
import 'package:deer_coffee/views/voucher_qr.dart';
import 'package:deer_coffee/views/reward_coffee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'setup.dart';
import 'utils/route_constrant.dart';
import 'views/login/login.dart';
import 'views/not_found_screen.dart';
import 'views/root_screen.dart';
import 'views/splash_screen.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  createRouteBindings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Deer Coffee',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF2182F2),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      themeMode: ThemeMode.light,
      getPages: [
        GetPage(
            name: RouteHandler.WELCOME,
            page: () => SplashScreen(),
            transition: Transition.zoom),
        GetPage(
            name: RouteHandler.LOGIN,
            page: () => LoginScreen(),
            transition: Transition.zoom),
        GetPage(
            name: RouteHandler.OTP,
            page: () => MyOtp(),
            transition: Transition.zoom),
        GetPage(
            name: RouteHandler.HOME,
            page: () => RootScreen(),
            transition: Transition.cupertino),
      ],
      initialRoute: RouteHandler.WELCOME,
      unknownRoute:
          GetPage(name: RouteHandler.NOT_FOUND, page: () => NotFoundScreen()),
      home: SplashScreen(),
    );
  }
}

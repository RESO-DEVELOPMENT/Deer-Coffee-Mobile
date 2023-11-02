import 'dart:io';

import 'package:deer_coffee/views/cart.dart';
import 'package:deer_coffee/views/category_detail.dart';
import 'package:deer_coffee/views/collection_detail.dart';
import 'package:deer_coffee/views/order_history.dart';
import 'package:deer_coffee/views/login/login_otp.dart';
import 'package:deer_coffee/views/order_details.dart';
import 'package:deer_coffee/views/product_details.dart';
import 'package:deer_coffee/views/promotion_details.dart';
import 'package:deer_coffee/views/voucher.dart';
import 'package:deer_coffee/views/voucher_details.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'setup.dart';
import 'utils/request.dart';
import 'utils/route_constrant.dart';
import 'views/login/login.dart';
import 'views/not_found_screen.dart';
import 'views/root_screen.dart';
import 'views/splash_screen.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

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
        colorSchemeSeed: const Color(0xff8FBEFF),
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
            page: () => RootScreen(
                  idx: int.parse(Get.parameters['idx'] ?? '0'),
                ),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.CART,
            page: () => CartScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.VOUCHER,
            page: () => Voucher(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.ORDER,
            page: () => OrderHistory(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.PRODUCT_DETAIL,
            page: () => Option(
                  id: Get.parameters['id'] ?? '',
                ),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.VOUCHER_DETAIL,
            page: () => VoucherDetails(
                  id: Get.parameters['id'] ?? '',
                ),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.PROMOTION_DETAILS,
            page: () => PromotionDetailsScreen(
                  id: Get.parameters['id'] ?? '',
                ),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.ORDER_DETAILS,
            page: () => OrderDetails(
                  id: Get.parameters['id'] ?? '',
                ),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.CATEGORY_DETAIL,
            page: () => CategoryDetailsScreen(
                  id: Get.parameters['id'] ?? '',
                ),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.COLLECTION_DETAIL,
            page: () => CollectionDetailsScreen(
                  id: Get.parameters['id'] ?? '',
                ),
            transition: Transition.cupertino),
      ],
      initialRoute: RouteHandler.WELCOME,
      unknownRoute:
          GetPage(name: RouteHandler.NOT_FOUND, page: () => NotFoundScreen()),
      home: SplashScreen(),
    );
  }
}

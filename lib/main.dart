import 'dart:io';

import 'package:deer_coffee/views/cart.dart';
import 'package:deer_coffee/views/home_screen/blog_details.dart';
import 'package:deer_coffee/views/login/login_otp.dart';
import 'package:deer_coffee/views/login/login_sign_up.dart';
import 'package:deer_coffee/views/membership_screen/promotion_details.dart';
import 'package:deer_coffee/views/membership_screen/voucher.dart';
import 'package:deer_coffee/views/membership_screen/voucher_details.dart';
import 'package:deer_coffee/views/orders_screen/category_detail.dart';
import 'package:deer_coffee/views/orders_screen/collection_detail.dart';
import 'package:deer_coffee/views/orders_screen/product_detail_1.dart';
import 'package:deer_coffee/views/orders_screen/product_details.dart';
import 'package:deer_coffee/views/policy-page.dart';
import 'package:deer_coffee/views/profile_screen/order_details.dart';
import 'package:deer_coffee/views/profile_screen/order_history.dart';
import 'package:deer_coffee/views/profile_screen/transaction_details.dart';
import 'package:deer_coffee/views/profile_screen/transaction_history.dart';
import 'package:deer_coffee/views/qr_screen/qr_screen.dart';
import 'package:deer_coffee/views/stores_screen/store.dart';
import 'package:deer_coffee/views/stores_screen/store_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

import 'setup.dart';
import 'utils/request.dart';
import 'utils/route_constrant.dart';
import 'views/login/login.dart';
import 'views/not_found_screen.dart';
import 'views/root_screen.dart';
import 'views/splash_screen.dart';

Future<void> main() async {
  if (!GetPlatform.isWeb) {
    HttpOverrides.global = MyHttpOverrides();
  }
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  setPathUrlStrategy();
  createRouteBindings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Deer Coffee',
      color: Colors.white,
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff8FBEFF),
          scaffoldBackgroundColor: Color(0xffF9F9F9),
          brightness: Brightness.light,
          fontFamily: 'Inter'),
      themeMode: ThemeMode.light,
      getPages: [
        GetPage(
            name: RouteHandler.WELCOME,
            page: () => const SplashScreen(),
            transition: Transition.zoom),
        GetPage(
            name: RouteHandler.LOGIN,
            page: () => const LoginScreen(),
            transition: Transition.zoom),
        GetPage(
            name: RouteHandler.OTP,
            page: () => MyOtp(
                  phone: Get.parameters['phone'] ?? '',
                  pinCode: Get.parameters['pinCode'] ?? '',
                ),
            transition: Transition.zoom),
        GetPage(
            name: RouteHandler.SIGN_UP,
            page: () => SignUp(
                  phone: Get.parameters['phone'] ?? '',
                  pinCode: Get.parameters['pinCode'] ?? '',
                  fullName: Get.parameters['fullName'] ?? '',
                  gender: Get.parameters['gender'] ?? '',
                  email: Get.parameters['email'] ?? '',
                  referralPhone: Get.parameters['referalPhone'] ?? '',
                ),
            transition: Transition.zoom),
        GetPage(
            name: RouteHandler.HOME,
            page: () => RootScreen(
                  idx: int.parse(Get.parameters['idx'] ?? '0'),
                ),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.CART,
            page: () => const CartScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.VOUCHER,
            page: () => const Voucher(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.ORDER,
            page: () => const OrderHistory(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.TRANSACTIONS,
            page: () => const TransactionsHistory(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.PRODUCT_DETAIL,
            page: () => Option(
                  id: Get.parameters['id'] ?? '',
                ),
            transition: Transition.cupertino),
        // em code thu
        GetPage(
            name: RouteHandler.PRODUCT_DETAIL_1,
            page: () => ProductDetail(
                  id: Get.parameters['id'] ?? '',
                ),
            transition: Transition.cupertino),
        //
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
        GetPage(
            name: RouteHandler.BLOG,
            page: () => BannerDetailScreen(
                  id: Get.parameters['id'] ?? '',
                ),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.STORE,
            page: () => StoreDetailScreen(
                  id: Get.parameters['id'] ?? '',
                ),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.POLICY,
            page: () => const PolicyPage(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.QR,
            page: () => const QrScreen(),
            transition: Transition.downToUp),
        GetPage(
            name: RouteHandler.STORES,
            page: () => const Store(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteHandler.Transaction_Detail,
            page: () => TransactionDetails(
                  id: Get.parameters['id'] ?? '',
                ),
            transition: Transition.cupertino),
      ],
      initialRoute: RouteHandler.WELCOME,
      unknownRoute: GetPage(
          name: RouteHandler.NOT_FOUND, page: () => const NotFoundScreen()),
      home: const SplashScreen(),
    );
  }
}

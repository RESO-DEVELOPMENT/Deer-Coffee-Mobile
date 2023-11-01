import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:deer_coffee/view_models/product_view_model.dart';
import 'package:get/get.dart';

import 'view_models/cart_view_model.dart';
import 'view_models/order_view_model.dart';
import 'view_models/startup_view_model.dart';

void createRouteBindings() {
  Get.put(StartUpViewModel());
  Get.put(MenuViewModel());
  Get.put(AccountViewModel());
  Get.put(CartViewModel());
  Get.put(OrderViewModel());
}

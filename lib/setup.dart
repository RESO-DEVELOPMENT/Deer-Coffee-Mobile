import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:get/get.dart';

import 'view_models/startup_view_model.dart';

void createRouteBindings() {
  Get.put(StartUpViewModel());
  Get.put(MenuViewModel());
  Get.put(AccountViewModel());
}

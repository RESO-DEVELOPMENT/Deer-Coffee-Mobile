import 'package:deer_coffee/api/account_api.dart';
import 'package:get/get.dart';

import '../utils/route_constrant.dart';
import 'base_view_model.dart';
import 'cart_view_model.dart';
import 'menu_view_model.dart';

class StartUpViewModel extends BaseViewModel {
  StartUpViewModel() {
    handleStartUpLogic();
  }
  Future handleStartUpLogic() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.find<MenuViewModel>().getMenuOfBrand();
    Get.find<MenuViewModel>().getListStore();
    Get.find<MenuViewModel>().getListBlog();
    Get.find<CartViewModel>().getListPromotion();
    await Future.delayed(const Duration(seconds: 2));
    await Get.offAllNamed(RouteHandler.HOME);
  }
}

import 'package:deer_coffee/utils/share_pref.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/route_constrant.dart';
import 'base_view_model.dart';
import 'menu_view_model.dart';

class StartUpViewModel extends BaseViewModel {
  StartUpViewModel() {
    handleStartUpLogic();
  }
  Future handleStartUpLogic() async {
    if (GetPlatform.isWeb && (GetPlatform.isAndroid || GetPlatform.isIOS)) {
      final appId = GetPlatform.isIOS ? '6476899403' : 'com.reso.deercoffee';
      final url = Uri.parse(GetPlatform.isIOS
          ? "https://apps.apple.com/us/app/deer-coffee/id$appId"
          : "https://play.google.com/store/apps/details?id=$appId");
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
    await Future.delayed(const Duration(seconds: 1));

    String? userId = await getUserId();
    if (userId != null) {
      await Get.find<AccountViewModel>().getMembershipInfo(userId);
    }
    await Get.find<MenuViewModel>().getListStore();
    await Get.find<MenuViewModel>().getMenuOfBrand();
    await Get.offAllNamed(RouteHandler.HOME);
  }
}

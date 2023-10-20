import '../models/menu.dart';
import '../utils/request.dart';

class MenuAPI {
  Future<Menu?> getBrandMenu() async {
    final res = await request
        .get('brands/menus', queryParameters: {'brandCode': "DeerCoffee"});
    var jsonList = res.data;
    Menu menu = Menu.fromJson(jsonList);
    return menu;
  }
}

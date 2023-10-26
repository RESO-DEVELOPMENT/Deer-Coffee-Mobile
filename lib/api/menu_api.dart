import 'package:deer_coffee/models/store.dart';

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

  Future<List<StoreModel>> getListStore() async {
    var params = <String, dynamic>{
      'brandCode': 'DeerCoffee',
      'page': 1,
      'size': 20,
    };
    final res = await request.get('brands/stores', queryParameters: params);
    var jsonList = res.data['items'];
    List<StoreModel> stores = StoreModel.fromList(jsonList);

    return stores;
  }
}

import 'package:deer_coffee/models/blog.dart';
import 'package:deer_coffee/models/store.dart';

import '../models/menu.dart';
import '../utils/request.dart';

class MenuAPI {
  Future<Menu?> getBrandMenu(String id) async {
    final res = await request.get(
      'users/stores/$id/menu',
    );
    var jsonList = res.data;
    Menu menu = Menu.fromJson(jsonList);
    return menu;
  }

  Future<List<StoreModel>> getListStore() async {
    var params = <String, dynamic>{
      'brandCode': 'DEERCOFFEE',
      'page': 1,
      'size': 20,
    };
    final res = await request.get('brands/stores', queryParameters: params);
    var jsonList = res.data['items'];
    List<StoreModel> stores = StoreModel.fromList(jsonList);

    return stores;
  }

  Future<List<BlogModel>> getListBlog() async {
    var params = <String, dynamic>{
      'brandCode': 'DEERCOFFEE',
      'page': 1,
      'size': 20,
    };
    final res = await request.get('users/blog', queryParameters: params);
    var jsonList = res.data['items'];
    List<BlogModel> stores = BlogModel.fromList(jsonList);

    return stores;
  }
}

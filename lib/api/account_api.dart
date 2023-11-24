import 'package:deer_coffee/models/user.dart';

import '../models/user_create.dart';
import '../utils/request.dart';
import '../utils/share_pref.dart';

class AccountAPI {
  Future<bool> isUserLoggedIn() async {
    final isExpireToken = await expireToken();
    final token = await getToken();
    if (isExpireToken) return false;
    if (token != null) requestObj.setToken = token;
    return token != null;
  }

  Future<UserModel?> signUp(UserUpdate user) async {
    final res = await request.post('users/sign-up',
        queryParameters: {'brandCode': "DeerCoffee"}, data: user.toJson());
    var json = res.data;
    UserModel userInfo = UserModel.fromJson(json);
    return userInfo;
  }

  Future<UserModel?> signIn(String token) async {
    final res = await request.post('users/sign-in',
        data: {"token": token, 'brandCode': "DeerCoffee"});
    var json = res.data;
    UserModel userInfo = UserModel.fromJson(json);
    return userInfo;
  }

  Future<UserDetails> getUserById(String id) async {
    final res = await request.get('users/$id');
    var json = res.data;
    UserDetails userInfo = UserDetails.fromJson(json);
    return userInfo;
  }

  Future<dynamic> updateUser(String id, UserUpdate update) async {
    final res = await request.patch('users/$id', data: update.toJson());
    var json = res.data;
    return json;
  }
}

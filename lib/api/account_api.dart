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

  Future<UserModel?> signUp(UserCreate user) async {
    final res = await request.post('users/sign-up',
        queryParameters: {'brandCode': "DeerCoffee"}, data: user.toJson());
    var json = res.data;
    UserModel userInfo = UserModel.fromJson(json);
    return userInfo;
  }

  Future<UserModel?> signIn(String phoneNumber, String uid) async {
    final res = await request
        .post('users/sign-in', data: {"phoneNumber": phoneNumber, "uid": uid});
    var json = res.data;
    UserModel userInfo = UserModel.fromJson(json);
    return userInfo;
  }
}

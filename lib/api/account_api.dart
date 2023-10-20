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
}

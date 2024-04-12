import 'package:deer_coffee/models/pointify/membership_transaction.dart';

import '../../models/pointify/membership_info.dart';
import '../../models/pointify/promotion_model.dart';
import '../../utils/request.dart';
import '../../utils/request_pointify.dart';

class PointifyData {
  Future<List<PromotionPointify>> getListPromotionOfPointify(
      String userId) async {
    final res = await request.get(
      'users/$userId/promotions?brandCode=DEERCOFFEE',
    );
    var jsonList = res.data;
    List<PromotionPointify> listPromotion =
        PromotionPointify().fromList(jsonList);

    return listPromotion;
  }

  Future<MembershipInfo?> getMembershipInfo(String id) async {
    final res = await requestPointify.get('memberships/$id');
    var json = res.data;
    MembershipInfo memberInfo = MembershipInfo.fromJson(json);
    return memberInfo;
  }

  Future<List<MembershipTransaction>>? getListTransactionOfUser(
    String userId,
  ) async {
    var params = <String, dynamic>{'page': 1, 'size': 100};
    final res = await requestPointify.get('memberships/$userId/transactions',
        queryParameters: params);
    var jsonList = res.data['items'];

    return MembershipTransaction().fromList(jsonList);
  }
}

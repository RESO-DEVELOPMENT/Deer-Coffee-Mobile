import '../../models/pointify/promotion_model.dart';
import '../../utils/request.dart';

class PointifyData {
  Future<List<PromotionPointify>> getListPromotionOfPointify(
      String userId) async {
    final res = await request.get(
      'users/$userId/promotions?brandCode=DeerCoffee',
    );
    var jsonList = res.data;
    List<PromotionPointify> listPromotion =
        PromotionPointify().fromList(jsonList);

    return listPromotion;
  }
}

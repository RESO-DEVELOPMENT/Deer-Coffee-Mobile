import 'package:deer_coffee/models/pointify/promotion_details_model.dart';

import '../../models/pointify/promotion_model.dart';
import '../../utils/request.dart';

class PointifyData {
  Future<List<PromotionPointify>> getListPromotionOfPointify() async {
    final res = await pointifyRequest.get(
      'channels/list-promotions?brandCode=DeerCoffee&ChannelType=2',
    );
    var jsonList = res.data;
    List<PromotionPointify> listPromotion =
        PromotionPointify().fromList(jsonList);

    return listPromotion;
  }

  Future<PromotionDetailsModel> getPromotionDetailsById(String id) async {
    final res = await pointifyRequest.get(
      'promotions/$id',
    );
    var jsonList = res.data;
    PromotionDetailsModel promotionDetailsModel =
        PromotionDetailsModel.fromJson(jsonList);

    return promotionDetailsModel;
  }
}

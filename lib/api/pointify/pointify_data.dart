import 'package:deer_coffee/models/pointify/check_promotion_model.dart';
import 'package:deer_coffee/models/pointify/membership_model.dart';
import 'package:deer_coffee/models/pointify/promotion_details_model.dart';
import 'package:dio/dio.dart';

import '../../models/pointify/promotion_model.dart';
import '../../utils/request.dart';

class PointifyData {
  Future<List<PromotionPointify>> getListPromotionOfPointify() async {
    final res = await request.get(
      'users/promotions?brandCode=DeerCoffee',
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

  Future<MemberShipModel> getMembershipDetails(String id) async {
    final res = await pointifyRequest.get(
      'memberships/$id',
    );
    var jsonList = res.data;
    MemberShipModel memberShipModel = MemberShipModel.fromJson(jsonList);

    return memberShipModel;
  }

  Future<CheckPromotionModel> checkPromotion(
      CustomerOrderInfo checkPromotionModel) async {
    final res = await pointifyRequest.post('promotions/store/check-promotion',
        data: checkPromotionModel.toJson());
    var jsonList = res.data;
    CheckPromotionModel model = CheckPromotionModel.fromJson(jsonList);
    return model;
  }
}

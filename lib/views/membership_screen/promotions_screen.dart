import 'package:barcode_widget/barcode_widget.dart';
import 'package:deer_coffee/enums/view_status.dart';

import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/views/drips.dart';
import 'package:deer_coffee/views/reward.dart';
import 'package:deer_coffee/views/reward_coffee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/user.dart';
import '../../utils/format.dart';
import '../../utils/route_constrant.dart';
import '../../utils/theme.dart';
import '../../widgets/promotion_widget.dart';
import '../login/login_card.dart';

class PromotionsScreen extends StatefulWidget {
  const PromotionsScreen({Key? key}) : super(key: key);

  @override
  State<PromotionsScreen> createState() => _PromotionsScreenState();
}

class _PromotionsScreenState extends State<PromotionsScreen> {
  @override
  void initState() {
    Get.find<CartViewModel>().getListPromotion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ScopedModel<AccountViewModel>(
              model: Get.find<AccountViewModel>(),
              child: ScopedModelDescendant<AccountViewModel>(
                  builder: (context, build, model) {
                if (model.status == ViewStatus.Loading) {
                  return SizedBox(
                      width: Get.width,
                      height: 280,
                      child: const Center(child: CircularProgressIndicator()));
                }

                if (model.memberShipModel == null) {
                  return const LoginCard();
                }
                return Container(
                  width: Get.width,
                  height: 180,
                  decoration: BoxDecoration(
                    color: ThemeColor.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 60, 8, 8),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hạng thành viên',
                                      style: Get.textTheme.bodyMedium?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Text(model.memberShipModel?.level?.name ?? '',
                                      style: Get.textTheme.bodyLarge?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed(RouteHandler.VOUCHER);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      const Icon(
                                        Icons.confirmation_number,
                                        color: Colors.blueAccent,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'Khuyến mãi',
                                        style: Get.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: Colors.blueAccent),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:
                                model.memberShipModel!.level!.memberWallet!
                                    .map((e) => Text(
                                          '${e.walletType?.name ?? ''}: ${formatPrice(e.balance ?? 0)}',
                                          style: Get.textTheme.titleMedium
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                        ))
                                    .toList()),
                      ],
                    ),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(4),
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.card_membership_outlined,
                                        color: ThemeColor.primary,
                                        size: 40,
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 10),
                                    child: Text('Hạng thành viên',
                                        style: Get.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.white,
                            ),
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.card_giftcard_outlined,
                                        color: ThemeColor.primary,
                                        size: 40,
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 10),
                                    child: Text('Đổi điểm',
                                        style: Get.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ScopedModel<CartViewModel>(
              model: Get.find<CartViewModel>(),
              child: ScopedModelDescendant<CartViewModel>(
                  builder: (context, build, model) {
                if (model.status == ViewStatus.Loading) {
                  return SizedBox(
                      width: Get.width,
                      height: 200,
                      child: Center(child: CircularProgressIndicator()));
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Khuyến mãi khả dụng',
                          style: Get.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Column(
                      children: model.promotionsUsingPromotionCode!
                          .map((e) => buildTicketWidget(
                              e,
                              model.cart.promotionCode == e.promotionCode,
                              model))
                          .toList(),
                    ),
                  ],
                );
              }),
            ),

            // Add more TicketWidgets as needed
          ],
        ),
      ),
    );
  }

  Widget buildUtilityWidget(String title) {
    return GestureDetector(
      onTap: () {
        if (title == "Lịch sử BEAN") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RewardCoffee(),
            ),
          );
        } else if (title == "Hạng thành viên") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Reward(),
            ),
          );
        } else if (title == "Đổi Bean") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Drip(),
            ),
          );
        }
      },
      child: Container(
        height: 80,
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Get.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

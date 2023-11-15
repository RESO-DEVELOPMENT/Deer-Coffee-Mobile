import 'package:barcode_widget/barcode_widget.dart';
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/pointify/membership_model.dart';
import 'package:deer_coffee/models/pointify/promotion_model.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/views/drips.dart';
import 'package:deer_coffee/views/reward.dart';
import 'package:deer_coffee/views/reward_coffee.dart';
import 'package:deer_coffee/views/membership_screen/voucher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/user.dart';
import '../../utils/format.dart';
import '../../utils/route_constrant.dart';
import '../../widgets/promotion_widget.dart';
import '../login/login.dart';
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
                  return Container(
                      width: Get.width,
                      height: 200,
                      child: Center(child: CircularProgressIndicator()));
                }

                List<Wallets> wallet = model.memberShipModel?.wallets ?? [];
                if (model.memberShipModel == null) {
                  return LoginCard();
                }
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/tree1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
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
                                  Text(
                                      model.memberShipModel?.level?.name ??
                                          'Bronze',
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
                                      Icon(
                                        Icons.confirmation_number,
                                        color: Colors.blueAccent,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'Voucher của tôi',
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: model.memberShipModel!.wallets!
                                .map((e) => Text(
                                      '${e.name ?? ''}: ${(e.name ?? '') == "Số dư" ? formatPrice(e.balance ?? 0) : formatPriceWithoutUnit(e.balance ?? 0)}',
                                      style: Get.textTheme.bodyLarge?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ))
                                .toList()),
                        Card(
                          child: Container(
                            height: 100,
                            width: Get
                                .width, // Chỉnh độ cao của container chứa ảnh
                            padding:
                                const EdgeInsets.all(16), // Loại bỏ padding
                            child: BarcodeWidget(
                                barcode: Barcode.code128(),
                                drawText: false,
                                data: model.memberShipModel?.phoneNumber ?? '',
                                style: Get.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                          ),
                        ),
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
                    children: [
                      Expanded(child: buildUtilityWidget("Hạng thành viên")),
                      Expanded(child: buildUtilityWidget("Đổi Bean")),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildUtilityWidget("Lịch sử BEAN"),
                      ),
                      Expanded(child: buildUtilityWidget("Quyền lợi của bạn")),
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
                      children: model.promotions!
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
          children: <Widget>[
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

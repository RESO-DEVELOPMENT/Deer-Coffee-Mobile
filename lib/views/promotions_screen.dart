import 'package:barcode_widget/barcode_widget.dart';
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/pointify/membership_model.dart';
import 'package:deer_coffee/models/pointify/promotion_model.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/views/drips.dart';
import 'package:deer_coffee/views/reward.dart';
import 'package:deer_coffee/views/reward_coffee.dart';
import 'package:deer_coffee/views/voucher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';

import '../utils/route_constrant.dart';
import '../widgets/promotion_widget.dart';
import 'login/login.dart';

class PromotionsScreen extends StatefulWidget {
  const PromotionsScreen({Key? key}) : super(key: key);

  @override
  State<PromotionsScreen> createState() => _PromotionsScreenState();
}

class _PromotionsScreenState extends State<PromotionsScreen> {
  @override
  void initState() {
    Get.find<AccountViewModel>().getMembershipInfo();
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
                  return CircularProgressIndicator();
                }

                List<MemberWallet> wallet =
                    model.memberShipModel?.memberWallet ?? [];
                if (model.memberShipModel == null) {
                  return loginCard();
                }
                return Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/tree1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 55,
                    ),
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
                                      style: Get.textTheme.bodyLarge?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      model.memberShipModel?.memberLevel
                                              ?.name ??
                                          'Bronze',
                                      style: Get.textTheme.titleLarge?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Voucher(), // Replace with your OrderMethod page
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.confirmation_number,
                                        color: Colors.lightBlue,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'Voucher của tôi',
                                        style: TextStyle(
                                          color: Colors.lightBlue,
                                        ),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: wallet
                                .map(
                                  (e) => Text("${e.name} :${e.balance} ",
                                      style: Get.textTheme.titleMedium
                                          ?.copyWith(color: Colors.white)),
                                )
                                .toList()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 400,
                            child: Card(
                              child: Container(
                                height: 120,
                                width: Get.width *
                                    0.9, // Chỉnh độ cao của container chứa ảnh
                                padding:
                                    const EdgeInsets.all(8), // Loại bỏ padding
                                child: BarcodeWidget(
                                    barcode: Barcode.code128(),
                                    data: model.memberShipModel?.phoneNumber ??
                                        '000000000000',
                                    style: Get.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
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
                  return CircularProgressIndicator();
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
                          .map((e) => buildTicketWidget(e))
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

  Widget loginCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 110, 8, 16),
      padding: const EdgeInsets.all(8),
      width: Get.width * 0.9,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Đăng nhập',
            style: Get.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Sử dụng app để tích điểm và đổi những ưu đãi chỉ dành riêng cho thành viên bạn nhé !',
            style: Get.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/hinhchunhat.png',
                height: 100,
                width: 329,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: -15,
                child: Container(
                  width: Get.width * 0.6,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment(-1, -1.133),
                      end: Alignment(1, 1.367),
                      colors: <Color>[Colors.blueAccent, Color(0xffc8ddff)],
                      stops: <double>[0.014, 1],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(RouteHandler.LOGIN);
                    },
                    child: Text('Đăng nhập',
                        textAlign: TextAlign.center,
                        style: Get.textTheme.bodyLarge
                            ?.copyWith(color: Colors.white)),
                  ),
                ),
              ),
              Positioned(
                top: 80,
                child: Container(
                  width: Get.width * 0.6,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment(-1, -1.133),
                      end: Alignment(1, 1.367),
                      colors: <Color>[Colors.blueAccent, Color(0xffc8ddff)],
                      stops: <double>[0.014, 1],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Deer Coffee Reward',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffffffff),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            clipBehavior: Clip.none,
          ),
        ],
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

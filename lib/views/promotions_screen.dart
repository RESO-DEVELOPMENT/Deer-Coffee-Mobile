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
                return Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/tree1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 55, left: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Hạng thành viên',
                                      style: Get.textTheme.bodyLarge?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                      model.memberShipModel?.memberLevel
                                              ?.name ??
                                          'Bronze',
                                      style: Get.textTheme.titleLarge?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
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
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: wallet
                                  .map(
                                    (e) => Text("${e.name} :${e.balance} ",
                                        style: Get.textTheme.titleMedium
                                            ?.copyWith(color: Colors.white)),
                                  )
                                  .toList()),
                        ),
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
                                    const EdgeInsets.all(16), // Loại bỏ padding
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
                  Text(
                    "Tiện ích",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Phần thưởng khả dụng',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  Widget buildTicketWidget(PromotionPointify promotion) {
    return InkWell(
      onTap: () {
        Get.toNamed(
            "${RouteHandler.PROMOTION_DETAILS}?id=${promotion.promotionId}");
      },
      child: Container(
        width: double.infinity,
        height: 127.0,
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CustomPaint(
              size: const Size(120.0, 120.0),
              painter: TicketPainter(),
              foregroundPainter: DotPainter(),
              child: Image.network(
                width: 120.0,
                height: 120.0,
                'https://i.imgur.com/X0WTML2.jpg',
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(promotion.promotionName ?? '',
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    Text(promotion.promotionCode ?? '',
                        style: Get.textTheme.bodySmall),
                    Text('txt', style: Get.textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Custom ticket drawing code here
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Color(0xFFF5F5F5);
    final double dotSpacing = 15.0;
    final double edgeDotSpacing = 30.0;
    final double leftOffset = 120.0;
    final double bottomOffset = size.height - 25.0;

    for (int i = 0; i < 10; i++) {
      double y = i * dotSpacing;

      if (i == 0 || i == 8) {
        canvas.drawCircle(Offset(leftOffset, y), 10.0, paint);
      } else if (i == 1 || i == 8) {
        canvas.drawCircle(Offset(leftOffset, y), 3.0, paint);
      } else {
        canvas.drawCircle(Offset(leftOffset, y), 3.0, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

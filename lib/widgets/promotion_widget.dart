import 'package:deer_coffee/models/pointify/membership_info.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/pointify/promotion_model.dart';
import '../utils/format.dart';
import '../utils/route_constrant.dart';
import '../utils/theme.dart';
import '../view_models/account_view_model.dart';

Widget buildTicketWidget(
    PromotionPointify promotion, bool isSelected, CartViewModel model) {
  String? selectedCode;
  MembershipInfo? info = Get.find<AccountViewModel>().memberShipModel;
  if (promotion.promotionType == 3) {
    selectedCode =
        '${info?.phoneNumber}_${promotion.promotionCode}_${promotion.listVoucher?.first.voucherCode ?? ''}';
  } else {
    selectedCode = '${info?.phoneNumber}_${promotion.promotionCode}';
  }
  return InkWell(
    onTap: () {
      Get.toNamed(
          "${RouteHandler.PROMOTION_DETAILS}?id=${promotion.promotionId}");
    },
    child: Container(
      width: double.infinity,
      margin: const EdgeInsets.all(4),
      height: 120,
      decoration: BoxDecoration(
        color: isSelected ? ThemeColor.primary : Colors.white,
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
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              width: 120.0,
              height: 120.0,
              promotion.imgUrl ?? 'https://i.imgur.com/X0WTML2.jpg',
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(promotion.promotionName ?? '',
                      style: Get.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  Text(promotion.promotionCode ?? '',
                      style: Get.textTheme.labelSmall?.copyWith(
                          color: isSelected ? Colors.white : Colors.black)),
                  Text(
                      "SL :${promotion.promotionType == 3 ? promotion.currentVoucherQuantity : "Không giới hạn"}",
                      style: Get.textTheme.labelSmall?.copyWith(
                          color: isSelected ? Colors.white : Colors.black)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          "HSD:${formatOnlyDate(promotion.endDate ?? "2025-01-01T00:00:00")}",
                          style: Get.textTheme.labelSmall?.copyWith(
                              color: isSelected ? Colors.white : Colors.black)),
                      TextButton(
                          onPressed: () {
                            if (isSelected) {
                              model.removePromotion();
                              Get.back();
                            } else {
                              model.selectPromotion(selectedCode ?? '',
                                  promotion.promotionType ?? 2);
                              Get.back();
                            }
                          },
                          child: Text(
                            isSelected ? "Huỷ" : "Sử dụng",
                            style: Get.textTheme.bodyMedium?.copyWith(
                                color: isSelected
                                    ? Colors.white
                                    : ThemeColor.primary),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
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

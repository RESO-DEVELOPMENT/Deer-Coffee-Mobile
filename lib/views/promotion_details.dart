import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/pointify/promotion_details_model.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/utils/route_constrant.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class PromotionDetailsScreen extends StatefulWidget {
  final String id;
  const PromotionDetailsScreen({super.key, required this.id});

  @override
  State<PromotionDetailsScreen> createState() => _PromotionDetailsScreenState();
}

class _PromotionDetailsScreenState extends State<PromotionDetailsScreen> {
  PromotionDetailsModel? promotionDetailsModel;
  @override
  void initState() {
    Get.find<CartViewModel>()
        .getPromotionDetailsById(widget.id)
        .then((value) => {
              promotionDetailsModel = value,
              print(promotionDetailsModel?.promotionName ?? 'asdas')
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScopedModel<CartViewModel>(
        model: Get.find<CartViewModel>(),
        child: ScopedModelDescendant<CartViewModel>(
            builder: (context, build, model) {
          if (model.status == ViewStatus.Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              Container(
                color: Colors.grey,
                width: double.infinity,
                height: double.infinity,
              ),
              SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: Color(0xFFF5F5F5),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.grey,
                                    size: 32,
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                            // Create the ticket-like UI
                            Container(
                              width: Get.width * 0.8,
                              height: Get.height * 0.75,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .center, // Để căn giữa theo chiều ngang
                                children: [
                                  Text(
                                    'Deer Coffee',
                                    style: Get.textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    promotionDetailsModel?.promotionName ?? '',
                                    style: Get.textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                  CustomPaint(
                                    size: const Size(500,
                                        12), // Điều chỉnh kích thước của đường kẻ
                                    painter: DotPainter(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: QrImageView(
                                      data: promotionDetailsModel
                                              ?.promotionCode ??
                                          '',
                                      version: QrVersions.auto,
                                      size: 180.0,
                                    ),
                                  ),
                                  Text(
                                    promotionDetailsModel?.promotionCode ?? "",
                                    style: Get.textTheme.bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                          text: promotionDetailsModel
                                                  ?.promotionCode ??
                                              ''));
                                      Get.snackbar("Đã sao chép",
                                          '${promotionDetailsModel?.promotionCode}');
                                    },
                                    child: Text(
                                      'Sao chép',
                                      style: Get.textTheme.bodyMedium?.copyWith(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (model.cart.promotionCode ==
                                            promotionDetailsModel!
                                                .promotionCode!) {
                                          model.removePromotion();
                                          Get.back();
                                        } else {
                                          model.selectPromotion(
                                              promotionDetailsModel
                                                      ?.promotionCode ??
                                                  '');
                                          Get.back();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ThemeColor.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: Text(
                                        model.cart.promotionCode ==
                                                promotionDetailsModel!
                                                    .promotionCode
                                            ? "Huỷ chọn "
                                            : "Chọn khuyến mãi",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey[300],
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween, // Căn giữa và đặt cách đều hai phần tử
                                    children: [
                                      Text('Ngày hết hạn :',
                                          style: Get.textTheme.bodySmall),
                                      Text(
                                          formatOnlyDate(
                                              promotionDetailsModel?.endDate ??
                                                  "2025-01-01T00:00:00"),
                                          style: Get.textTheme.bodySmall),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey[300],
                                    thickness: 1,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Để căn bên trái theo chiều ngang
                                    children: [
                                      Text(
                                        promotionDetailsModel?.description ??
                                            '',
                                        style: Get.textTheme.bodySmall,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class DotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Color(0xFFF5F5F5);
    final double dotSpacing = 22;
    final double edgeDotSpacing = 15;
    final double topOffset = 25.0;

    for (int i = 0; i < 15; i++) {
      double x = i * dotSpacing;

      if (i == 0) {
        x -= edgeDotSpacing;
        canvas.drawCircle(Offset(x, topOffset), 10.0, paint);
      } else if (i == 13) {
        x += edgeDotSpacing;
        canvas.drawCircle(Offset(x, topOffset), 10.0, paint);
      } else {
        canvas.drawCircle(Offset(x, topOffset), 4.0, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

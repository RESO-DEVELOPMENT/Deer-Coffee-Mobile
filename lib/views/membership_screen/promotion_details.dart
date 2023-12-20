import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/pointify/promotion_details_model.dart';
import 'package:deer_coffee/models/pointify/promotion_model.dart';
import 'package:deer_coffee/models/pointify/voucher_model.dart';
import 'package:deer_coffee/models/user.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/utils/route_constrant.dart';
import 'package:deer_coffee/utils/share_pref.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  PromotionPointify? promotionDetailsModel;
  UserDetails? info;
  String? selectedCode;
  @override
  void initState() {
    promotionDetailsModel =
        Get.find<CartViewModel>().getPromotionById(widget.id);
    info = Get.find<AccountViewModel>().memberShipModel;
    // ignore: prefer_is_not_empty
    if (promotionDetailsModel?.promotionType == 3) {
      selectedCode =
          '${info?.phoneNumber}_${promotionDetailsModel?.promotionCode}_${promotionDetailsModel?.listVoucher?.first.voucherCode ?? ''}';
    } else {
      selectedCode =
          '${info?.phoneNumber}_${promotionDetailsModel!.promotionCode}';
    }
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
          if (promotionDetailsModel == null) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                  child: Text(
                "Không tìm thấy khuyến mãi",
              )),
            );
          }
          return Stack(
            children: [
              Container(
                color: Colors.grey,
                width: double.infinity,
                height: double.infinity,
              ),
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Color(0xFFF5F5F5),
                      ),
                      padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  size: 40,
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
                            height: Get.height * 0.8,
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
                                // CustomPaint(
                                //   size: Size(Get.width,
                                //       12), // Điều chỉnh kích thước của đường kẻ
                                //   painter: DotPainter(),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: QrImageView(
                                    data: selectedCode ?? '',
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
                                        text: selectedCode ?? ''));
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
                                            selectedCode ?? '',
                                            promotionDetailsModel
                                                    ?.promotionType ??
                                                2);
                                        Get.back();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ThemeColor.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // Căn giữa và đặt cách đều hai phần tử
                                  children: [
                                    Text('Lượt sử dụng còn lại',
                                        style: Get.textTheme.bodySmall),
                                    Text(
                                        promotionDetailsModel!
                                                    .currentVoucherQuantity! >
                                                0
                                            ? (promotionDetailsModel!
                                                        .currentVoucherQuantity ??
                                                    0)
                                                .toString()
                                            : "Vô hạn",
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
                                      promotionDetailsModel?.description ?? '',
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

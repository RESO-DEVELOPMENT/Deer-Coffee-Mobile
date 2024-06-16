import 'dart:async';

import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:deer_coffee/enums/view_status.dart';

import '../login/login_card.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  String? qrData;
  bool showBalance = false;
  String _qrCodeType = "PAYMENT";
  List<String> listQRType = ["PAYMENT", "GET_POINT"];
  AccountViewModel accountViewModel = Get.find<AccountViewModel>();
  int _countdown = 120; // Đếm ngược từ 60 giây
  late Timer _timer;
  @override
  void initState() {
    accountViewModel.getQRCode().then((value) => qrData = value);
    startCountdown();
    super.initState();
    // Generate QR code data
  }

  changeQr() {
    switch (_qrCodeType) {
      case "PAYMENT":
        accountViewModel.getQRCode().then((value) => setState(() {
              qrData = value;
              _countdown = 120;
            }));
        break;
      case "GET_POINT":
        setState(() {
          qrData = accountViewModel.memberShipModel?.phoneNumber;
          _countdown = 120;
        });
        break;
      default:
        accountViewModel.getQRCode().then((value) => setState(() {
              qrData = value;
              _countdown = 120;
            }));
    }
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          // _timer.cancel(); // Hủy bỏ timer khi đếm ngược kết thúc
          accountViewModel.getQRCode().then((value) => setState(() {
                qrData = value;
                _countdown = 120;
              }));
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quét mã thanh toán, tích điểm',
          style:
              Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: ScopedModel<AccountViewModel>(
        model: Get.find<AccountViewModel>(),
        child: ScopedModelDescendant<AccountViewModel>(
            builder: (context, build, model) {
          if (model.memberShipModel == null) {
            return const Center(child: LoginCard());
          }
          if (model.status == ViewStatus.Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (qrData == null) {
            return const Center(
              child: Text("Không lấy được mã qr"),
            );
          }
          return Center(
            child: Container(
              height: Get.height,
              color: ThemeColor.primary,
              padding: const EdgeInsets.all(16),
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    const Text("Đưa mã này cho thu ngân"),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: QrImageView(
                        data: qrData ?? '',
                        embeddedImage: const AssetImage(
                          'assets/images/logo.png',
                        ),
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ),

                    // Line
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        DottedDashedLine(
                          height: 0.5,
                          width: MediaQuery.of(context).size.width,
                          axis: Axis.horizontal,
                          dashColor: ThemeColor.primary,
                        ),
                        Positioned(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(100),
                              bottomRight: Radius.circular(100),
                            ),
                            child: Container(
                              width: 15,
                              height: 20,
                              color: ThemeColor.primary,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(100),
                            ),
                            child: Container(
                              width: 15,
                              height: 20,
                              color: ThemeColor.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: const Text("Ẩn/Hiện"),
                        ),
                        IconButton(
                          icon: Icon(
                            showBalance
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              showBalance = !showBalance;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: model
                          .memberShipModel!.memberLevel!.memberWallet!
                          .map(
                            (e) => Container(
                              padding: const EdgeInsets.all(2),
                              height: 68,
                              width: 140,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ThemeColor.blue,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        e.walletType?.name ?? '',
                                        style:
                                            Get.textTheme.labelSmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: showBalance
                                          ? Text(
                                              formatPrice(e.balance ?? 0),
                                              style: Get.textTheme.labelMedium
                                                  ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : Text(
                                              '*' *
                                                  (formatPrice(e.balance ?? 0))
                                                      .length,
                                              style: Get.textTheme.bodyLarge
                                                  ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

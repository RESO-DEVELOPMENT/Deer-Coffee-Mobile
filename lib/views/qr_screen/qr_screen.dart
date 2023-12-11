import 'dart:async';

import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../enums/view_status.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  String? qrData;
  String _qrCodeType = "PAYMENT";
  List<String> listQRType = ["PAYMENT", "TOP_UP", "GET_POINT"];
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
          'QR thanh toán, tích điểm',
          style:
              Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: ScopedModel<AccountViewModel>(
        model: Get.find<AccountViewModel>(),
        child: ScopedModelDescendant<AccountViewModel>(
            builder: (context, build, model) {
          if (model.status == ViewStatus.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (qrData == null) {
            return Center(
              child: Text("Không lấy được mã qr, vui lòng thửu lại"),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: QrImageView(
                    data: qrData ?? '',
                    embeddedImage: const AssetImage(
                      'assets/images/logo.png',
                    ),
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Tự động cập nhật sau"),
                    Text(
                      ' $_countdown s',
                      style: Get.textTheme.bodyMedium,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
                          return states.contains(MaterialState.selected)
                              ? ThemeColor.primary
                              : Colors.white;
                        }),
                        foregroundColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
                          return states.contains(MaterialState.selected)
                              ? Colors.white
                              : ThemeColor.primary;
                        }),
                      ),
                      onPressed: () {
                        model.getQRCode().then((value) => setState(() {
                              qrData = value;
                              _countdown = 120;
                            }));
                      },
                      child: Text('Cập nhật'),
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: model.memberShipModel!.level!.memberWallet!
                        .map(
                          (e) => Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(2),
                            height: 80,
                            width: Get.width * 0.4,
                            decoration: BoxDecoration(
                              border: Border.all(color: ThemeColor.primary),
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(e.walletType?.name ?? '',
                                            style: Get.textTheme.bodyMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)))),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(formatPrice(e.balance ?? 0),
                                        style: Get.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList()),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 32),
        child: SegmentedButton<String>(
          style: ButtonStyle(
            side: MaterialStateProperty.all(BorderSide(
                color: ThemeColor.primary,
                width: 1.5,
                style: BorderStyle.solid)),
            backgroundColor:
                MaterialStateColor.resolveWith((Set<MaterialState> states) {
              return states.contains(MaterialState.selected)
                  ? ThemeColor.primary
                  : Colors.white;
            }),
            foregroundColor:
                MaterialStateColor.resolveWith((Set<MaterialState> states) {
              return states.contains(MaterialState.selected)
                  ? Colors.white
                  : ThemeColor.primary;
            }),
          ),
          showSelectedIcon: false,
          segments: const <ButtonSegment<String>>[
            ButtonSegment<String>(
              value: 'PAYMENT',
              label: Text('Thanh toán'),
            ),
            ButtonSegment<String>(
              value: 'TOP_UP',
              label: Text('Nạp tiền, Tích điểm'),
            ),
          ],
          selected: <String>{_qrCodeType},
          onSelectionChanged: (Set<String> newSelection) {
            setState(() {
              _qrCodeType = newSelection.first;
            });
          },
        ),
      ),
    );
  }
}

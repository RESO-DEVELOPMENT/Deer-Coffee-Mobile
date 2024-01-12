import 'package:barcode_widget/barcode_widget.dart';
import 'package:deer_coffee/models/user.dart';
import 'package:deer_coffee/utils/share_pref.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/views/profile_screen/location.dart';
import 'package:deer_coffee/views/profile_screen/order_history.dart';
import 'package:deer_coffee/views/profile_screen/update_profile.dart';
import 'package:deer_coffee/widgets/other_dialogs/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../enums/view_status.dart';
import '../../utils/format.dart';
import '../../utils/route_constrant.dart';
import '../../view_models/account_view_model.dart';
import '../login/login_card.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  UserDetails? userModel;
  AccountViewModel model = Get.find<AccountViewModel>();
  @override
  void initState() {
    userModel = model.memberShipModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tài khoản",
          style:
              Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: ScopedModel<AccountViewModel>(
        model: model,
        child: ScopedModelDescendant<AccountViewModel>(
            builder: (context, build, model) {
          if (model.status == ViewStatus.Loading) {
            return SizedBox(
                width: Get.width,
                height: 280,
                child: const Center(child: CircularProgressIndicator()));
          }

          if (model.memberShipModel == null) {
            return const Center(child: LoginCard());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: Get.width * 0.9,
                  height: Get.width * 0.9 * 9 / 16,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ThemeColor.primary,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            ElevatedButton(
                              onPressed: () {
                                Get.toNamed(RouteHandler.VOUCHER);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                          ?.copyWith(color: Colors.blueAccent),
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
                          children: model.memberShipModel!.level!.memberWallet!
                              .map((e) => Text(
                                    '${e.walletType?.name ?? ''}: ${formatPrice(e.balance ?? 0)}',
                                    style: Get.textTheme.titleMedium?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))
                              .toList()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (userModel == null) {
                                  showConfirmDialog(
                                          title: "Người dùng chưa đăng nhập",
                                          content:
                                              "Vui lòng đăng nhập để đặt đơn và nhận ưu đãi nhé",
                                          confirmText: "Đăng nhập")
                                      .then((value) => {
                                            if (value)
                                              {Get.toNamed(RouteHandler.LOGIN)}
                                          });
                                } else {
                                  Get.toNamed(RouteHandler.ORDER);
                                }
                              },
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
                                            Icons.history_outlined,
                                            color: ThemeColor.primary,
                                            size: 40,
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, left: 10),
                                        child: Text('Lịch sử đơn hàng',
                                            style: Get.textTheme.bodyMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (userModel == null) {
                                  showConfirmDialog(
                                          title: "Người dùng chưa đăng nhập",
                                          content:
                                              "Vui lòng đăng nhập để đặt đơn và nhận ưu đãi nhé",
                                          confirmText: "Đăng nhập")
                                      .then((value) => {
                                            if (value)
                                              {Get.toNamed(RouteHandler.LOGIN)}
                                          });
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UpdateProfilePage(),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(4),
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
                                            Icons.person_outline,
                                            color: ThemeColor.primary,
                                            size: 40,
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, left: 10),
                                        child: Text('Thông tin cá nhân',
                                            style: Get.textTheme.bodyMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Expanded(
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           if (userModel == null) {
                      //             showConfirmDialog(
                      //                     title: "Người dùng chưa đăng nhập",
                      //                     content:
                      //                         "Vui lòng đăng nhập để đặt đơn và nhận ưu đãi nhé",
                      //                     confirmText: "Đăng nhập")
                      //                 .then((value) => {
                      //                       if (value)
                      //                         {Get.toNamed(RouteHandler.LOGIN)}
                      //                     });
                      //           } else {
                      //             Get.toNamed(RouteHandler.TRANSACTIONS);
                      //           }
                      //         },
                      //         child: Container(
                      //           margin: const EdgeInsets.all(8),
                      //           padding: const EdgeInsets.all(4),
                      //           height: 100,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(16),
                      //             color: Colors.white,
                      //           ),
                      //           child: Stack(
                      //             children: [
                      //               Align(
                      //                   alignment: Alignment.topLeft,
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.all(8.0),
                      //                     child: Icon(
                      //                       Icons.query_stats_outlined,
                      //                       color: ThemeColor.primary,
                      //                       size: 40,
                      //                     ),
                      //                   )),
                      //               Align(
                      //                 alignment: Alignment.bottomLeft,
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.only(
                      //                       bottom: 10, left: 10),
                      //                   child: Text('Lịch sử giao dịch',
                      //                       style: Get.textTheme.bodyMedium
                      //                           ?.copyWith(
                      //                               fontWeight:
                      //                                   FontWeight.bold)),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           if (userModel == null) {
                      //             showConfirmDialog(
                      //                     title: "Người dùng chưa đăng nhập",
                      //                     content:
                      //                         "Vui lòng đăng nhập để đặt đơn và nhận ưu đãi nhé",
                      //                     confirmText: "Đăng nhập")
                      //                 .then((value) => {
                      //                       if (value)
                      //                         {Get.toNamed(RouteHandler.LOGIN)}
                      //                     });
                      //           } else {
                      //             showAlertDialog(
                      //                 content: "Tính năng đang phát triển");
                      //           }
                      //         },
                      //         child: Container(
                      //           margin: const EdgeInsets.all(8),
                      //           height: 100,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(13),
                      //             color: Colors.white,
                      //           ),
                      //           child: Stack(
                      //             children: [
                      //               Align(
                      //                   alignment: Alignment.topLeft,
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.all(8.0),
                      //                     child: Icon(
                      //                       Icons.credit_card_outlined,
                      //                       color: ThemeColor.primary,
                      //                       size: 40,
                      //                     ),
                      //                   )),
                      //               Align(
                      //                 alignment: Alignment.bottomLeft,
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.only(
                      //                       bottom: 10, left: 10),
                      //                   child: Text('Danh sách thẻ',
                      //                       style: Get.textTheme.bodyMedium
                      //                           ?.copyWith(
                      //                               fontWeight:
                      //                                   FontWeight.bold)),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            //   border: Border.all(
                            // color: Colors.grey, // Màu của đường viền nếu cần

                            //   ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white, // Màu của bóng đổ
                                offset: Offset(0, 0.5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(RouteHandler.STORES);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Danh sách cửa hàng',
                                          style: Get.textTheme.bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      const Icon(Icons.store_outlined)
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(),
                              SizedBox(
                                height: 50,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Location()),
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Địa chỉ đã lưu',
                                          style: Get.textTheme.bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      const Icon(Icons.location_on_outlined)
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(),
                              SizedBox(
                                height: 50,
                                child: InkWell(
                                  onTap: () {
                                    showAlertDialog(
                                        content: "Tính năng đang phát triển");
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Cài đặt',
                                          style: Get.textTheme.bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      const Icon(Icons.settings_outlined)
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(),
                              SizedBox(
                                height: 50,
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(RouteHandler.POLICY);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Điều khoản sử dụng',
                                          style: Get.textTheme.bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      const Icon(Icons.policy_outlined)
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(),
                              SizedBox(
                                height: 50,
                                child: InkWell(
                                  onTap: () {
                                    if (userModel == null) {
                                      Get.toNamed(RouteHandler.LOGIN);
                                    } else {
                                      Get.find<AccountViewModel>()
                                          .processSignOut();
                                    }
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          userModel == null
                                              ? "Đăng nhập"
                                              : 'Đăng xuất',
                                          style: Get.textTheme.bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      Icon(userModel == null
                                          ? Icons.login_outlined
                                          : Icons.logout_outlined)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

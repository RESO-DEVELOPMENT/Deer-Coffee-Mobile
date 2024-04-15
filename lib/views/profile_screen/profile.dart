import 'package:deer_coffee/models/pointify/membership_info.dart';
import 'package:deer_coffee/models/pointify/membership_transaction.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/views/profile_screen/update_profile.dart';
import 'package:deer_coffee/widgets/other_dialogs/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../enums/view_status.dart';
import '../../models/user_create.dart';
import '../../utils/format.dart';
import '../../utils/route_constrant.dart';
import '../../view_models/account_view_model.dart';
import '../login/login_card.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class MemberRankProgressBar extends StatelessWidget {
  const MemberRankProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Bronze', style: TextStyle(color: Colors.white, fontSize: 15)),
        Text('Ban con xx diem de thang hang',
            style: TextStyle(color: Colors.white, fontSize: 13)),
        Text('Silver', style: TextStyle(color: Colors.white, fontSize: 15)),
      ],
    );
  }
}

class CustomLinearProgressBar extends StatelessWidget {
  final double progress;

  const CustomLinearProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 12.0,
              height: 12.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8), // Adjust the spacing as needed
            Expanded(
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.white,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.tealAccent),
              ),
            ),
            const SizedBox(width: 8), // Adjust the spacing as needed
            Container(
              width: 12.0,
              height: 12.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OtherPageState extends State<OtherPage> {
  MembershipInfo? userModel;
  AccountViewModel model = Get.find<AccountViewModel>();
  MemberWallet? pointWallet;
  MemberWallet? moneyWallet;
  MemberLevel? memberLevel;
  @override
  void initState() {
    userModel = model.memberShipModel;
    memberLevel = model.memberShipModel?.memberLevel;
    pointWallet = model.memberShipModel?.memberLevel?.memberWallet
        ?.firstWhere((element) => element.walletType?.name == "Điểm");
    moneyWallet = model.memberShipModel?.memberLevel?.memberWallet
        ?.firstWhere((element) => element.walletType?.name == "Số dư");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tài khoản",
          style:
              Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[350],
                  ),
                  // decoration: BoxDecoration(border: Border.all(width: 20, color: Colors.transparent)),
                  child: Column(
                    children: [
                      Container(
                        width: Get.width * 0.9,
                        height: Get.width * 0.9 * 9 / 16,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ThemeColor.primary,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Hạng thành viên',
                                        style: Get.textTheme.labelSmall
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                    Text(
                                        model.memberShipModel?.memberLevel
                                                ?.name ??
                                            '',
                                        style: Get.textTheme.labelLarge
                                            ?.copyWith(
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.confirmation_number,
                                          color: ThemeColor.primary,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Khuyến mãi',
                                          style: Get.textTheme.bodySmall
                                              ?.copyWith(
                                                  color: ThemeColor.primary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CustomLinearProgressBar(
                                  progress: (pointWallet?.balance ?? 1) /
                                      (memberLevel?.maxPoint ?? 1)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    model.memberShipModel?.memberLevel?.name ??
                                        '',
                                    style: Get.textTheme.bodyMedium?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    userModel?.memberLevel?.nextLevelName ?? '',
                                    style: Get.textTheme.bodyMedium?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: model
                                    .memberShipModel!.memberLevel!.memberWallet!
                                    .map((e) => Text(
                                          '${e.walletType?.name ?? ''}: ${formatPrice(e.balance ?? 0)}',
                                          style: Get.textTheme.bodySmall
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                        ))
                                    .toList()),
                          ],
                        ),
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Container(
                      //       // width: ((Get.width * 0.6) / 2) - 1,
                      //       // height: (Get.width * 0.3) / 2,

                      //       decoration: const BoxDecoration(
                      //         borderRadius: BorderRadius.only(
                      //             bottomLeft: Radius.circular(20)),
                      //       ),
                      //       child: const Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             'Ví tiền',
                      //             style: TextStyle(
                      //               fontSize: 15,
                      //               fontWeight: FontWeight.normal,
                      //             ),
                      //             textAlign: TextAlign.center,
                      //           ),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               Text(
                      //                 model
                      //                     .memberShipModel!.level!.memberWallet!
                      //                     .where((element) =>
                      //                         element.walletType == "Monney"),
                      //                 style: TextStyle(
                      //                   fontSize: 15,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //               ),
                      //               Text(
                      //                 ' ₫',
                      //                 style: TextStyle(
                      //                   fontSize: 15,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Container(
                      //       color: Colors.white,
                      //       margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      //       width: 2,
                      //       height: (Get.width * 0.3) / 4,
                      //     ),
                      //     Container(
                      //       // width: ((Get.width * 0.6) / 2) - 1,
                      //       // height: (Get.width * 0.3) / 2,
                      //       decoration: const BoxDecoration(
                      //         borderRadius: BorderRadius.only(
                      //             bottomRight: Radius.circular(20)),
                      //       ),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           const Text(
                      //             'Deer Point',
                      //             style: TextStyle(
                      //               fontSize: 15,
                      //               fontWeight: FontWeight.normal,
                      //             ),
                      //             textAlign: TextAlign.center,
                      //           ),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               const Text(
                      //                 '120',
                      //                 style: TextStyle(
                      //                   fontSize: 15,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //               ),
                      //               Image.asset(
                      //                 'assets/images/deercoffee-logopage-0001-2.png',
                      //                 width: 30,
                      //                 height: 30,
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // )
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
                                            style: Get.textTheme.labelMedium
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
                                            style: Get.textTheme.labelMedium
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
                                          style: Get.textTheme.labelMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      const Icon(Icons.store_outlined)
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(),
                              // SizedBox(
                              //   height: 50,
                              //   child: InkWell(
                              //     onTap: () {
                              //       Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 const Location()),
                              //       );
                              //     },
                              //     child: Row(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.center,
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Text('Địa chỉ đã lưu',
                              //             style: Get.textTheme.bodyMedium
                              //                 ?.copyWith(
                              //                     fontWeight: FontWeight.bold)),
                              //         const Icon(Icons.location_on_outlined)
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // const Divider(),
                              // SizedBox(
                              //   height: 50,
                              //   child: InkWell(
                              //     onTap: () {
                              //       showAlertDialog(
                              //           content: "Tính năng đang phát triển");
                              //     },
                              //     child: Row(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.center,
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Text('Cài đặt',
                              //             style: Get.textTheme.bodyMedium
                              //                 ?.copyWith(
                              //                     fontWeight: FontWeight.bold)),
                              //         const Icon(Icons.settings_outlined)
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // const Divider(),
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
                                          style: Get.textTheme.labelMedium
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
                                          style: Get.textTheme.labelMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      Icon(userModel == null
                                          ? Icons.login_outlined
                                          : Icons.logout_outlined)
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(),

                              userModel != null
                                  ? SizedBox(
                                      height: 50,
                                      child: InkWell(
                                        onTap: () async {
                                          showConfirmDialog(
                                                  title: "Xoá tài khoản",
                                                  content:
                                                      "Tài khoản của bạn sẽ đuợc xoá khỏi hệ thống\nThông tin đơn hàng vẫn được lưu trử để phục vụ mục đích tra cứu thông tin đơn hàng\nChúng tôi đảm bảo thông tin của bạn được bảo mật hoàn toàn",
                                                  confirmText: "Xoá tài khoản")
                                              .then((value) async => {
                                                    if (value)
                                                      {
                                                        await Get.find<
                                                                AccountViewModel>()
                                                            .updateUser(
                                                                UserUpdate(
                                                                    status:
                                                                        "Deactive"),
                                                                userModel
                                                                        ?.membershipId ??
                                                                    ''),
                                                        Get.toNamed(
                                                            RouteHandler.LOGIN)
                                                      }
                                                  });
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Xoá tài khoản',
                                                style: Get.textTheme.labelMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            const Icon(Icons.delete)
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
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

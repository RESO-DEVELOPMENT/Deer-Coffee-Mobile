import 'package:barcode_widget/barcode_widget.dart';
import 'package:deer_coffee/models/user.dart';
import 'package:deer_coffee/utils/share_pref.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/views/profile_screen/order_history.dart';
import 'package:deer_coffee/views/profile_screen/update_profile.dart';
import 'package:deer_coffee/widgets/other_dialogs/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../enums/view_status.dart';
import '../../utils/route_constrant.dart';
import '../../view_models/account_view_model.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  int _currentIndex = 0;
  UserModel? userModel;
  @override
  void initState() {
    // TODO: implement initState
    getUserInfo().then((value) => userModel = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        title: Text(
          "Tài khoản",
          style:
              Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (userModel == null) {
                  showAlertDialog(content: "Người dùng chưa đăng nhập ");
                } else {
                  Get.find<AccountViewModel>().processSignOut();
                }
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                              showAlertDialog(
                                  content: "Người dùng chưa đăng nhập ");
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
                                                fontWeight: FontWeight.bold)),
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
                              showAlertDialog(
                                  content: "Người dùng chưa đăng nhập ");
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
                                                fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (userModel == null) {
                              showAlertDialog(
                                  content: "Người dùng chưa đăng nhập ");
                            } else {
                              Get.toNamed(RouteHandler.TRANSACTIONS);
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
                                        Icons.query_stats_outlined,
                                        color: ThemeColor.primary,
                                        size: 40,
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 10),
                                    child: Text('Lịch sử giao dịch',
                                        style: Get.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
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
                              showAlertDialog(
                                  content: "Người dùng chưa đăng nhập ");
                            } else {
                              showAlertDialog(
                                  content: "Tính năng đang phát triển");
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
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
                                        Icons.credit_card_outlined,
                                        color: ThemeColor.primary,
                                        size: 40,
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 10),
                                    child: Text('Danh sách thẻ',
                                        style: Get.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                                showAlertDialog(
                                    content: "Tính năng đang phát triển");
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Địa chỉ đã lưu',
                                      style: Get.textTheme.bodyMedium?.copyWith(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Cài đặt',
                                      style: Get.textTheme.bodyMedium?.copyWith(
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
                                showAlertDialog(
                                    content: "Tính năng đang phát triển");
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Điều khoản sử dụng',
                                      style: Get.textTheme.bodyMedium?.copyWith(
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
                                Get.find<AccountViewModel>().processSignOut();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Đăng xuất',
                                      style: Get.textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.bold)),
                                  const Icon(Icons.logout_outlined)
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
      ),
    );
  }
}
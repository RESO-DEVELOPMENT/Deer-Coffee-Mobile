import 'dart:async';

import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:deer_coffee/enums/order_enum.dart';
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:deer_coffee/views/home_screen/banner_home.dart';
import 'package:deer_coffee/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../utils/route_constrant.dart';
import '../../widgets/other_dialogs/dialog.dart';
import '../bottom_sheet_util.dart';
import '../login/login_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool isUuDaiPressed = false;
bool isCapNhatPressed = false;
bool isCoffeePressed = false;

final List<String> imageList = [
  'assets/images/1.png',
  'assets/images/2.png',
  'assets/images/3.png',
  // Thêm các đường dẫn đến hình ảnh của bạn tại đây
];

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    // Get.find<AccountViewModel>().getMembershipInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5EDFF),
      body: CustomScrollView(
        slivers: [
          ScopedModel<AccountViewModel>(
            model: Get.find<AccountViewModel>(),
            child: SliverAppBar(
              expandedHeight: 240.0,
              backgroundColor: const Color(0xFFE5EDFF),
              floating: true,
              pinned: true,
              title: ScopedModelDescendant<AccountViewModel>(
                  builder: (context, build, model) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Chào ngày mới!",
                              style: Get.textTheme.bodyMedium),
                          Text(model.memberShipModel?.fullName ?? '',
                              style: Get.textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColor.primary,
                      ),
                      child: const Icon(
                        Icons.confirmation_num_outlined,
                        size: 24,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.toNamed(RouteHandler.VOUCHER);
                      },
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColor.primary,
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                      child: const Icon(
                        Icons.notifications_outlined,
                        size: 24,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                );
              }),
              flexibleSpace: ScopedModelDescendant<AccountViewModel>(
                  builder: (context, build, model) {
                if (model.user?.userInfo == null) {
                  return const FlexibleSpaceBar(background: LoginCard());
                } else {
                  return FlexibleSpaceBar(background: userCard(model));
                }
              }),
            ),
          ),
          ScopedModel<MenuViewModel>(
            model: Get.find<MenuViewModel>(),
            child: SliverList.list(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 24),
                        child: Transform.rotate(
                          angle: 0 * (3.14159265359 / 180),
                          child: Container(
                            height: 5,
                            width: 60,
                            color: ThemeColor.primary,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.9,
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.find<CartViewModel>()
                                      .setOrderType(OrderTypeEnum.EAT_IN);
                                  showSelectStore();
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.local_cafe_outlined,
                                      color: ThemeColor.primary,
                                      size: 32,
                                    ),
                                    Text("Tại cửa hàng",
                                        style: Get.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: ThemeColor.primary,
                                                fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.find<CartViewModel>()
                                      .setOrderType(OrderTypeEnum.DELIVERY);

                                  inputDialog(
                                          "Giao hàng",
                                          "Vui lòng nhập địa chỉ",
                                          Get.find<CartViewModel>().deliAddress,
                                          isNum: false)
                                      .then((value) => Get.find<CartViewModel>()
                                          .setAddress(value));
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.electric_moped_outlined,
                                      color: ThemeColor.primary,
                                      size: 32,
                                    ),
                                    Text("Giao hàng",
                                        style: Get.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: ThemeColor.primary,
                                                fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.find<CartViewModel>()
                                      .setOrderType(OrderTypeEnum.TAKE_AWAY);
                                  showSelectStore();
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.home_outlined,
                                      color: ThemeColor.primary,
                                      size: 36,
                                    ),
                                    Text("Mang đi",
                                        style: Get.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: ThemeColor.primary,
                                                fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ScopedModelDescendant<MenuViewModel>(
                          builder: (context, build, model) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              scrollPhysics: const BouncingScrollPhysics(),
                              height: 140.0, // Điều chỉnh chiều cao của slider
                              aspectRatio: 9,
                              autoPlay: true, // Tự động chuyển đổi ảnh
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                            items: model.blogList?.map((blog) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        "${RouteHandler.BLOG}?id=${blog.id}",
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(blog.image ?? ""),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        );
                      }),
                      Container(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                          child: ScopedModelDescendant<MenuViewModel>(
                              builder: (context, child, model) {
                            return GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 4,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                              padding: const EdgeInsets.all(4),
                              children: model.categories!
                                  .map(
                                    (e) => buildCircularButton(e.name ?? '',
                                        e.picUrl ?? '', e.id ?? ''),
                                  )
                                  .toList(),
                            );
                          })),
                      Text('Khám phá thêm',
                          style: Get.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      ScopedModelDescendant<MenuViewModel>(
                          builder: (context, build, model) {
                        return GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: model.blogList!
                                .map((e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        color: Colors.grey,
                                        clipBehavior: Clip.none,
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              "${RouteHandler.BLOG}?id=${e.id}",
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      e.image ?? ""),
                                                  fit: BoxFit.cover),
                                            ),
                                            child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: Text(
                                                    e.title ?? '',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Get
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList());
                      })
                    ],
                  ),
                ),
              ],
            ),
          )

          // hop trang ben duoi
        ],
      ),
    );
  }

  void _changeItem(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  Widget buildCircularButton(
    String text1,
    String image,
    String categoryId,
  ) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              // Xử lý khi nhấn vào hình tròn ở đây
              Get.toNamed(
                "${RouteHandler.CATEGORY_DETAIL}?id=$categoryId",
              );
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage(image.isEmpty
                          ? 'https://i.imgur.com/X0WTML2.jpg'
                          : image))),
            ),
          ),
          Text(
            text1,
            style: Get.textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget userCard(AccountViewModel model) {
    if (model.memberShipModel == null) {
      return const SizedBox();
    }
    return Container(
      margin: GetPlatform.isWeb
          ? const EdgeInsets.fromLTRB(16, 80, 16, 16)
          : const EdgeInsets.fromLTRB(16, 120, 16, 16),
      padding: const EdgeInsets.all(16),
      width: Get.width * 0.9,
      height: 100,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/homepage.png'),
          fit: BoxFit.cover,
        ),
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Card(
        child: Container(
          height: 80,
          width: Get.width, // Chỉnh độ cao của container chứa ảnh
          padding: const EdgeInsets.all(16), // Loại bỏ padding
          child: BarcodeWidget(
              barcode: Barcode.code128(),
              drawText: false,
              data: model.memberShipModel?.phoneNumber ?? '',
              style: Get.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

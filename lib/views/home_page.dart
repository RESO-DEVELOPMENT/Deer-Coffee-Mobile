import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:deer_coffee/enums/order_enum.dart';
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:deer_coffee/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import '../utils/route_constrant.dart';
import '../widgets/other_dialogs/dialog.dart';
import 'bottom_sheet_util.dart';

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
    Get.find<AccountViewModel>().getMembershipInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5EDFF),
      body: CustomScrollView(
        slivers: [
          ScopedModel<AccountViewModel>(
            model: Get.find<AccountViewModel>(),
            child: SliverAppBar(
              expandedHeight: 280.0,
              backgroundColor: const Color(0xFFE5EDFF),
              floating: true,
              pinned: true,
              title: ScopedModelDescendant<AccountViewModel>(
                  builder: (context, build, model) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Chào ngày mới!",
                                style: Get.textTheme.bodyMedium),
                            Text(model.user?.userInfo?.fullName ?? '',
                                style: Get.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 55,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            color: ThemeColor.primary,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.confirmation_num_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Get.toNamed(RouteHandler.VOUCHER);
                            },
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ThemeColor.primary,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
              flexibleSpace: ScopedModelDescendant<AccountViewModel>(
                  builder: (context, build, model) {
                if (model.user?.userInfo == null) {
                  return FlexibleSpaceBar(background: loginCard());
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.only(bottom: 100),
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
                                  Get.find<CartViewModel>().deliveryType =
                                      OrderTypeEnum.EAT_IN;
                                  showSelectStore();
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.store,
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
                                  Get.find<CartViewModel>().deliveryType =
                                      OrderTypeEnum.DELIVERY;
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
                                      Icons.delivery_dining,
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
                                  Get.find<CartViewModel>().deliveryType =
                                      OrderTypeEnum.TAKE_AWAY;
                                  showSelectStore();
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.coffee_maker,
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
                          padding: EdgeInsets.all(16),
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
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                          image: NetworkImage(blog.image ?? ""),
                                          fit: BoxFit.cover),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        );
                      }),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
                          child: ScopedModelDescendant<MenuViewModel>(
                              builder: (context, child, model) {
                            return GridView.count(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 4,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                              padding: EdgeInsets.all(4),
                              children: model.categories!
                                  .map(
                                    (e) => buildCircularButton(
                                      e.name ?? '',
                                      e.picUrl ?? '',
                                    ),
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
                            physics: NeverScrollableScrollPhysics(),
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
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            image: DecorationImage(
                                                image:
                                                    NetworkImage(e.image ?? ""),
                                                fit: BoxFit.cover),
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
    print(value);
    setState(() {
      _currentIndex = value;
    });
  }

  Widget buildCircularButton(
    String text1,
    String image,
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

  Widget loginCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 80, 8, 8),
      padding: const EdgeInsets.all(8),
      width: Get.width * 0.9,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Đăng nhập',
            style: Get.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Sử dụng app để tích điểm và đổi những ưu đãi chỉ dành riêng cho thành viên bạn nhé !',
            style: Get.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 6,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:6.0,bottom: 16.0,left: 8.0,right:8.0),
                child: Image.asset(
                  'assets/images/hinhchunhat.png',
                  height: 80,
                  width: 329,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: -12,
                child: Container(
                  width: Get.width * 0.6,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment(-1, -1.133),
                      end: Alignment(1, 1.367),
                      colors: <Color>[Colors.blueAccent, Color(0xffc8ddff)],
                      stops: <double>[0.014, 1],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      LoginScreen loginScreen = LoginScreen();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => loginScreen,
                        ),
                      );
                    },
                    child: Text('Đăng nhập',
                        textAlign: TextAlign.center,
                        style: Get.textTheme.bodyLarge
                            ?.copyWith(color: Colors.white)),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                child: Container(
                  width: Get.width * 0.6,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment(-1, -1.133),
                      end: Alignment(1, 1.367),
                      colors: <Color>[Colors.blueAccent, Color(0xffc8ddff)],
                      stops: <double>[0.014, 1],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Deer Coffee Reward',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffffffff),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            clipBehavior: Clip.none,
          ),
        ],
      ),
    );
  }

  Widget userCard(AccountViewModel model) {
    if (model.memberShipModel == null) {
      return SizedBox();
    }
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 120, 16, 16),
      padding: const EdgeInsets.all(16),
      width: Get.width * 0.9,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/homepage.png'),
          fit: BoxFit.cover,
        ),
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: model.memberShipModel!.memberWallet!
                  .map((e) => Text(
                        '${e.name ?? ''}: ${(e.name ?? '') == "Ví Tiền" ? formatPrice(e.balance ?? 0) : e.balance.toString()}',
                        style: Get.textTheme.bodyLarge?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))
                  .toList()),
          Card(
            child: Container(
              height: 100,
              width: Get.width, // Chỉnh độ cao của container chứa ảnh
              padding: const EdgeInsets.all(8), // Loại bỏ padding
              child: BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: model.memberShipModel?.phoneNumber ?? '',
                  style: Get.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:deer_coffee/enums/order_enum.dart';
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../utils/route_constrant.dart';
import '../../widgets/other_dialogs/dialog.dart';
import '../bottom_sheet_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          ScopedModel<MenuViewModel>(
            model: Get.find<MenuViewModel>(),
            child: SliverAppBar(
              expandedHeight: Get.width,
              backgroundColor: Colors.white,
              flexibleSpace: ScopedModelDescendant<MenuViewModel>(
                  builder: (context, build, model) {
                {
                  return FlexibleSpaceBar(
                    background: CarouselSlider(
                      disableGesture: true,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        viewportFraction: 1,
                        aspectRatio: 8.5 / 10,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        pageSnapping: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: model.blogList?.map((blog) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(
                              "${RouteHandler.LOGIN}?id=${blog.id}",
                            );
                          },
                          child: Container(
                            width: Get.size.width,
                            height: Get.size.width,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(4.0),
                              image: DecorationImage(
                                  image: NetworkImage(blog.image ?? ""),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
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
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Transform.rotate(
                          angle: 0 * (3.14159265359 / 180),
                          child: Container(
                            height: 5,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: ThemeColor.primary,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(16),
                        width: Get.width,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: ThemeColor.primary,
                          boxShadow: [
                            BoxShadow(
                              color: ThemeColor.primary,
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  Get.find<CartViewModel>()
                                      .setOrderType(OrderTypeEnum.TAKE_AWAY);
                                  Get.offAndToNamed(
                                    "${RouteHandler.HOME}?idx=${1}",
                                  );
                                  showSelectStore();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.local_cafe_outlined,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    const SizedBox(width: 8),
                                    Text("PICK UP",
                                        style: Get.textTheme.bodyLarge
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                            const VerticalDivider(
                              color: Colors.white,
                              thickness: 1.5,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  Get.find<CartViewModel>()
                                      .setOrderType(OrderTypeEnum.DELIVERY);

                                  inputDialog(
                                          "Giao hàng",
                                          "Vui lòng nhập địa chỉ nhận hàng",
                                          Get.find<CartViewModel>()
                                              .cart
                                              .deliveryAddress,
                                          isNum: false)
                                      .then((value) => Get.find<CartViewModel>()
                                          .setAddress(value));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.electric_moped_outlined,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    const SizedBox(width: 8),
                                    Text("DELIVERY",
                                        style: Get.textTheme.bodyLarge
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ScopedModelDescendant<MenuViewModel>(
                      //     builder: (context, build, model) {
                      //   return Container(
                      //     padding: const EdgeInsets.all(16),
                      //     child: CarouselSlider(
                      //       options: CarouselOptions(
                      //         scrollPhysics: const BouncingScrollPhysics(),
                      //         // height: 140.0, // Điều chỉnh chiều cao của slider
                      //         aspectRatio: 3,
                      //         autoPlay: true, // Tự động chuyển đổi ảnh
                      //         enlargeCenterPage: true,
                      //         onPageChanged: (index, reason) {
                      //           setState(() {
                      //             _currentIndex = index;
                      //           });
                      //         },
                      //       ),
                      //       items: model.blogList?.map((blog) {
                      //         return Builder(
                      //           builder: (BuildContext context) {
                      //             return InkWell(
                      //               onTap: () {
                      //                 Get.toNamed(
                      //                   "${RouteHandler.BLOG}?id=${blog.id}",
                      //                 );
                      //               },
                      //               child: Container(
                      //                 width: MediaQuery.of(context).size.width,
                      //                 decoration: BoxDecoration(
                      //                   borderRadius:
                      //                       BorderRadius.circular(8.0),
                      //                   image: DecorationImage(
                      //                       image:
                      //                           NetworkImage(blog.image ?? ""),
                      //                       fit: BoxFit.cover),
                      //                 ),
                      //               ),
                      //             );
                      //           },
                      //         );
                      //       }).toList(),
                      //     ),
                      //   );
                      // }),
                      buildLoginButton(),
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

  Widget buildVoucherSection() {
    return ScopedModel<CartViewModel>(
      model: Get.find<CartViewModel>(),
      child: ScopedModelDescendant<CartViewModel>(
        builder: (context, child, model) {
          var numberOfVoucher = 0;
          if (model.status == ViewStatus.Loading) {
            return const SizedBox.shrink();
          }
          if (model.promotionsHasVoucher != null) {
            numberOfVoucher = model.promotionsHasVoucher?.length ?? 0;
          }
          return Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                width: 2,
                color: ThemeColor.primary, // This sets the border color to red
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            height: 48,
            child: InkWell(
                onTap: () {
                  Get.toNamed(RouteHandler.VOUCHER);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(
                          Icons.confirmation_num_outlined,
                          size: 24,
                          color: ThemeColor.primary,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Bạn có $numberOfVoucher mã giảm giá",
                          style: Get.textTheme.bodySmall?.copyWith(
                            color: ThemeColor.primary,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: ThemeColor.primary,
                    )
                  ],
                )),
          );
        },
      ),
    );
  }

  // Widget buildUserWallet() {
  //   return
  // }

  Widget buildLoginButton() {
    return ScopedModel<AccountViewModel>(
      model: Get.find<AccountViewModel>(),
      child: ScopedModelDescendant<AccountViewModel>(
        builder: (context, child, model) {
          if (model.status == ViewStatus.Loading) {
            return const SizedBox.shrink();
          }
          if (model.userId != null) {
            return buildVoucherSection();
          } else {
            return Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  width: 2,
                  color:
                      ThemeColor.primary, // This sets the border color to red
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              height: 52,
              padding: const EdgeInsets.all(8),
              child: InkWell(
                  onTap: () {
                    Get.toNamed(RouteHandler.LOGIN);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Đăng nhập ngay để tận hưởng ưu đãi nhé !",
                        maxLines: 2,
                        style: Get.textTheme.bodySmall?.copyWith(
                          color: ThemeColor.primary,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: ThemeColor.primary,
                      )
                    ],
                  )),
            );
          }
        },
      ),
    );
  }

  // Widget buildGiftCanExchangeSection() {
  //   return ScopedModel(
  //     model: Get.find<CartViewModel>(),
  //     child: ScopedModelDescendant<CartViewModel>(
  //       builder: (context, child, CartViewModel model) {
  //         if (model.status == ViewStatus.Loading || model.nearlyGift == null) {
  //           return SizedBox.shrink();
  //         }
  //         final accountModel = Get.find<AccountViewModel>();

  //         final gift = model.nearlyGift;
  //         final userBean = accountModel.currentUser?.point ?? 0;

  //         final canExchangeGift = userBean > gift.price;

  //         return Section(
  //           child: TouchOpacity(
  //             onTap: () async {
  //               final rootModel = Get.find<RootViewModel>();
  //               await rootModel.openProductDetail(gift);
  //             },
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(height: 8),
  //                 Container(
  //                   child: Text(
  //                     "BEAN ĐÃ LỚN 🎁",
  //                     style: kTitleTextStyle,
  //                   ),
  //                 ),
  //                 SizedBox(height: 4),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: [
  //                     Flexible(
  //                       flex: 6,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             canExchangeGift
  //                                 ? "Đổi ngay 1 ${gift.name}"
  //                                 : "Bạn sắp nhận được ${gift.name} rồi đấy",
  //                             style: BeanOiTheme.typography.subtitle2
  //                                 .copyWith(color: kDescriptionTextColor),
  //                             maxLines: 2,
  //                             overflow: TextOverflow.ellipsis,
  //                           ),
  //                           SizedBox(height: 8),
  //                           Container(
  //                             margin: EdgeInsets.only(
  //                               top: 8,
  //                               bottom: 8,
  //                             ),
  //                             width: Get.width,
  //                             height: 16,
  //                             decoration: BoxDecoration(
  //                               color: BeanOiTheme.palettes.neutral200,
  //                               borderRadius: BorderRadius.circular((8)),
  //                             ),
  //                             child: Stack(
  //                               clipBehavior: Clip.none,
  //                               children: [
  //                                 FractionallySizedBox(
  //                                   widthFactor: userBean / gift.price > 1
  //                                       ? 1
  //                                       : userBean / gift.price,
  //                                   child: AnimatedContainer(
  //                                     duration: Duration(seconds: 2),
  //                                     decoration: BoxDecoration(
  //                                       color: BeanOiTheme.palettes.primary400,
  //                                       borderRadius:
  //                                           BorderRadius.circular((8)),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     SizedBox(width: 16),
  //                     Flexible(
  //                       flex: 4,
  //                       child: Row(
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           Flexible(
  //                             child: Container(
  //                               margin: EdgeInsets.only(
  //                                 top: 8,
  //                                 bottom: 8,
  //                               ),
  //                               child: canExchangeGift
  //                                   ? Align(
  //                                       alignment: Alignment.center,
  //                                       child: Text(
  //                                         "Đổi ngay",
  //                                         style: TextStyle(
  //                                           color:
  //                                               BeanOiTheme.palettes.primary400,
  //                                           fontSize: 18,
  //                                           fontWeight: FontWeight.bold,
  //                                         ),
  //                                         textAlign: TextAlign.center,
  //                                       ),
  //                                     )
  //                                   : RichText(
  //                                       text: TextSpan(
  //                                           text: "",
  //                                           style: BeanOiTheme
  //                                               .typography.subtitle2
  //                                               .copyWith(
  //                                                   color:
  //                                                       kDescriptionTextColor),
  //                                           children: <TextSpan>[
  //                                             TextSpan(
  //                                               text: "${userBean.ceil()}",
  //                                               style: TextStyle(
  //                                                 color: BeanOiTheme
  //                                                     .palettes.primary400,
  //                                                 fontSize: 18,
  //                                                 fontWeight: FontWeight.bold,
  //                                               ),
  //                                             ),
  //                                             TextSpan(
  //                                               text: "/${gift.price.ceil()}",
  //                                             ),
  //                                           ]),
  //                                     ),
  //                             ),
  //                           ),
  //                           SizedBox(width: 4),
  //                           Container(
  //                             width: 50,
  //                             height: 75,
  //                             // fit: BoxFit.fitWidth,
  //                             child: CacheImage(
  //                               imageUrl: gift.imageURL,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}

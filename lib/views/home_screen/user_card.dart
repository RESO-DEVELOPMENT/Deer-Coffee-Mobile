import 'package:barcode_widget/barcode_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

class UserCard extends StatefulWidget {
  const UserCard({super.key});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AccountViewModel>(
      model: Get.find<AccountViewModel>(),
      child: ScopedModelDescendant<AccountViewModel>(
          builder: (context, build, model) {
        return Container(
            margin: GetPlatform.isWeb || GetPlatform.isAndroid
                ? const EdgeInsets.fromLTRB(16, 90, 16, 16)
                : const EdgeInsets.fromLTRB(16, 120, 16, 16),
            child: CarouselSlider(
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                // autoPlay: true, // Tự động chuyển đổi ảnh
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: model.memberShipModel?.level?.membershipCard?.map((card) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        // Get.toNamed(
                        //   "${RouteHandler.BLOG}?id=${blog.id}",
                        // );
                      },
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          image: DecorationImage(
                              image: NetworkImage(
                                  card.membershipCardType?.cardImage ?? ""),
                              fit: BoxFit.cover),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.fromLTRB(8, 80, 8, 8),

                          width:
                              Get.width, // Chỉnh độ cao của container chứa ảnh
                          padding: const EdgeInsets.all(8), // Loại bỏ padding
                          child: BarcodeWidget(
                              barcode: Barcode.code128(),
                              drawText: true,
                              data: card.membershipCardCode ?? '',
                              style: Get.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ));
      }),
    );
  }
}

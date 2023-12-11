import 'package:deer_coffee/utils/route_constrant.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: GetPlatform.isAndroid || GetPlatform.isWeb
          ? const EdgeInsets.fromLTRB(8, 80, 8, 8)
          : const EdgeInsets.fromLTRB(8, 110, 8, 8),
      padding: const EdgeInsets.all(16),
      width: Get.width * 0.9,
      height: 200,
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
            'Để tích điểm và đổi những ưu đãi chỉ dành riêng cho thành viên bạn nhé !',
            style: Get.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/hinhchunhat.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: Get.width * 0.6,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ThemeColor.primary),
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(RouteHandler.LOGIN);
                      },
                      child: Text('Đăng nhập',
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodyLarge
                              ?.copyWith(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

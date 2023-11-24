import 'package:deer_coffee/utils/route_constrant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: GetPlatform.isIOS
          ? const EdgeInsets.fromLTRB(16, 120, 16, 16)
          : const EdgeInsets.fromLTRB(16, 100, 16, 16),
      padding: const EdgeInsets.all(4),
      width: Get.width * 0.9,
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
              Image.asset(
                'assets/images/hinhchunhat.png',
                height: 80,
                width: Get.width * 0.85,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 20,
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
                      Get.toNamed(RouteHandler.LOGIN);
                    },
                    child: Text('Đăng nhập',
                        textAlign: TextAlign.center,
                        style: Get.textTheme.bodyLarge
                            ?.copyWith(color: Colors.white)),
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

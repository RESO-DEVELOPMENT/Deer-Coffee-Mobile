import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAppBar extends StatefulWidget {
  const UserAppBar({super.key});

  @override
  State<UserAppBar> createState() => _UserAppBarState();
}

class _UserAppBarState extends State<UserAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.waving_hand_outlined),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Chào buổi sáng", style: Get.textTheme.titleMedium),
                  Text("Quốc Khánh", style: Get.textTheme.titleMedium),
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
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.blue,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.confirmation_num_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 3),
              Container(
                width: 50,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.notification_add_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 1,
    );
  }
}

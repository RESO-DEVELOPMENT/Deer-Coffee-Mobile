import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/store.dart';
import 'package:deer_coffee/view_models/cart_view_model.dart';
import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:scoped_model/scoped_model.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
        "Danh sách cửa hàng",
        style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      )),
      body: ScopedModel<MenuViewModel>(
        model: Get.find<MenuViewModel>(),
        child: ScopedModelDescendant<MenuViewModel>(
            builder: (context, build, model) {
          if (model.status == ViewStatus.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (model.storeList == []) {
            return Center(child: Text("Không có cửa hàng nào"));
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
                children: model.storeList!.map((e) => buildStore(e)).toList()),
          );
        }),
      ),
    );
  }

  Widget buildStore(StoreModel store) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      width: Get.width,
      height: 110,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFF7F8FB),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Image widget here
          Image.asset(
            'assets/images/logo.png',
            height: 80.0,
            width: 80.0,
          ),
          SizedBox(width: 4),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(store.name ?? '',
                    style: Get.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text(
                  store.address ?? '',
                  style: Get.textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

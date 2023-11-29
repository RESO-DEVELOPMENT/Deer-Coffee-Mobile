import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/route_constrant.dart';
import '../../widgets/other_dialogs/dialog.dart';

Future<void> showImageDialog() async {
  hideDialog();
  var dialog = Get.find<MenuViewModel>()
      .blogList
      ?.firstWhere((element) => element.isDialog == true);
  await Get.dialog(
    Dialog(
        child: AspectRatio(
      aspectRatio: 2 / 3,
      child: InkWell(
        onTap: () {
          Get.toNamed(
            "${RouteHandler.BLOG}?id=${dialog.id}",
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            dialog!.image!.isEmpty
                ? 'https://i.imgur.com/X0WTML2.jpg'
                : dialog.image ?? '',
            fit: BoxFit.cover,
          ),
        ),
      ),
    )),
  );
}

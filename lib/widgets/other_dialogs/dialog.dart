import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../utils/theme.dart';

Future<bool> showAlertDialog(
    {String title = "Thông báo",
    String content = "Nội dung thông báo",
    String confirmText = "Đồng ý"}) async {
  hideDialog();
  bool result = false;
  await Get.dialog(Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))),
    child: Container(
      width: Get.size.width * 0.3,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.background,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Get.theme.colorScheme.shadow,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: Get.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              content,
              style: Get.textTheme.bodyMedium,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  result = false;
                  hideDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColor.primary,
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Text(confirmText,
                    style: Get.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    ),
  ));
  return result;
}

Future<bool> showConfirmDialog(
    {String title = "Xác nhận",
    String content = "Bạn có chắc chắn muốn thực hiện thao tác này?",
    String confirmText = "Xác nhận",
    String cancelText = "Hủy"}) async {
  hideDialog();
  bool result = false;
  await Get.dialog(Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))),
    child: Container(
      width: Get.size.width * 0.5,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.background,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Get.theme.colorScheme.shadow,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: Get.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              content,
              style: Get.textTheme.bodyMedium,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  hideDialog();
                },
                child: Text(
                  cancelText,
                  style: Get.textTheme.titleMedium,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  hideDialog();
                  result = true;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColor.primary,
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Text(confirmText,
                    style: Get.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white)),
              ),
            ],
          )
        ],
      ),
    ),
  ));
  return result;
}

showLoadingDialog() {
  hideDialog();
  Get.dialog(Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))),
    child: Container(
      width: Get.size.width * 0.3,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.background,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Get.theme.colorScheme.shadow,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          Text(
            "Đang xử lý...",
            style: Get.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  ));
}

void hideDialog() {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
}

void hideSnackbar() {
  if (Get.isSnackbarOpen) {
    Get.back();
  }
}

void hideBottomSheet() {
  if (Get.isBottomSheetOpen ?? false) {
    Get.back();
  }
}

Future<String?> inputDialog(String title, String hint, String? value,
    {bool isNum = false}) async {
  hideDialog();
  String? result;
  await Get.dialog(AlertDialog(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    title: Text(
      title,
      style: Get.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
    ),
    content: TextField(
      keyboardType: isNum ? TextInputType.number : TextInputType.text,
      inputFormatters:
          isNum ? [FilteringTextInputFormatter.digitsOnly] : null, // Only numb
      controller: TextEditingController(text: value),
      decoration: InputDecoration(hintText: hint),
      onChanged: (value) {
        result = value;
      },
    ),
    actions: [
      TextButton(
          onPressed: () {
            Get.back(result: value);
          },
          child: const Text('Huỷ')),
      ElevatedButton(
        onPressed: () {
          Get.back(result: result);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColor.primary,
          textStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
        child: Text("Thêm",
            style: Get.textTheme.bodyMedium?.copyWith(color: Colors.white)),
      ),
    ],
  ));
  return result;
}

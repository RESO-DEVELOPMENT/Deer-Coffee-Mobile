import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomBottomSheet() {
  Get.bottomSheet(Container(
    height: 300,
    child: Column(
      children: [
        Row(
          children: [
            // Căn giữa văn bản
            Expanded(
              child: Center(
                child: Text(
                  'Chọn phương tiện giao hàng',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Căn giữa biểu tượng
            Center(
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 55.0), // Thêm khoảng cách sang trái
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Giao hàng',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    'Chọn phương thức',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
                  ),
                  Text(
                    'đặt hàng',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 60,
            ),
            ElevatedButton(
              onPressed: () {
                // Xử lý khi nút được nhấn
              },
              child: Text('Chọn địa chỉ'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(130, 40)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.blue), // Màu nền xanh
                foregroundColor: MaterialStateProperty.all(
                    Colors.white), // Đặt kích thước 100x40
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 55.0), // Thêm khoảng cách sang trái
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mang đi',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    'Bạn sẽ đến quầy nhận sản',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
                  ),
                  Text(
                    'phẩm tại cửa hàng và lấy ',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
                  ),
                  Text(
                    'mang đi',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            ElevatedButton(
              onPressed: () {
                // Xử lý khi nút được nhấn
              },
              child: Text('Chọn quán'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(130, 40)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.blue), // Màu nền xanh
                foregroundColor: MaterialStateProperty.all(
                    Colors.white), // Đặt kích thước 100x40
              ),
            ),
          ],
        ),
      ],
    ),
  ));
}

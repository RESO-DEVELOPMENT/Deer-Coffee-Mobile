import 'package:deer_coffee/enums/order_enum.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimelineWidget extends StatelessWidget {
  final String status;

  TimelineWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TimelineItem(
            title: showOrderStatus(OrderStatusEnum.PENDING),
            subTitle: "",
            isGray: !(status == OrderStatusEnum.PENDING ||
                status == OrderStatusEnum.PAID), // Hình tròn này sẽ có màu xanh
          ),
        ),
        Expanded(
          child: TimelineItem(
            title: showOrderStatus(OrderStatusEnum.PAID),
            subTitle: "",
            isGray: !(status ==
                OrderStatusEnum.PAID), // Hình tròn này sẽ có màu xám
          ),
        ),
        // TimelineItem(
        //   title: 'Đã giao',
        //   subTitle: '',
        //   isGray: true, // Hình tròn này sẽ có màu xám
        // ),
      ],
    );
  }
}

class TimelineItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isGray; // Thuộc tính để xác định màu xám

  TimelineItem(
      {required this.title, required this.subTitle, this.isGray = false});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(80.0, 40.0),
      painter: LinePainter(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.only(
              top: 50,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isGray
                  ? Colors.grey
                  : ThemeColor.primary, // Sử dụng màu xám nếu isGray là true
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(subTitle),
            ],
          ),
        ],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ThemeColor.primary // Màu đường nối
      ..strokeWidth = 2.0; // Độ rộng của đường nối
    final startX = 0.0; // X-coordinate của điểm bắt đầu đường nối
    final startY = size.height /
        2; // Y-coordinate của điểm bắt đầu đường nối (trung tâm của TimelineItem)
    final endX = Get.width; // X-coordinate của điểm kết thúc đường nối
    final endY = size.height /
        2; // Y-coordinate của điểm kết thúc đường nối (trung tâm của TimelineItem tiếp theo)

    canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

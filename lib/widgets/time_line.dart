import 'package:flutter/material.dart';

class TimelineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TimelineItem(
          title: 'Đặt hàng',
          subTitle: '',
          isGray: false, 
        ),
        TimelineItem(
          title: 'Processing',
          subTitle: '',
          isGray: false, 
        ),
        TimelineItem(
          title: 'Giao hàng',
          subTitle: '',
          isGray: true, 
        ),
        TimelineItem(
          title: 'Đã giao',
          subTitle: '',
          isGray: true, 
        ),
      ],
    );
  }
}

class TimelineItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isGray; 

  TimelineItem({required this.title, required this.subTitle, this.isGray = false});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100.0, 60.0),
      painter: LinePainter(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.only(
              left: 38.0,
              top: 50,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isGray ? Colors.grey : Colors.blue,
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 24,
            ),
          ),

          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(
              left: 29.0,
              bottom: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(subTitle),
              ],
            ),
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
      ..color = Colors.blue 
      ..strokeWidth = 2.0; 
    final startX = 0.0;
    final startY = size.height /
        2; 
    final endX = size.width * 1.6; 
    final endY = size.height /
        2; 

    canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

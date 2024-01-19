import 'package:deer_coffee/models/order_details.dart';
import 'package:deer_coffee/view_models/order_view_model.dart';
import 'package:deer_coffee/views/profile_screen/order_details.dart';
import 'package:flutter/material.dart';
import 'package:deer_coffee/models/transactions.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:get/get.dart';

class TransactionDetails extends StatefulWidget {
  final String id;
  const TransactionDetails({super.key, required this.id});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  OrderDetailsModel? orderDetails;
  @override
  void initState() {
    Get.find<OrderViewModel>()
        .getOrderDetails(widget.id)
        .then((value) => orderDetails = value);
    super.initState();
  }

  refreshOrder() {
    Get.find<OrderViewModel>().getOrderDetails(widget.id).then((value) {
      setState(() {
        orderDetails = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chi Tiết Giao Dịch'),
          backgroundColor: const Color.fromARGB(255, 14, 146, 255),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.add_business_outlined,
                          opticalSize: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(" ngân hàng 2 chân bank",
                                style: TextStyle(fontSize: 20)),
                            Text(" trừ tml m 19000d",
                                style: TextStyle(fontSize: 20)),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Trạng Thái'), Text('Thành Công')],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Created Date'), Text('12/02/2022')],
                      ),
                    ),
                    MySeparator(),
                    SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Amount'), Text('120,000đ')],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Type'), Text('Thanh Toán Hóa Đơn')],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Mã Giao Dịch'), Text('19284763463')],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Status'), Text('thành công')],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({super.key, this.height = 1, this.color = Colors.black});
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

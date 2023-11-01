import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:deer_coffee/widgets/time_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:scoped_model/scoped_model.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Chi Tiết Đơn Hàng',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      body: ScopedModel<MenuViewModel>(
        model: Get.find<MenuViewModel>(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: TimelineWidget(),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text('Deer Coffee',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text('Giảm giá ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                              Text('100.000',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10.0),
                                  child: Text('Cà phê sữa đá',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    'x1',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('25.000đ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10.0),
                                  child: Text('Cà phê đá',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    'x1',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('25.000đ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10.0),
                                  child: Text('Kiwi Ice Tea',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    'x1',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('25.000đ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                            ),
                          ],
                        ),
                          Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10.0),
                                  child: Text('Pink Ice Tea',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    'x1',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('25.000đ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 10,right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tổng quan đơn hàng : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Row(
                          children: [
                            Text('Tổng phụ',
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('200.000đ'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Vận chuyển',
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('0đ'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Giảm giá',
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('-100.000đ'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Tổng',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('100.000đ'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                   SizedBox(height: 10),
                 
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 10,right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Chi tiết đơn hàng : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Row(
                          children: [
                            Text('Số đơn hàng',
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('5780713690057732'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Ngày đặt hàng',
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('Oct 30, 2023 2:45 PM'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Phương thức thanh toán',
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('Cash on delivery'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Đang theo dõi hàng',
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('855769580385'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

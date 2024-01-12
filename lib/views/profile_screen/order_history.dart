import 'package:deer_coffee/enums/order_enum.dart';
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/order_in_list.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/view_models/order_view_model.dart';
import 'package:deer_coffee/views/profile_screen/transaction_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/user.dart';
import '../../utils/route_constrant.dart';
import '../../view_models/account_view_model.dart';
import '../login/login_card.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  AccountViewModel model = Get.find<AccountViewModel>();
  UserDetails? user;
  @override
  void initState() {
    user = model.memberShipModel;
    Get.find<OrderViewModel>().getListOrder(OrderStatusEnum.PENDING);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<OrderViewModel>(
      model: Get.find<OrderViewModel>(),
      child: ScopedModelDescendant<OrderViewModel>(
          builder: (context, build, model) {
        if (model.status == ViewStatus.Loading) {
          return SizedBox(
              width: Get.width,
              height: 240,
              child: const Center(child: CircularProgressIndicator()));
        }

        if (user == null) {
          return Center(child: LoginCard());
        }
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Hoạt động',
                style: Get.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              bottom: TabBar(
                indicatorColor: Get.theme.colorScheme.primary,
                tabs: [
                  Tab(text: 'Đơn hàng'),
                  Tab(text: 'Giao dịch'),
                ],
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: TabBarView(
              children: [
                ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          model.listOrder.map((e) => orderCard(e)).toList(),
                    )
                  ],
                ),
                TransactionsHistory(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget orderCard(OrderInList order) {
    return InkWell(
      onTap: () {
        Get.toNamed("${RouteHandler.ORDER_DETAILS}?id=${order.id}");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatTime(order.startDate ?? ''),
                    style: TextStyle(color: Colors.grey)),
                Text(formatPrice(order.finalAmount ?? 0),
                    style: Get.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(Icons.local_cafe,
                    color: Colors.grey, size: 16), // Biểu tượng cafe
                SizedBox(width: 5),
                Text(order.invoiceId ?? '', style: Get.textTheme.bodySmall),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(Icons.location_on,
                    color: Colors.grey, size: 16), // Biểu tượng vị trí
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    order.address ?? '',
                    style: Get.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

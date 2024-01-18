import 'dart:ui';

import 'package:deer_coffee/enums/order_enum.dart';
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/order_in_list.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/view_models/order_view_model.dart';
import 'package:deer_coffee/views/profile_screen/transaction_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import '../../models/transactions.dart';
import '../../models/user.dart';
import '../../utils/route_constrant.dart';
import '../../utils/theme.dart';
import '../../view_models/account_view_model.dart';
import '../login/login_card.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  AccountViewModel model = Get.find<AccountViewModel>();
  UserDetails? user;
  OrderViewModel orderViewModel = Get.find<OrderViewModel>();
  List<TransactionModel>? listTrans = [];
  @override
  void initState() {
    user = model.memberShipModel;
    orderViewModel.getListOrder(OrderStatusEnum.PENDING);
    orderViewModel.getListTransaction().then((value) => listTrans = value);
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
          return const Center(child: LoginCard());
        }
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: const Color(0xffF9F9F9),
            appBar: AppBar(
              title: Text(
                'Hoạt động',
                style: Get.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              bottom: TabBar(
                indicatorColor: ThemeColor.primary,
                tabs: const [
                  Tab(text: 'Đơn hàng'),
                  Tab(text: 'Giao dịch'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ListView(
                  children: model.listOrder.map((e) => orderCard(e)).toList(),
                ),
                ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          listTrans!.map((e) => transactionCard(e)).toList(),
                    )
                  ],
                )
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatTime(order.startDate ?? ''),
                    style:
                        Get.textTheme.labelSmall?.copyWith(color: Colors.grey)),
                Text(showOrderStatus(order.status ?? ''),
                    style: Get.textTheme.labelSmall?.copyWith(
                        color: order.status == OrderStatusEnum.PAID
                            ? Colors.teal
                            : order.status == OrderStatusEnum.CANCELED
                                ? Colors.redAccent
                                : Colors.grey)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.store,
                    color: Colors.grey, size: 16), // Biểu tượng cafe
                const SizedBox(width: 5),
                Text(order.storeName ?? '', style: Get.textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 4),
            order.address != null
                ? Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.grey, size: 16), // Biểu tượng vị trí
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          order.address ?? '',
                          style: Get.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(formatPrice(order.finalAmount ?? 0),
                  style: Get.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget transactionCard(TransactionModel transactionModel) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: InkWell(
          onTap: () {
            // Get.toNamed("${RouteHandler.ORDER_DETAILS}?id=${order.id}");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 4, 4, 4),
                child: transactionModel.type == TransactionTypeEnum.PAYMENT
                    ? const Icon(CupertinoIcons.creditcard,
                        color: Colors.green, size: 24)
                    : transactionModel.type == TransactionTypeEnum.GET_POINT
                        ? const Icon(
                            CupertinoIcons.money_dollar_circle,
                            color: Colors.green,
                            size: 24,
                          )
                        : transactionModel.type == TransactionTypeEnum.TOP_UP
                            ? const Icon(
                                Icons.account_balance_wallet,
                                color: Colors.blue,
                                size: 24,
                              )
                            : const Icon(Icons.info_outline),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          transactionModel.type == TransactionTypeEnum.PAYMENT
                              ? "Thanh toán đơn hàng"
                              : transactionModel.type ==
                                      TransactionTypeEnum.GET_POINT
                                  ? "Tích điểm thành viên"
                                  : transactionModel.type ==
                                          TransactionTypeEnum.TOP_UP
                                      ? "Nạp thẻ"
                                      : "Khác",
                          style: Get.textTheme.bodyMedium,
                        ),
                        Text(
                          "${transactionModel.isIncrease! ? " + " : " - "}${formatPrice(transactionModel.amount ?? 0)} ${transactionModel.currency!}",
                          style: Get.textTheme.bodyMedium?.copyWith(
                            color: transactionModel.isIncrease!
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4), // Add spacing between lines
                    Text(
                      formatTime(transactionModel.createdDate ?? ''),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}


// child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       formatTime(transactionModel.createdDate ?? ''),
//                       style: const TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//                 Text(
//                     "${transactionModel.isIncrease! ? " + " : " - "}${transactionModel.amount} ${transactionModel.currency!}",
//                     style: Get.textTheme.titleMedium?.copyWith(
//                         color: transactionModel.isIncrease!
//                             ? Colors.green
//                             : Colors.red))
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     transactionModel.isIncrease!
//                         ? const Icon(
//                             Icons.arrow_circle_up,
//                             color: Colors.green,
//                             grade: 10,
//                             size: 25,
//                           )
//                         : const Icon(
//                             Icons.arrow_circle_down,
//                             color: Colors.red,
//                             grade: 10,
//                             size: 25,
//                           ),
//                     Text(
//                         transactionModel.type == TransactionTypeEnum.PAYMENT
//                             ? "Thanh toán đơn hàng"
//                             : transactionModel.type ==
//                                     TransactionTypeEnum.GET_POINT
//                                 ? "Tích điểm thành viên"
//                                 : transactionModel.type ==
//                                         TransactionTypeEnum.TOP_UP
//                                     ? "Nạp thẻ"
//                                     : "Khác",
//                         style: Get.textTheme.titleMedium),
//                   ],
//                 ),
//                 Text(
//                     transactionModel.status == "SUCCESS"
//                         ? "Thành công"
//                         : "Thất bại",
//                     style: Get.textTheme.titleMedium?.copyWith(
//                         color: transactionModel.status == "SUCCESS"
//                             ? ThemeColor.primary
//                             : Colors.red)),
//               ],
//             ),
//           ],
//         ),
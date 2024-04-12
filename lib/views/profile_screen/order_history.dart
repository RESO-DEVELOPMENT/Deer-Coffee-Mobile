import 'package:deer_coffee/enums/order_enum.dart';
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/order_in_list.dart';
import 'package:deer_coffee/models/pointify/membership_info.dart';
import 'package:deer_coffee/models/pointify/membership_transaction.dart';
import 'package:deer_coffee/utils/format.dart';
import 'package:deer_coffee/view_models/order_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';
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
  MembershipInfo? user;
  OrderViewModel orderViewModel = Get.find<OrderViewModel>();
  List<MembershipTransaction>? listTrans = [];
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
            appBar: AppBar(
              title: Text(
                'Hoạt động',
                style: Get.textTheme.bodyMedium
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: const EdgeInsets.all(8),
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
                            ? Colors.greenAccent
                            : order.status == OrderStatusEnum.CANCELED
                                ? Colors.redAccent
                                : order.status == OrderStatusEnum.PENDING
                                    ? Colors.orangeAccent
                                    : Colors.grey)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.store,
                    color: Colors.grey, size: 16), // Biểu tượng cafe
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    order.storeName ?? '',
                    style: Get.textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
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
                : const SizedBox(),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(formatPrice(order.finalAmount ?? 0),
                  style: Get.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget transactionCard(MembershipTransaction transactionModel) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(8),
      child: InkWell(
          onTap: () {
            // Get.toNamed("${RouteHandler.ORDER_DETAILS}?id=${order.id}");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
                child: transactionModel.type == TransactionTypeEnum.PAYMENT
                    ? const Icon(CupertinoIcons.creditcard,
                        color: Colors.greenAccent, size: 24)
                    : transactionModel.type == TransactionTypeEnum.GET_POINT
                        ? const Icon(
                            CupertinoIcons.money_dollar_circle,
                            color: Colors.greenAccent,
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
                    Text(
                      transactionModel.description ?? "Khác",
                      style: Get.textTheme.labelSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formatTime(transactionModel.insDate ?? ''),
                          style: Get.textTheme.labelSmall
                              ?.copyWith(color: Colors.grey),
                        ),
                        Text(
                          "${transactionModel.isIncrease! ? " + " : " - "}${formatPrice(transactionModel.amount ?? 0)} ${transactionModel.currency!}",
                          style: Get.textTheme.labelMedium?.copyWith(
                            color: transactionModel.isIncrease!
                                ? Colors.greenAccent
                                : Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

import 'package:deer_coffee/enums/order_enum.dart';
import 'package:deer_coffee/models/transactions.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../enums/view_status.dart';
import '../../utils/format.dart';
import '../../view_models/order_view_model.dart';

class TransactionsHistory extends StatefulWidget {
  const TransactionsHistory({super.key});

  @override
  State<TransactionsHistory> createState() => _TransactionsHistoryState();
}

class _TransactionsHistoryState extends State<TransactionsHistory> {
  List<TransactionModel>? listTrans = [];
  OrderViewModel model = Get.find<OrderViewModel>();
  @override
  void initState() {
    model.getListTransaction().then((value) => listTrans = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lịch sử giao dịch",
          style:
              Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ScopedModel<OrderViewModel>(
        model: model,
        child: ScopedModelDescendant<OrderViewModel>(
            builder: (context, build, model) {
          if (model.status == ViewStatus.Loading) {
            return Container(
                width: Get.width,
                height: 200,
                child: Center(child: CircularProgressIndicator()));
          } else if (listTrans == []) {
            return Scaffold(
              body: Center(
                child: Text("Hiện không có giao dịch nào"),
              ),
            );
          }

          return ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listTrans!.map((e) => transactionCard(e)).toList(),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget transactionCard(TransactionModel transactionModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Get.toNamed("${RouteHandler.ORDER_DETAILS}?id=${order.id}");
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(formatTime(transactionModel.createdDate ?? ''),
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                Text(
                    "${transactionModel.isIncrease! ? " + " : " - "}${transactionModel.amount} ${transactionModel.currency!}",
                    style: Get.textTheme.titleMedium?.copyWith(
                        color: transactionModel.isIncrease!
                            ? Colors.green
                            : Colors.red))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    transactionModel.type == TransactionTypeEnum.PAYMENT
                        ? "Thanh toán đơn hàng"
                        : transactionModel.type == TransactionTypeEnum.GET_POINT
                            ? "Tích điểm thành viên"
                            : transactionModel.type ==
                                    TransactionTypeEnum.TOP_UP
                                ? "Nạp thẻ"
                                : "Khác",
                    style: Get.textTheme.titleMedium),
                Text(
                    transactionModel.status == "SUCCESS"
                        ? "Thành công"
                        : "Thất bại",
                    style: Get.textTheme.titleMedium?.copyWith(
                        color: transactionModel.status == "SUCCESS"
                            ? ThemeColor.primary
                            : Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
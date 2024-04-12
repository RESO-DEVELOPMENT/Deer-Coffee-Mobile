import 'package:deer_coffee/enums/order_enum.dart';
import 'package:deer_coffee/models/pointify/membership_transaction.dart';
import 'package:deer_coffee/models/transactions.dart';
import 'package:deer_coffee/utils/route_constrant.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:flutter/material.dart';
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
  List<MembershipTransaction>? listTrans = [];
  OrderViewModel model = Get.find<OrderViewModel>();
  @override
  void initState() {
    model.getListTransaction().then((value) => listTrans = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModel<OrderViewModel>(
        model: model,
        child: ScopedModelDescendant<OrderViewModel>(
            builder: (context, build, model) {
          if (model.status == ViewStatus.Loading) {
            return SizedBox(
                width: Get.width,
                height: 200,
                child: const Center(child: CircularProgressIndicator()));
          } else if (listTrans == []) {
            return const Scaffold(
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

  Widget transactionCard(MembershipTransaction transactionModel) {
    return InkWell(
      onTap: () {
        Get.toNamed(
            "${RouteHandler.Transaction_Detail}?id=${transactionModel.id}");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                    Text(formatTime(transactionModel.insDate ?? ''),
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                Text(
                    "${transactionModel.isIncrease! ? " + " : " - "}${transactionModel.amount} ${transactionModel.currency!}",
                    style: Get.textTheme.titleMedium?.copyWith(
                        color: transactionModel.isIncrease!
                            ? Colors.green
                            : Colors.red)),
                Text("${transactionModel.id}",
                    style: const TextStyle(color: Colors.amber))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(transactionModel.description ?? "Khác",
                    style: Get.textTheme.titleMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

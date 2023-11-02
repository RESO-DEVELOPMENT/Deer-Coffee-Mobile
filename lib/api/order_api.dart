import '../models/order.dart';
import '../models/order_details.dart';
import '../models/order_in_list.dart';
import '../models/order_response.dart';
import '../utils/request.dart';

class OrderAPI {
  Future placeOrder(OrderModel order) async {
    var dataJson = order.toJson();
    final res = await request.post('users/order', data: dataJson);
    var jsonList = res.data;
    return jsonList;
  }

  Future<OrderResponseModel> getOrderOfStore(
      String storeId, String orderId) async {
    final res = await request.get('stores/$storeId/orders/$orderId');
    var jsonList = res.data;
    OrderResponseModel orderResponse = OrderResponseModel.fromJson(jsonList);
    return orderResponse;
  }

  Future updateOrder(
    String storeId,
    String orderId,
    String? status,
    String? paymentType,
  ) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['paymentType'] = paymentType;
    final res =
        await request.put('stores/$storeId/orders/$orderId', data: data);
    var json = res.data;
    return json;
  }

  // Future<MakePaymentResponse> makePayment(
  //     OrderResponseModel order, String paymentId) async {
  //   Account? user = await getUserInfo();
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['orderId'] = order.orderId;
  //   data['invoiceId'] = order.invoiceId;
  //   data['storeId'] = user?.storeId;
  //   data['accountId'] = user?.id;
  //   data['paymentId'] = paymentId;
  //   data['amount'] = order.finalAmount;
  //   data['orderDescription'] = "Thanh toán đơn hàng ${order.invoiceId} ";
  //   final res = await paymentRequest.post('payments', data: data);
  //   var json = res.data;
  //   MakePaymentResponse makePaymentResponse =
  //       MakePaymentResponse.fromJson(json);
  //   return makePaymentResponse;
  // }

  Future<List<OrderInList>> getListOrderOfUser(String userId,
      {String? orderStatus}) async {
    var params = <String, dynamic>{
      'page': 1,
      'size': 100,
      'status': orderStatus
    };
    final res =
        await request.get('users/$userId/orders', queryParameters: params);
    var jsonList = res.data['items'];
    List<OrderInList> listOrder = [];
    for (var item in jsonList) {
      OrderInList orderResponse = OrderInList.fromJson(item);
      listOrder.add(orderResponse);
    }
    return listOrder;
  }

  Future<OrderDetailsModel> getOrderDetails(
    String orderId,
  ) async {
    final res = await request.get('users/orders/$orderId');
    var json = res.data;

    OrderDetailsModel orderResponse = OrderDetailsModel.fromJson(json);
    return orderResponse;
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce/core/api.dart';
import 'package:ecommerce/data/models/order/order_model.dart';

class OrderRepository {
  final Api _api = Api();

  // fetch orders
  Future<List<OrderModel>> fetchCartForUser(String userId) async {
    try {
      Response response = await _api.sendRequest.get("/order/$userId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => OrderModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // create orders
  Future<OrderModel> createOrders(OrderModel orderModel) async {
    try {
      Response response = await _api.sendRequest.post(
        "/order",
        data: jsonEncode(orderModel.toJson()),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return OrderModel.fromJson(apiResponse.data);
    } catch (e) {
      rethrow;
    }
  }

}

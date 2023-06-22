import 'dart:convert';

import 'package:ecommerce/data/models/cart/cart_item_model.dart';
import 'package:ecommerce/data/models/user_model.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String? id;
  String status;
  DateTime? updatedOn;
  DateTime? createdOn;
  UserModel? user;
  List<CartItemModel>? items;

  OrderModel({
    this.id,
    required this.status,
    this.updatedOn,
    this.createdOn,
    required this.user,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["_id"],
        status: json["status"],
        updatedOn: DateTime.parse(json["updatedOn"]),
        createdOn: DateTime.parse(json["createdOn"]),
        user: UserModel.fromJson(json["user"]),
        items: (json["items"] as List<dynamic>)
            .map((item) => CartItemModel.fromJson(item))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "updatedOn": updatedOn!.toIso8601String(),
        "createdOn": createdOn!.toIso8601String(),
        "user": user!.toJson(),
        "items": items!.map((item) => item.toJson(objectMode: true)).toList()
      };
}

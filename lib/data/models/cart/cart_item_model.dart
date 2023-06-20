import 'dart:convert';

import 'package:ecommerce/data/models/product/product_model.dart';

CartItemModel cartItemModelFromJson(String str) =>
    CartItemModel.fromJson(json.decode(str));

String cartItemModelToJson(CartItemModel data) => json.encode(data.toJson());

class CartItemModel {
  ProductModel? product;
  int quantity;
  String? id;

  CartItemModel({
    required this.product,
    required this.quantity,
    this.id,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        product: ProductModel.fromJson(json["product"]),
        quantity: json["quantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product!.id,
        "quantity": quantity,
        "_id": id,
      };
}

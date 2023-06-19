// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

CategoryModel userModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String userModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  String id;
  String fullName;
  String email;
  String password;
  String phoneNumber;
  String city;
  String state;
  String userModelId;
  DateTime updatedOn;
  DateTime createdOn;

  CategoryModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.city,
    required this.state,
    required this.userModelId,
    required this.updatedOn,
    required this.createdOn,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        city: json["city"],
        state: json["state"],
        userModelId: json["id"],
        updatedOn: DateTime.parse(json["updatedOn"]),
        createdOn: DateTime.parse(json["createdOn"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "city": city,
        "state": state,
        "id": userModelId,
        "updatedOn": updatedOn.toIso8601String(),
        "createdOn": createdOn.toIso8601String(),
      };
}

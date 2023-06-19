import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    String id;
    String title;
    String description;
    DateTime updatedOn;
    DateTime createdOn;

    CategoryModel({
        required this.id,
        required this.title,
        required this.description,
        required this.updatedOn,
        required this.createdOn,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        updatedOn: DateTime.parse(json["updatedOn"]),
        createdOn: DateTime.parse(json["createdOn"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "updatedOn": updatedOn.toIso8601String(),
        "createdOn": createdOn.toIso8601String(),
    };
}

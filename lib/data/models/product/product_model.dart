import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    String id;
    String category;
    String title;
    String description;
    int price;
    List<String>? images;
    DateTime updatedOn;
    DateTime createdOn;

    ProductModel({
        required this.id,
        required this.category,
        required this.title,
        required this.description,
        required this.price,
        required this.images,
        required this.updatedOn,
        required this.createdOn,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        category: json["category"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        images: List<String>.from(json["images"].map((x) => x)),
        updatedOn: DateTime.parse(json["updatedOn"]),
        createdOn: DateTime.parse(json["createdOn"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "category": category,
        "title": title,
        "description": description,
        "price": price,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "updatedOn": updatedOn.toIso8601String(),
        "createdOn": createdOn.toIso8601String(),
    };
}

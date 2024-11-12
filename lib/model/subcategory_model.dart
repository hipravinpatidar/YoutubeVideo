
// To parse this JSON data, do
//
//     final kathaModel = kathaModelFromJson(jsonString);

import 'dart:convert';

List<KathaModel> kathaModelFromJson(String str) => List<KathaModel>.from(json.decode(str).map((x) => KathaModel.fromJson(x)));

String kathaModelToJson(List<KathaModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KathaModel {
  int id;
  int categoryId;
  String name;
  String image;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> translations;

  KathaModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.translations,
  });

  factory KathaModel.fromJson(Map<String, dynamic> json) => KathaModel(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    image: json["image"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    translations: List<dynamic>.from(json["translations"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "image": image,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "translations": List<dynamic>.from(translations.map((x) => x)),
  };
}

// To parse this JSON data, do
//
//     final videoTypeModel = videoTypeModelFromJson(jsonString);

import 'dart:convert';

VideolistType videoTypeModelFromJson(String str) => VideolistType.fromJson(json.decode(str));

String videoTypeModelToJson(VideolistType data) => json.encode(data.toJson());

// class VideoTypeModel {
//   int status;
//   List<VideolistType> videolistType;
//
//   VideoTypeModel({
//     required this.status,
//     required this.videolistType,
//   });
//
//   factory VideoTypeModel.fromJson(Map<String, dynamic> json) => VideoTypeModel(
//     status: json["status"],
//     videolistType: List<VideolistType>.from(json["videolistType"].map((x) => VideolistType.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "videolistType": List<dynamic>.from(videolistType.map((x) => x.toJson())),
//   };
// }

class VideolistType {
  int id;
  String name;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  VideolistType({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VideolistType.fromJson(Map<String, dynamic> json) => VideolistType(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

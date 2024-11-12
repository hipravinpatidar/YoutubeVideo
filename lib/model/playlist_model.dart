// // To parse this JSON data, do
// //
// //     final playListModel = playListModelFromJson(jsonString);
//
// import 'dart:convert';
//
// PlayListModel playListModelFromJson(String str) => PlayListModel.fromJson(json.decode(str));
//
// String playListModelToJson(PlayListModel data) => json.encode(data.toJson());
//
// class PlayListModel {
//   int status;
//   List<Datum> data;
//
//   PlayListModel({
//     required this.status,
//     required this.data,
//   });
//
//   factory PlayListModel.fromJson(Map<String, dynamic> json) => PlayListModel(
//     status: json["status"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   int categoryId;
//   int subcategoryId;
//   String listType;
//   String playlistName;
//   List<Video> videos;
//
//   Datum({
//     required this.categoryId,
//     required this.subcategoryId,
//     required this.listType,
//     required this.playlistName,
//     required this.videos,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     categoryId: json["category_id"],
//     subcategoryId: json["subcategory_id"],
//     listType: json["list_type"],
//     playlistName: json["playlist_name"] ?? '',
//     videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "category_id": categoryId,
//     "subcategory_id": subcategoryId,
//     "list_type": listType,
//     "playlist_name": playlistName,
//     "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
//   };
// }
//
// class Video {
//   String title;
//   String url;
//   String image;
//
//   Video({
//     required this.title,
//     required this.url,
//     required this.image,
//   });
//
//   factory Video.fromJson(Map<String, dynamic> json) => Video(
//     title: json["title"],
//     url: json["url"],
//     image: json["image"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "title": title,
//     "url": url,
//     "image": image,
//   };
// }
//
//
//

// This is

// To parse this JSON data, do
//
//     final playListModel = playListModelFromJson(jsonString);

// import 'dart:convert';
//
// PlayListModel playListModelFromJson(String str) => PlayListModel.fromJson(json.decode(str));
//
// String playListModelToJson(PlayListModel data) => json.encode(data.toJson());
//
// class PlayListModel {
//   int status;
//   List<Datum> data;
//
//   PlayListModel({
//     required this.status,
//     required this.data,
//   });
//
//   factory PlayListModel.fromJson(Map<String, dynamic> json) => PlayListModel(
//     status: json["status"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   int categoryId;
//   int subcategoryId;
//   String listType;
//   String playlistName;
//   int status;
//   List<Video> videos;
//
//   Datum({
//     required this.categoryId,
//     required this.subcategoryId,
//     required this.listType,
//     required this.playlistName,
//     required this.status,
//     required this.videos,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     categoryId: json["category_id"],
//     subcategoryId: json["subcategory_id"],
//     listType: json["list_type"],
//     playlistName: json["playlist_name"],
//     status: json["status"],
//     videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "category_id": categoryId,
//     "subcategory_id": subcategoryId,
//     "list_type": listType,
//     "playlist_name": playlistName,
//     "status": status,
//     "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
//   };
// }
//
// class Video {
//   String title;
//   String url;
//   String image;
//   String urlStatus;
//
//   Video({
//     required this.title,
//     required this.url,
//     required this.image,
//     required this.urlStatus,
//   });
//
//   factory Video.fromJson(Map<String, dynamic> json) => Video(
//     title: json["title"],
//     url: json["url"],
//     image: json["image"],
//     urlStatus: json["url_status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "title": title,
//     "url": url,
//     "image": image,
//     "url_status": urlStatus,
//   };
// }


// import 'dart:convert';
//
// PlayListModel playListModelFromJson(String str) => PlayListModel.fromJson(json.decode(str));
//
// String playListModelToJson(PlayListModel data) => json.encode(data.toJson());
//
// class PlayListModel {
//   int status;
//   List<Datum> data;
//
//   PlayListModel({
//     required this.status,
//     required this.data,
//   });
//
//   factory PlayListModel.fromJson(Map<String, dynamic> json) => PlayListModel(
//     status: json["status"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   int categoryId;
//   int subcategoryId;
//   String? listType;
//   String? playlistName;
//   int status;
//   List<Video> videos;
//
//   Datum({
//     required this.categoryId,
//     required this.subcategoryId,
//     required this.listType,
//     required this.playlistName,
//     required this.status,
//     required this.videos,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     categoryId: json["category_id"],
//     subcategoryId: json["subcategory_id"],
//     listType: json["list_type"],
//     playlistName: json["playlist_name"],
//     status: json["status"],
//     videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "category_id": categoryId,
//     "subcategory_id": subcategoryId,
//     "list_type": listType,
//     "playlist_name": playlistName,
//     "status": status,
//     "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
//   };
// }
//
// class Video {
//   String title;
//   String url;
//   String image;
//   int urlStatus; // Change to int to match the response
//
//   Video({
//     required this.title,
//     required this.url,
//     required this.image,
//     required this.urlStatus,
//   });
//
//   factory Video.fromJson(Map<String, dynamic> json) => Video(
//     title: json["title"],
//     url: json["url"],
//     image: json["image"],
//     urlStatus: json["url_status"], // Change to int
//   );
//
//   Map<String, dynamic> toJson() => {
//     "title": title,
//     "url": url,
//     "image": image,
//     "url_status": urlStatus, // Change to int
//   };
// }

class PlayListModel {
  final List<Datum> data;

  PlayListModel({required this.data});

  factory PlayListModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List<dynamic>;
    List<Datum> data = dataList.map((i) => Datum.fromJson(i)).toList();
    return PlayListModel(data: data);
  }
}

class Datum {
  final int categoryId;
  final int subcategoryId;
  final String? listType;
  final String? playlistName;
  final int status;
  final List<Video> videos;

  Datum({
    required this.categoryId,
    required this.subcategoryId,
    this.listType,
    this.playlistName,
    required this.status,
    required this.videos,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    var videoList = json['videos'] as List<dynamic>;
    List<Video> videos = videoList.map((i) => Video.fromJson(i)).toList();
    return Datum(
      categoryId: json['category_id'] as int,
      subcategoryId: json['subcategory_id'] as int,
      listType: json['list_type'] as String?,
      playlistName: json['playlist_name'] as String?,
      status: json['status'] as int,
      videos: videos,
    );
  }
}

class Video {
  final String title;
  final String url;
  final String image;
  final int urlStatus;

  Video({
    required this.title,
    required this.url,
    required this.image,
    required this.urlStatus,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      title: json['title'] as String,
      url: json['url'] as String,
      image: json['image'] as String,
      urlStatus: json['url_status'] as int,
    );
  }
}

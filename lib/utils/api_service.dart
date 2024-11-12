import 'dart:convert';
import 'package:http/http.dart' as https;

class ApiService {
  // Category API

  final urlCategory =
      'https://mahakal.rizrv.in/api/v1/astro/youtube/video/category';
  Future getCategory(String url) async {
    final response = await https.get(Uri.parse(urlCategory));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return jsonBody;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Sub Category API

  Future getSubcategory(String url) async {
    final response = await https.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return jsonBody;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Video Type Tabs API

  // Future getVideoTabs(String url) async {
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     final jsonBody = jsonDecode(response.body);
  //     return jsonBody;
  //   } else {
  //     throw Exception('Failed to load tabs');
  //   }
  // }

  // New Tabs

  // Future getTabs(String url) async{
  //   final response =  await http.get(Uri.parse(url));
  //   if(response.statusCode == 200){
  //     final jsonBody = jsonDecode(response.body);
  //     return jsonBody;
  //   }else{
  //     throw Exception('Failed to load Tabs');
  //   }
  //
  // }

  Future<Map<String, dynamic>>  getTabs(String url) async {
    final response = await https.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load tabs');
    }
  }

  // PlayList Video API

  Future getPlayList(String url) async {
    final response = await https.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      return jsonBody;
    } else {
      throw Exception('Failed to load videos');
    }
  }
}

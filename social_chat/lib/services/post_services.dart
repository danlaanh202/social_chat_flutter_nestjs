import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:social_chat/models/status.model.dart';
import 'package:social_chat/services/auth_services.dart';
import 'package:social_chat/services/shared_pref_service.dart';

class PostServices {
  static String _baseUrl = "http://192.168.0.105:4000";

  static List<Status?> parseStatus(responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Status> statusList =
        list.map((model) => Status.fromJson(model)).toList();
    return statusList;
  }

  static Future<String?> uploadFileToServer(
      String filePath, String? description) async {
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    String? userId = await SharedPreferencesServices.getData("userId");
    var url = Uri.parse(
      '$_baseUrl/post/create',
    ); // Thay YOUR_UPLOAD_ENDPOINT_URL bằng URL của API endpoint trên máy chủ

    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    request.fields["my_id"] = userId!;
    request.fields["description"] = description ?? "";

    request.headers["Authorization"] = "Bearer $accessToken";

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Upload thành công!');
      return "Thành công";
    } else {
      print('Lỗi khi tải lên tệp tin: ${response.statusCode}');
    }
  }

  static Future<List<Status?>> getStatus() async {
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    String? userId = await SharedPreferencesServices.getData("userId");
    final response = await http.get(
      Uri.parse("$_baseUrl/post/get?user_id=$userId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $accessToken",
      },
    );
    if (response.statusCode == 200) {
      return parseStatus(response.body);
    } else if (response.statusCode == 401) {
      AuthServices.handle401Error();
      throw Exception(
          "Failed to load posts ${response.statusCode} $userId $accessToken");
    } else {
      throw Exception("${response.statusCode}");
    }
  }

  static Future<List<Status?>> getPostsOfId() async {
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    String? userId = await SharedPreferencesServices.getData("userId");
    final response = await http.get(
      Uri.parse("$_baseUrl/post/get_posts_of_id?user_id=$userId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $accessToken",
      },
    );
    if (response.statusCode == 200) {
      return parseStatus(response.body);
    } else if (response.statusCode == 401) {
      AuthServices.handle401Error();
      throw Exception(
          "Failed to load posts ${response.statusCode} $userId $accessToken");
    } else {
      throw Exception("${response.statusCode}");
    }
  }
}

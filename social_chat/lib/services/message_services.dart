import 'dart:convert';

import 'package:social_chat/models/message.model.dart';
import 'package:social_chat/services/auth_services.dart';
import 'package:social_chat/services/shared_pref_service.dart';
import "package:http/http.dart" as http;

class MessageServices {
  static const String _baseUrl = "http://192.168.0.105:4000";
  static List<Message> parseMessage(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Message> friends =
        list.map((model) => Message.fromJson(model)).toList();
    return friends;
  }

  static Future<List<Message?>> getMessages(String? roomId) async {
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    String? userId = await SharedPreferencesServices.getData("userId");
    final response = await http.get(
      Uri.parse("$_baseUrl/message/get?room_id=$roomId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $accessToken",
      },
    );
    if (response.statusCode == 200) {
      return parseMessage(response.body);
    } else if (response.statusCode == 401) {
      AuthServices.handle401Error();
      throw Exception(
          "Failed to load friends ${response.statusCode} $userId $accessToken");
    } else {
      throw Exception("${response.statusCode}");
    }
  }

  static Future<Message?> createMessage(String roomId, String content) async {
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    String? userId = await SharedPreferencesServices.getData("userId");
    final response = await http.post(
      Uri.parse("$_baseUrl/message/create"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode(
        <String, String>{
          "content": content,
          "chat_id": roomId,
          "my_id": userId!,
        },
      ),
    );
    if (response.statusCode == 201) {
      return Message.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      AuthServices.handle401Error();
      throw Exception(
          "Failed to load friends ${response.statusCode} $userId $accessToken");
    } else {
      throw Exception("${response.statusCode}");
    }
  }
}

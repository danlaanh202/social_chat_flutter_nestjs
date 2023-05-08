import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_chat/models/chatRoom.model.dart';
import 'package:social_chat/services/auth_services.dart';
import 'package:social_chat/services/shared_pref_service.dart';

class ChatServices {
  static const String _baseUrl = "http://192.168.0.105:4000";
  static List<ChatRoom> parseChatRoom(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<ChatRoom> friends =
        list.map((model) => ChatRoom.fromJson(model)).toList();
    return friends;
  }

  static Future<String?> createChat(String recipientId, String? name) async {
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    String? userId = await SharedPreferencesServices.getData("userId");
    final response = await http.post(
      Uri.parse('$_baseUrl/chat/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode(
        <String, String>{
          'my_id': userId!,
          'recipient_id': recipientId,
          "name": name ?? "New Chat",
        },
      ),
    );
    if (response.statusCode == 201) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['id'];
    } else if (response.statusCode == 401) {
      AuthServices.handle401Error();
    } else {
      throw Exception("Can not create chat, ${response.statusCode}");
    }
  }

  static Future<List<ChatRoom>?> getChats() async {
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    String? userId = await SharedPreferencesServices.getData("userId");
    final response = await http.get(
      Uri.parse('$_baseUrl/chat/get?my_id=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $accessToken",
      },
    );
    if (response.statusCode == 200) {
      return parseChatRoom(response.body);
    } else if (response.statusCode == 401) {
      AuthServices.handle401Error();
    } else {
      throw Exception(
          "Failed to load friends ${response.statusCode} $userId $accessToken");
    }
  }

  static Future<ChatRoom?> getChatRoom(String roomId) async {
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    String? userId = await SharedPreferencesServices.getData("userId");
    final response = await http.get(
      Uri.parse("$_baseUrl/chat/get_by_id?room_id=$roomId&my_id=$userId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $accessToken",
      },
    );
    if (response.statusCode == 200) {
      return ChatRoom.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      AuthServices.handle401Error();
    } else {
      throw Exception("Failed to get chat room ${response.statusCode}");
    }
  }
}

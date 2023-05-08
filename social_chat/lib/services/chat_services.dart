import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_chat/services/shared_pref_service.dart';

class ChatServices {
  static const String _baseUrl = "http://192.168.0.105:4000";
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
    } else {
      throw Exception("Can not create chat, ${response.statusCode}");
    }
  }
}

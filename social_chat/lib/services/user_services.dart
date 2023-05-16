import 'dart:convert';

import 'package:social_chat/models/auth.model.dart';
import 'package:social_chat/services/auth_services.dart';
import 'package:social_chat/services/shared_pref_service.dart';
import "package:http/http.dart" as http;

class UserServices {
  static String _baseUrl = "http://192.168.0.105:4000";
  static Future<Auth?> getMyUser(String? userId) async {
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    // String? userId = await SharedPreferencesServices.getData("userId");
    final response = await http.get(
      Uri.parse("$_baseUrl/user/get_user?user_id=$userId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $accessToken",
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      return Auth.fromJson(responseBody);
    } else if (response.statusCode == 401) {
      AuthServices.handle401Error();
    } else {
      throw Exception(
          'Failed to login. Status code: ${response.statusCode}. Error: ${response.reasonPhrase}.');
    }
  }
}

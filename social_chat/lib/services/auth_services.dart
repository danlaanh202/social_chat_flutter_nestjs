import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_chat/main.dart';

import 'package:social_chat/services/shared_pref_service.dart';

class AuthServices {
  static const String _baseUrl = "http://192.168.0.105:4000";
  static Future<dynamic> getCurrentAccessToken() async {
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    return accessToken;
  }

  static Future<String?> login(username, password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/sign-in'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      SharedPreferencesServices.saveData(
          "accessToken", responseBody["accessToken"]);
      SharedPreferencesServices.saveData("userId", responseBody["id"]);
      SharedPreferencesServices.saveData("username", responseBody["username"]);
      SharedPreferencesServices.saveData("email", responseBody["email"]);
      return responseBody['accessToken'];
    } else if (response.statusCode == 401) {
      handle401Error();
    } else {
      throw Exception(
          'Failed to login. Status code: ${response.statusCode}. Error: ${response.reasonPhrase}.');
    }
    return null;
  }

  static Future<void> logout() async {
    await SharedPreferencesServices.removeData('accessToken');
    await SharedPreferencesServices.removeData('userId');
    await SharedPreferencesServices.removeData('username');
    await SharedPreferencesServices.removeData('email');
  }

  static Future<String?> signUp(email, username, password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/sign-up'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        "email": email,
      }),
    );
    if (response.statusCode == 201) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['id'];
    } else if (response.statusCode == 401) {
      handle401Error();
    } else {
      throw Exception(
          'Failed to login. Status code: ${response.statusCode}. Error: ${response.reasonPhrase}.');
    }
  }

  static Future<bool> isLoggedIn() async {
    final accessToken = await SharedPreferencesServices.getData("accessToken");
    return accessToken != null;
  }

  static handle401Error() {
    logout();
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil("/login", (route) => false);
  }
}

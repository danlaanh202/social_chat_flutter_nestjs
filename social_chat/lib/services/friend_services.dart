import 'dart:convert';

import 'package:social_chat/models/friend.model.dart';
import 'package:http/http.dart' as http;
import 'package:social_chat/services/auth_services.dart';
import 'package:social_chat/services/shared_pref_service.dart';

class FriendServices {
  static const String _baseUrl = "http://192.168.0.105:4000";
  static List<Friend> parseFriend(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Friend> friends = list.map((model) => Friend.fromJson(model)).toList();
    return friends;
  }

  static Future<List<Friend>> searchFriends({String searchQuery = ""}) async {
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    String? userId = await SharedPreferencesServices.getData("userId");
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/user/get_all_friends?my_id=$userId&search_query=$searchQuery'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $accessToken",
      },
    );
    if (response.statusCode == 200) {
      return parseFriend(response.body);
    } else if (response.statusCode == 401) {
      AuthServices.handle401Error();
      throw Exception(
          "Failed to load friends ${response.statusCode} $userId $accessToken");
    } else {
      throw Exception(
          "Failed to load friends ${response.statusCode} $userId $accessToken");
    }
  }

  static Future<List<Friend>> searchUsers({String searchQuery = ""}) async {
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    String? userId = await SharedPreferencesServices.getData("userId");
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/user/search?my_id=$userId&search_query=$searchQuery'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $accessToken",
      },
    );
    if (response.statusCode == 200) {
      return parseFriend(response.body);
    } else if (response.statusCode == 401) {
      AuthServices.handle401Error();
      throw Exception(
          "Failed to load friends ${response.statusCode} $userId $accessToken");
    } else {
      throw Exception(
          "Failed to load friends ${response.statusCode} $userId $accessToken");
    }
  }
}

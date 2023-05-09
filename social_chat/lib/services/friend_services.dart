import 'dart:convert';

import 'package:social_chat/models/friend.model.dart';
import 'package:http/http.dart' as http;
import 'package:social_chat/models/friend_request.model.dart';
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

  static Future<List<Friend>> searchUsers({
    String searchQuery = "",
    int? typeIndex = 0,
  }) async {
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    String? userId = await SharedPreferencesServices.getData("userId");

    String urlString() {
      switch (typeIndex) {
        case 0:
          return '$_baseUrl/user/search?my_id=$userId&search_query=$searchQuery';
        case 1:
          return '$_baseUrl/user/search_sent_users?my_id=$userId&search_query=$searchQuery';
        case 2:
          return '$_baseUrl/user/search_received_users?my_id=$userId&search_query=$searchQuery';
        default:
          return '$_baseUrl/user/search?my_id=$userId&search_query=$searchQuery';
      }
    }

    final response = await http.get(
      Uri.parse(
        urlString(),
      ),
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

  static Future<FriendRequest> sendFriendRequestByUserIds(
      {required String recipientId}) async {
    String apiUrl = "$_baseUrl/friend/send";
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    String? userId = await SharedPreferencesServices.getData("userId");
    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(<String, String?>{
          "requester_id": userId,
          "recipient_id": recipientId,
        }));
    if (response.statusCode == 201) {
      return FriendRequest.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      AuthServices.handle401Error();
      throw Exception(
          "Failed to load friends ${response.statusCode} $userId $accessToken");
    } else {
      throw Exception("Lỗi ở send friend request");
    }
  }

  static Future<FriendRequest> acceptFriendRequestByUserIds(
      {required String requesterId}) async {
    String apiUrl = "$_baseUrl/friend/accept_by_user_ids";
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    String? userId = await SharedPreferencesServices.getData("userId");
    final response = await http.put(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(<String, String?>{
          "requester_id": requesterId,
          "recipient_id": userId,
        }));
    if (response.statusCode == 200) {
      return FriendRequest();
    } else if (response.statusCode == 401) {
      AuthServices.handle401Error();
      throw Exception(
          "Failed to load friends ${response.statusCode} $userId $accessToken");
    } else {
      throw Exception("Lỗi ở send friend request");
    }
  }

  static Future<FriendRequest> removeFriendRequestOrFriend({
    required String friendId,
  }) async {
    String? accessToken =
        await SharedPreferencesServices.getData("accessToken");
    String? userId = await SharedPreferencesServices.getData("userId");
    String apiUrl =
        "$_baseUrl/friend/remove_by_user_ids?user_id_1=$userId&user_id_2=$friendId";
    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      return FriendRequest();
    } else if (response.statusCode == 401) {
      AuthServices.handle401Error();
      throw Exception(
          "Failed to load friends ${response.statusCode} $userId $accessToken");
    } else {
      throw Exception("Lỗi ở send friend request");
    }
  }
}

import 'package:social_chat/models/auth.model.dart';
import 'package:social_chat/models/message.model.dart';

class ChatRoom {
  String? id;
  String? name;
  String? createdById;
  List<Members>? members;
  List<Message>? messages;
  String? createdAt;
  bool? isLastMessageViewed;
  ChatRoom({
    this.id,
    this.name,
    this.createdById,
    this.members,
    this.messages,
    this.isLastMessageViewed,
    this.createdAt,
  });

  ChatRoom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdById = json['created_by_id'];
    createdAt = json["created_at"];
    isLastMessageViewed = json['is_last_message_viewed'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
    if (json['messages'] != null) {
      messages = <Message>[];
      json['messages'].forEach((v) {
        messages!.add(Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_by_id'] = createdById;
    data['created_at'] = createdAt;
    data['is_last_message_viewed'] = isLastMessageViewed;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  String? id;
  String? userId;
  String? chatId;
  Auth? user;

  Members({this.id, this.userId, this.chatId, this.user});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    chatId = json['chat_id'];
    user = json['user'] != null ? Auth.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['chat_id'] = chatId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

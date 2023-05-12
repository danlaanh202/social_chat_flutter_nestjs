import 'package:social_chat/models/auth.model.dart';
import 'package:social_chat/models/chatRoom.model.dart';

class Message {
  String? id;
  String? content;
  String? chatId;
  String? senderId;
  String? createdAt;
  String? updatedAt;
  ChatRoom? chat;
  Auth? sender;

  Message({
    this.id,
    this.content,
    this.chatId,
    this.senderId,
    this.createdAt,
    this.updatedAt,
    this.chat,
    this.sender,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    chatId = json['chat_id'];
    senderId = json['sender_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    chat = json['chat'] != null ? ChatRoom.fromJson(json['chat']) : null;
    sender = json['sender'] != null ? Auth.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['chat_id'] = this.chatId;
    data['sender_id'] = this.senderId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.chat != null) {
      data['chat'] = this.chat!.toJson();
    }
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    return data;
  }
}

class ChatRoom {
  String? id;
  String? name;
  String? createdById;
  List<Members>? members;

  ChatRoom({this.id, this.name, this.createdById, this.members});

  ChatRoom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdById = json['created_by_id'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_by_id'] = this.createdById;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  String? id;
  String? userId;
  String? chatId;
  User? user;

  Members({this.id, this.userId, this.chatId, this.user});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    chatId = json['chat_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['chat_id'] = this.chatId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? password;
  String? email;
  String? createdAt;

  User({this.id, this.username, this.password, this.email, this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    return data;
  }
}

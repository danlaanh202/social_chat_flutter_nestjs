class Auth {
  String? accessToken;
  String? id;
  String? username;
  String? email;
  String? createdAt;

  Auth({this.accessToken, this.id, this.username, this.email, this.createdAt});

  Auth.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    id = json['id'];
    username = json['username'];
    email = json['email'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['accessToken'] = accessToken;
    return data;
  }
}

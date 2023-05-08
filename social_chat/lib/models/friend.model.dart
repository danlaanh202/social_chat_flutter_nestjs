class Friend {
  String? id;
  String? username;
  String? email;
  String? friendStatus;

  Friend({this.id, this.username, this.email, this.friendStatus});

  Friend.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    friendStatus = json['friend_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['friend_status'] = friendStatus;
    return data;
  }
}

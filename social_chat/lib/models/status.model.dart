import 'package:social_chat/models/auth.model.dart';

class Status {
  String? id;
  String? description;
  String? imagePath;
  String? authorId;
  Auth? author;

  Status(
      {this.id, this.description, this.imagePath, this.authorId, this.author});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    imagePath = json['image_path'];
    authorId = json['author_id'];
    author = json['author'] != null ? Auth.fromJson(json['author']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['image_path'] = imagePath;
    data['author_id'] = authorId;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    return data;
  }
}

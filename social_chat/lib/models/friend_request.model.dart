class FriendRequest {
  String? id;
  String? requesterId;
  String? recipientId;
  String? status;
  String? createdAt;
  String? updatedAt;

  FriendRequest({
    this.id,
    this.requesterId,
    this.recipientId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  FriendRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requesterId = json['requester_id'];
    recipientId = json['recipient_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['requester_id'] = this.requesterId;
    data['recipient_id'] = this.recipientId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

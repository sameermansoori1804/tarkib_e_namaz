class Tasbih {
  int? id;
  String? title;
  String? language;
  String? addedBy;
  int? userId;
  int? status;
  String? createdAt;
  String? updatedAt;

  Tasbih(
      {this.id,
        this.title,
        this.language,
        this.addedBy,
        this.userId,
        this.status,
        this.createdAt,
        this.updatedAt});

  Tasbih.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    language = json['language'];
    addedBy = json['added_by'];
    userId = json['user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['language'] = this.language;
    data['added_by'] = this.addedBy;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

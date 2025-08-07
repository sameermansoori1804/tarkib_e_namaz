class Posts {
  int? id;
  String? title;
  String? thumbnail;
  String? url;
  int? categoryId;
  int? orders;
  Null? language;
  String? updatedAt;
  String? createdAt;
  String? category;

  Posts(
      {this.id,
        this.title,
        this.thumbnail,
        this.url,
        this.categoryId,
        this.orders,
        this.language,
        this.updatedAt,
        this.createdAt,
        this.category});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    url = json['url'];
    categoryId = json['category_id'];
    orders = json['orders'];
    language = json['language'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['url'] = this.url;
    data['category_id'] = this.categoryId;
    data['orders'] = this.orders;
    data['language'] = this.language;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['category'] = this.category;
    return data;
  }
}
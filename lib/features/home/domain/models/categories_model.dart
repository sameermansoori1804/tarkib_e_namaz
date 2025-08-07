import 'package:flutter_template/features/home/domain/models/post_model.dart';

class Categories {
  int? id;
  String? title;
  String? image;
  int? orders;
  int? status;
  String? updatedAt;
  String? createdAt;
  List<Posts>? posts;

  Categories(
      {this.id,
        this.title,
        this.image,
        this.orders,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.posts});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    orders = json['orders'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['orders'] = this.orders;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


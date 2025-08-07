import 'package:flutter_template/utils/AppConstants.dart';

class Slider {
  int? id;
  String? image;
  int? status;
  String? updatedAt;
  String? createdAt;

  Slider({this.id, this.image, this.status, this.updatedAt, this.createdAt});

  Slider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'] != null ? '${AppConstants.webHostedUrl}${json['image']}' : null;
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
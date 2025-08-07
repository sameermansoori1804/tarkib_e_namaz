class Setting {
  int? id;
  String? field;
  String? value;
  String? type;
  String? category;
  Null? advanceData;
  String? updatedAt;
  String? createdAt;

  Setting(
      {this.id,
        this.field,
        this.value,
        this.type,
        this.category,
        this.advanceData,
        this.updatedAt,
        this.createdAt});

  Setting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    field = json['field'];
    value = json['value'];
    type = json['type'];
    category = json['category'];
    advanceData = json['advance_data'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['field'] = this.field;
    data['value'] = this.value;
    data['type'] = this.type;
    data['category'] = this.category;
    data['advance_data'] = this.advanceData;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

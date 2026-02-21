class WalletHistoryModel {
  int? id;
  int? userId;
  String? title;
  int? amount;
  String? type;
  String? updatedAt;
  String? createdAt;

  WalletHistoryModel(
      {this.id,
        this.userId,
        this.title,
        this.amount,
        this.type,
        this.updatedAt,
        this.createdAt});

  WalletHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    amount = json['amount'];
    type = json['type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

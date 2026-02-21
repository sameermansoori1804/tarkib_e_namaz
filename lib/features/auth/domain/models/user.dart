class UserModel {
  int? id;
  String? name;
  String? email;
  String? balance;
  String? profilePic;
  String? deviceToken;
  Null? playerIds;
  int? status;
  Null? userType;
  String? activeAt;
  String? createdAt;
  String? updatedAt;
  Null? mobile;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.balance,
      this.profilePic,
      this.deviceToken,
      this.playerIds,
      this.status,
      this.userType,
      this.activeAt,
      this.createdAt,
      this.updatedAt,
      this.mobile});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    balance = json['balance'];
    profilePic = json['profile_pic'];
    deviceToken = json['device_token'];
    playerIds = json['player_ids'];
    status = json['status'];
    userType = json['user_type'];
    activeAt = json['active_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['balance'] = this.balance;
    data['profile_pic'] = this.profilePic;
    data['device_token'] = this.deviceToken;
    data['player_ids'] = this.playerIds;
    data['status'] = this.status;
    data['user_type'] = this.userType;
    data['active_at'] = this.activeAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['mobile'] = this.mobile;
    return data;
  }
}

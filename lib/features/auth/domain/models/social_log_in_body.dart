class SocialLogInBody {
  String? email;
  String? name;
  String? loginType;
  String? socialId;
  String? image;


  SocialLogInBody({
    this.email,
    this.loginType,
    this.name,
    this.socialId,
    this.image,
  });

  SocialLogInBody.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    loginType = json['login_type'];
    name = json['name'];
    socialId = json['social_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['email'] = email;


    data['login_type'] = loginType;

    // ✅ new
    if (name != null) {
      data['name'] = name;
    }

    if (socialId != null) {
      data['social_id'] = socialId;
    }

    if (image != null) {
      data['image'] = image;
    }

    return data;
  }
}

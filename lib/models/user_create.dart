class UserUpdate {
  String? phoneNunmer;
  String? fullName;
  String? gender;
  String? email;
  String? urlImg;

  UserUpdate({
    this.phoneNunmer,
    this.fullName,
    this.gender,
    this.email,
    this.urlImg,
  });

  UserUpdate.fromJson(Map<String, dynamic> json) {
    phoneNunmer = json['phoneNunmer'];
    fullName = json['fullName'];
    gender = json['gender'];
    email = json['email'];
    urlImg = json['urlImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNunmer'] = phoneNunmer;
    data['fullName'] = fullName;
    data['gender'] = gender;
    data['email'] = email;
    data['urlImg'] = urlImg;
    return data;
  }
}

class UserCreate {
  String? phoneNunmer;
  String? fullName;
  String? gender;
  String? email;
  String? fireBaseUid;

  UserCreate(
      {this.phoneNunmer,
      this.fullName,
      this.gender,
      this.email,
      this.fireBaseUid});

  UserCreate.fromJson(Map<String, dynamic> json) {
    phoneNunmer = json['phoneNunmer'];
    fullName = json['fullName'];
    gender = json['gender'];
    email = json['email'];
    fireBaseUid = json['fireBaseUid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNunmer'] = phoneNunmer;
    data['fullName'] = fullName;
    data['gender'] = gender;
    data['email'] = email;
    data['fireBaseUid'] = fireBaseUid;
    return data;
  }
}

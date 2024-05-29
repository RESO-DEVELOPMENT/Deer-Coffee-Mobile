class UserUpdate {
  String? fullname;
  num? gender;
  String? email;
  bool? delFlg;

  UserUpdate({this.fullname, this.gender, this.email, this.delFlg});

  UserUpdate.fromJson(Map<String, dynamic> json) {
    fullname = json['fullName'];
    gender = json['gender'];
    email = json['email'];
    delFlg = json['delFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['fullname'] = fullname;
    data['email'] = email;
    data['gender'] = gender;
    data['delFlg'] = delFlg;
    return data;
  }
}

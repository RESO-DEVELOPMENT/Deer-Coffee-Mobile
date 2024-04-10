class CheckLoginModel {
  String? message;
  String? signInMethod;

  CheckLoginModel({this.message, this.signInMethod});

  CheckLoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    signInMethod = json['signInMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['signInMethod'] = signInMethod;
    return data;
  }
}

class CheckUser{
  bool? isValid;

  CheckUser({this.isValid});

  CheckUser.fromJson(Map<String, dynamic> json) {
    isValid = json['isValid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isValid'] = isValid;
    return data;
  }
}
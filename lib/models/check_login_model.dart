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

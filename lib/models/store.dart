class StoreModel {
  String? id;
  String? brandId;
  String? name;
  String? shortName;
  String? email;
  String? address;
  String? status;
  String? wifiName;
  String? wifiPassword;

  StoreModel(
      {this.id,
      this.brandId,
      this.name,
      this.shortName,
      this.email,
      this.address,
      this.status,
      this.wifiName,
      this.wifiPassword});

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandId = json['brandId'];
    name = json['name'];
    shortName = json['shortName'];
    email = json['email'];
    address = json['address'];
    status = json['status'];
    wifiName = json['wifiName'];
    wifiPassword = json['wifiPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandId'] = this.brandId;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['email'] = this.email;
    data['address'] = this.address;
    data['status'] = this.status;
    data['wifiName'] = this.wifiName;
    data['wifiPassword'] = this.wifiPassword;
    return data;
  }

  static List<StoreModel> fromList(dynamic jsonList) {
    var list = jsonList as List;
    return list.map((map) => StoreModel.fromJson(map)).toList();
  }
}

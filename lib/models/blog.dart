class BlogModel {
  String? id;
  String? title;
  String? blogContent;
  String? brandId;
  String? image;
  bool? isDialog;
  String? metaData;
  String? status;
  num? priority;

  BlogModel(
      {this.id,
      this.title,
      this.blogContent,
      this.brandId,
      this.image,
      this.isDialog,
      this.metaData,
      this.status,
      this.priority});

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    blogContent = json['blogContent'];
    brandId = json['brandId'];
    image = json['image'];
    isDialog = json['isDialog'];
    metaData = json['metaData'];
    status = json['status'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['blogContent'] = blogContent;
    data['brandId'] = brandId;
    data['image'] = image;
    data['isDialog'] = isDialog;
    data['metaData'] = metaData;
    data['status'] = status;
    data['priority'] = priority;
    return data;
  }

  static List<BlogModel> fromList(dynamic jsonList) {
    var list = jsonList as List;
    return list.map((map) => BlogModel.fromJson(map)).toList();
  }
}

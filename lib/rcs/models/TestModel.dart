class TestModel {
String? profileImage;
String? name;
String? content;
String? location;
String? createdAt;
String? id;

TestModel(
    {this.profileImage,
      this.name,
      this.content,
      this.location,
      this.createdAt,
      this.id});

TestModel.fromJson(Map<String, dynamic> json) {
profileImage = json['profile_image'];
name = json['name'];
content = json['content'];
location = json['location'];
createdAt = json['createdAt'];
id = json['id'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['profile_image'] = this.profileImage;
  data['name'] = this.name;
  data['content'] = this.content;
  data['location'] = this.location;
  data['createdAt'] = this.createdAt;
  data['id'] = this.id;
  return data;
}
}
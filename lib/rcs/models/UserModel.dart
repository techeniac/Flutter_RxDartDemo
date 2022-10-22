class UserModel {
  User? user;
  Tokens? tokens;

  UserModel({this.user, this.tokens});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    tokens =
    json['tokens'] != null ? new Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.tokens != null) {
      data['tokens'] = this.tokens!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? gender;
  String? email;
  String? dob;
  String? phone;
  String? role;
  bool? isEmailVerified;
  String? username;
  String? createdAt;
  String? id;

  User(
      {this.name,
        this.gender,
        this.email,
        this.dob,
        this.phone,
        this.role,
        this.isEmailVerified,
        this.username,
        this.createdAt,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gender = json['gender'];
    email = json['email'];
    dob = json['dob'];
    phone = json['phone'];
    role = json['role'];
    isEmailVerified = json['isEmailVerified'];
    username = json['username'];
    createdAt = json['createdAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['isEmailVerified'] = this.isEmailVerified;
    data['username'] = this.username;
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class Tokens {
  Access? access;
  Access? refresh;

  Tokens({this.access, this.refresh});

  Tokens.fromJson(Map<String, dynamic> json) {
    access =
    json['access'] != null ? new Access.fromJson(json['access']) : null;
    refresh =
    json['refresh'] != null ? new Access.fromJson(json['refresh']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.access != null) {
      data['access'] = this.access!.toJson();
    }
    if (this.refresh != null) {
      data['refresh'] = this.refresh!.toJson();
    }
    return data;
  }
}

class Access {
  String? token;
  String? expires;

  Access({this.token, this.expires});

  Access.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expires'] = this.expires;
    return data;
  }
}
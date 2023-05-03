import 'dart:io';
import 'package:firebase_database/firebase_database.dart';

class User {
  String? key;
  String name;
  String email;
  String? avatar;
  String password;
  String uid;
  File? photo;

  User(this.name, this.email, this.password, this.uid);

  User.fromJson(DataSnapshot snapshot, Map<dynamic, dynamic> json) :
    key = snapshot.key ?? '0',
    name = json["name"] ?? 'username',
    email = json["email"] ?? 'email',
    avatar = json["avatar"] ?? 'avatar',
    password = json["password"] ?? 'password',
    uid = json["uid"] ?? 'uid';

  toJson() {
    return {
      "name": name,
      "email": email,
      "avatar": avatar,
      "password": password,
      "uid": uid,
    };
  }

  set setPhoto(File? photo) => this.photo = photo;
}
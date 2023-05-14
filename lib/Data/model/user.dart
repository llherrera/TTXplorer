import 'dart:io';
import 'package:firebase_database/firebase_database.dart';

class User {
  String? key;
  String name;
  String email;
  String? avatar;
  String password;
  String uid;
  List<int> rewards = [0,0,0];
  File? photo;

  User(this.name, this.email, this.password, this.uid);

  User.fromJson(DataSnapshot snapshot, Map<dynamic, dynamic> json) :
    key = json["uid"] ?? '0',
    name = json["name"] ?? 'username',
    email = json["email"] ?? 'email',
    avatar = json["avatar"] ?? 'avatar',
    password = json["password"] ?? 'password',
    uid = json["uid"] ?? 'uid',
    rewards = [0,0,0];

  toJson() {
    return {
      "name": name,
      "email": email,
      "avatar": avatar,
      "password": password,
      "uid": uid,
      "rewards": rewards
    };
  }
}
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalB {
  String? key;
  String localName;
  String localDescription;
  File localImage;
  String type;
  LatLng ubi;
  String uid;

  LocalB(this.localName, this.localDescription, this.localImage, this.type, this.ubi, this.uid);

  LocalB.fromJson(DataSnapshot snapshot, Map<dynamic, dynamic> json) :
    localName = json["localName"] ?? 'localName',
    localDescription = json["localDescription"] ?? 'localDescription',
    localImage = json["localImage"] ?? 'localImage',
    type = json["type"] ?? 'type',
    ubi = json["ubi"] ?? 'ubi',
    uid = json["uid"] ?? 'uid';

  toJson() {
    return {
      "localName": localName,
      "localDescription": localDescription,
      "localImage": localImage,
      "type": type,
      "ubi": ubi,
    };
  }
}
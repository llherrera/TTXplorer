import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Local {
  static int genId = 0;
  int i = genId++;
  String localName;
  String localDescription;
  File localImage;
  String type;
  LatLng ubi;

  Local(this.localName, this.localDescription, this.localImage, this.type, this.ubi);
}
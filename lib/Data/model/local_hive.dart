import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

part 'local_hive.g.dart';

@HiveType(typeId: 0)
class LocalInfo {
  @HiveField(0)
  String localName;
  @HiveField(1)
  String localDesc;
  @HiveField(2)
  String localURL;
  @HiveField(3)
  String localType;
  @HiveField(4)
  LatLng localUbi;

  LocalInfo(this.localName, this.localDesc, this.localURL, this.localType, this.localUbi);

}
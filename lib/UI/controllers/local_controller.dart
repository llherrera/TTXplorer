import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Data/model/local.dart';
import 'auth_controller.dart';

class LocalController extends GetxController {
  // ignore: prefer_final_fields
  var _locales = <LocalB>[].obs;

  // ignore: prefer_const_constructors
  var localDest = LocalB('localName', 'localDescription', 'localImage', 'type', LatLng(0, 0), 'uid').obs;
  RxList markerLocales = [].obs;

  final databaseRef = FirebaseDatabase.instance.ref();

  late StreamSubscription<DatabaseEvent> newEntryStreamSubscription;

  late StreamSubscription<DatabaseEvent> updateEntryStreamSubscription;

  get locales {
    AuthenticationController authenticationController = Get.find();
    return _locales
        .where((entry) => entry.uid != authenticationController.getUid())
        .toList();
  }

  get allLocales => _locales;

  void start() {
    _locales.clear();

    newEntryStreamSubscription =
        databaseRef.child("localList").onChildAdded.listen(_onEntryAdded);

    updateEntryStreamSubscription =
        databaseRef.child("localList").onChildChanged.listen(_onEntryChanged);
  }

  void stop() {
    newEntryStreamSubscription.cancel();
    updateEntryStreamSubscription.cancel();
  }

  _onEntryAdded(DatabaseEvent event) {
    final json = event.snapshot.value as Map<dynamic, dynamic>;
    _locales.add(LocalB.fromJson(event.snapshot, json));
  }

  _onEntryChanged(DatabaseEvent event) {
    var oldEntry = _locales.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    final json = event.snapshot.value as Map<dynamic, dynamic>;
    _locales[_locales.indexOf(oldEntry)] = LocalB.fromJson(event.snapshot, json);
  }

  Future<void> createLocal(localName, localDescription, localImage, type, ubi, uid) async {
    try {
      await databaseRef
          .child('localList')
          .push()
          .set({'localName': localName,
                'localDescription': localDescription,
                'localImageURL': localImage,
                'type': type,
                'ubi': ubi,
                'uid': uid});
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<LocalB> getLocal(uid) async {
    try {
      late LocalB b;
      final snapshot = await databaseRef.child('localList/$uid').get();
      if (snapshot.isBlank != true) {
        //print('asdsd '+snapshot.value.toString());
        final json = snapshot.value as Map<dynamic, dynamic>;
        List<String> coordsList = json["ubi"].replaceAll('[','').replaceAll(']','').split(',');
        LatLng latLng = LatLng(double.parse(coordsList[0]), double.parse(coordsList[1])); 
        b = LocalB(
          json["localName"] ?? 'localName',
          json["localDescription"] ?? 'localDescription',
          json["localImageURL"] ?? 'localImage',
          json["type"] ?? 'type',
          latLng,
          json["uid"] ?? 'uid',
        );
      }
      return b;
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<List<LocalB>> getLocales() async {
    List<LocalB> locales = [];
    final ref = databaseRef.child('localList');
    await ref.once().then((aaaa) {
          final values = aaaa.snapshot.value as Map<dynamic, dynamic>;
          values.forEach((key, values) {
            final json = values as Map<dynamic, dynamic>;
            List<String> coordsList = json["ubi"].replaceAll('[','').replaceAll(']','').split(',');
            LatLng latLng = LatLng(double.parse(coordsList[0]), double.parse(coordsList[1])); 
            locales.add(LocalB(
              json["localName"] ?? 'localName',
              json["localDescription"] ?? 'localDescription',
              json["localImageURL"] ?? 'localImage',
              json["type"] ?? 'type',
              latLng,
              json["uid"] ?? 'uid',
            ));
          });
    });
    return locales;
  }

  void setLocalDest(LocalB dest) {
    localDest.value = dest;
  }

}

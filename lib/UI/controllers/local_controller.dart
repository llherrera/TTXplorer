import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Data/model/local.dart';
import '../pages/local_page.dart';
import 'auth_controller.dart';

class LocalController extends GetxController {
  // ignore: prefer_final_fields
  var _locales = <LocalB>[].obs;

  // ignore: prefer_const_constructors
  var localDest = LocalB('localName', 'localDescription', 'localImage', 'type', LatLng(0, 0), 'uid').obs;
  var markerLocales = <Marker>{}.obs;

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
  
  void resetLocalDest() {
    // ignore: prefer_const_constructors
    localDest.value = LocalB('localName', 'localDescription', 'localImage', 'type', LatLng(0, 0), 'uid');
  }

  Future<void> setPhoto(url) async {
    final ref = databaseRef.child('localList');
    Query query = ref.orderByChild('localName').equalTo(localDest.value.localName);
    await query.once().then((value) {
      final values = value.snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, values) {
        final json = values as Map<dynamic, dynamic>;
        if(json["localName"] == localDest.value.localName){
          try{
            List<String> photos = List<String>.from(json['photosReview']);
            photos.add(url);
            ref.child(key).update({
              'photosReview': photos
            });
          } catch (e) {
            ref.child(key).update({
              'photosReview': [url]
            });
          }
        }
      });
    });
  } 

  Future<void> setReview(review) async {
    final ref = databaseRef.child('localList');
    Query query = ref.orderByChild('localName').equalTo(localDest.value.localName);
    await query.once().then((value) {
      final values = value.snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, values) {
        final json = values as Map<dynamic, dynamic>;
        if(json["localName"] == localDest.value.localName){
          try{
            List<String> reviews = List<String>.from(json['reviews']);
            reviews.add(review);
            ref.child(key).update({
              'reviews': reviews
            });
          } catch (e) {
            ref.child(key).update({
              'reviews': [review]
            });
          }
        }
      });
    });
  }

  Future<void> setLocales(Iterable<LocalB> voidLocales) async {
    _locales.value = voidLocales as List<LocalB>;
    
    if (voidLocales.isEmpty) {
      _locales.value = await getLocales();
    }

    // ignore: invalid_use_of_protected_member
    for (var locall in _locales.value) {
      // ignore: invalid_use_of_protected_member
      markerLocales.value.add(
        Marker(
          markerId: MarkerId(locall.localName),
          position: locall.ubi,
          infoWindow: InfoWindow(
            title: locall.localName,
            snippet: locall.localDescription,
          ),
          onTap: () {
            Get.to(LocalPage(local: locall));
          },
          icon: locall.type == 'fruta' ? await BitmapDescriptor.fromAssetImage(const ImageConfiguration(),'assets/icons/cereza_icon.png') : 
               (locall.type == 'semilla' ? await BitmapDescriptor.fromAssetImage(const ImageConfiguration(),'assets/icons/semillas_icon.png') : 
               await BitmapDescriptor.fromAssetImage(const ImageConfiguration(),'assets/icons/arana_icon.png'))
        ),
      );
    }
    //markerLocales.value = markerLocales;
  }
}
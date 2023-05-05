import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../../Data/model/local.dart';
import 'auth_controller.dart';

class LocalController extends GetxController {
  // ignore: prefer_final_fields
  var _locales = <LocalB>[].obs;

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
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return Future.error(e);
    }
  }
}
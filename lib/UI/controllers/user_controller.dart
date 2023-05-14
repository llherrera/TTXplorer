import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../../Data/model/user.dart';
import 'auth_controller.dart';
import 'local_controller.dart';

class UserController extends GetxController {
  // ignore: prefer_final_fields
  var _users = <User>[].obs;

  final databaseRef = FirebaseDatabase.instance.ref();
  //LocalController localControl = Get.find();

  late StreamSubscription<DatabaseEvent> newEntryStreamSubscription;

  late StreamSubscription<DatabaseEvent> updateEntryStreamSubscription;

  get users {
    AuthenticationController authenticationController = Get.find();
    return _users
        .where((entry) => entry.uid != authenticationController.getUid())
        .toList();
  }

  get allUsers => _users;

  void start() {
    _users.clear();

    newEntryStreamSubscription =
        databaseRef.child("userList").onChildAdded.listen(_onEntryAdded);

    updateEntryStreamSubscription =
        databaseRef.child("userList").onChildChanged.listen(_onEntryChanged);
  }

  void stop() {
    newEntryStreamSubscription.cancel();
    updateEntryStreamSubscription.cancel();
  }

  _onEntryAdded(DatabaseEvent event) {
    final json = event.snapshot.value as Map<dynamic, dynamic>;
    _users.add(User.fromJson(event.snapshot, json));
  }

  _onEntryChanged(DatabaseEvent event) {
    var oldEntry = _users.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    final json = event.snapshot.value as Map<dynamic, dynamic>;
    _users[_users.indexOf(oldEntry)] = User.fromJson(event.snapshot, json);
  }

  Future<void> createUser(name, email, password, uid) async {
    try {
      await databaseRef
          .child('userList')
          .push()
          .set({'name': name,
                'email': email,
                'password': password,
                'uid': uid});
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<void> setPhoto(url, user, localDest) async {
    final ref = databaseRef.child('userList');
    Query query = ref.orderByChild('uid').equalTo(user);
    await query.once().then((value) {
      final values = value.snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, values) {
        try {
          List<String> photos = List.from(values['photosLocales']);
          photos.add(url);
          ref.child(key).update({
            'photosLocales': photos
          });
        } catch (e) {
          ref.child(key).update({
            'photosLocales': [url]
          });
          
        }
        try {
          List<int> rewards = List.from(values['rewards']);
          rewards[localDest.type == 'fruta' ? 0 : localDest.type == 'semilla' ? 1 : 2] += 1;
          ref.child(key).update({
            'rewards': rewards
          });
        } catch (e) {
          ref.child(key).update({
            'rewards': [
              localDest.type == 'fruta' ? 1 : 0,
              localDest.type == 'semilla' ? 1 : 0,
              localDest.type == 'insecto' ? 1 : 0
            ]
          });
        }
      });
    });
  }

}
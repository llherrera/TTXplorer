import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../../Data/model/user.dart';
import 'auth_controller.dart';

class UserController extends GetxController {
  // ignore: prefer_final_fields
  var _users = <User>[].obs;

  var rewards = <int>[0,0,0].obs;
  var user = User('user','email@e.com','123456','0').obs;

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

  Future<User> getUser() async {
    AuthenticationController authenticationController = Get.find();
    final ref = databaseRef.child('userList');
    Query query = ref.orderByChild('uid').equalTo(authenticationController.getUid());
    await query.once().then((value) {
      final values = value.snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, values) {
        user.value = User.fromJson(value.snapshot, values);
      });
    });
    return user.value;
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

  Future<void> getRewards(user) async {
    final ref = databaseRef.child('userList');
    Query query = ref.orderByChild('uid').equalTo(user);
    List<int> rewards = [];
    await query.once().then((value) {
      final values = value.snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, values) {
        rewards = List.from(values['rewards']);
      });
    });
    this.rewards.value = rewards;
  }

  Future<void> updatePhoto(url, user) async {
    final ref = databaseRef.child('userList');
    Query query = ref.orderByChild('uid').equalTo(user);
    await query.once().then((value) {
      final values = value.snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, values) {
        ref.child(key).update({
          'photoProfile': url
        });
      });
    });
  }

  Future<String> getPhoto(user) async {
    final ref = databaseRef.child('userList');
    Query query = ref.orderByChild('uid').equalTo(user);
    String url = '';
    await query.once().then((value) {
      final values = value.snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, values) {
        url = values['photoProfile'];
      });
    });
    return url;
  }

  Future<List<String>> getPhotos(user) async {
    final ref = databaseRef.child('userList');
    Query query = ref.orderByChild('uid').equalTo(user);
    List<String> url = [];
    try {
      await query.once().then((value) {
        final values = value.snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, values) {
          url = List.from(values['photosLocales']);
        });
      });
      return url;
    } catch (e) {
      return url;
    }    
  }

  Future<void> updateName(name, user) async {
    final ref = databaseRef.child('userList');
    Query query = ref.orderByChild('uid').equalTo(user);
    await query.once().then((value) {
      final values = value.snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, values) {
        ref.child(key).update({
          'name': name
        });
      });
    });
  }

  Future<void> updatePassword(password, user) async {
    final ref = databaseRef.child('userList');
    Query query = ref.orderByChild('uid').equalTo(user);
    await query.once().then((value) {
      final values = value.snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, values) {
        ref.child(key).update({
          'password': password
        });
      });
    });
  }

  Future<String> getPassword(user) {
    final ref = databaseRef.child('userList');
    Query query = ref.orderByChild('uid').equalTo(user);
    String password = '';
    query.once().then((value) {
      final values = value.snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, values) {
        password = values['password'];
      });
    });
    return Future.value(password);
  }

  Future<void> setAvatar(user, uriAvatar) async {
    final ref = databaseRef.child('userList');
    Query query = ref.orderByChild('uid').equalTo(user);
    query.once().then((value) {
      final values = value.snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, values) {
        ref.child(key).update({
          'avatar': uriAvatar
        });
      });
    });
  }

  Future<String> getAvatar(user) async {
    final ref = databaseRef.child('userList');
    Query query = ref.orderByChild('uid').equalTo(user);
    String avatar = '';
    await query.once().then((value) {
      final values = value.snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, values) {
        avatar = values['avatar'];
      });
    });
    return avatar;
  }

}
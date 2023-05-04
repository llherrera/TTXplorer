import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../../Data/model/local.dart';
import '../../services/upload_image.dart';
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

  void initializeLocales() async {
    String localPhotoURL = await uploadImageF(File( 'assets/images/ccbuenavista.jpg'), 'semillas');
    createLocal('Buenavista',
                'Reconocimiento a las marcas que han crecido durante estos 20 años con el Centro Comercial Buenavista. Gracias por creer en nosotros y permitirnos construir ciudad juntos.',
                localPhotoURL,
                'semilla',
                [11.01488064038962, -74.82745006489434],
                '1');
    localPhotoURL = await uploadImageF(File('assets/images/caiman-del-rio.jpg'), 'frutas');
    createLocal('Caiman del rio',
                'El Caimán del Río es un espacio único en su formato ofreciendo a la ciudad de Barranquilla el primer mercado gastronómico de cara al Río Magdalena con una experiencia de cocinas abiertas bajo un mismo concepto.',
                localPhotoURL,
                'fruta',
                [11.023429370880141, -74.79637497469237],
                '1');
    localPhotoURL = await uploadImageF(File('assets/images/plaza-de-la-paz.jpeg'), 'insectos');
    createLocal('Plaza de la paz',
                'La plaza de la Paz Juan Pablo II es un espacio público abierto de Barranquilla, Colombia. Está ubicada en un estratégico y céntrico sector de la ciudad, entre las carreras 45 y 46 o avenida Olaya Herrera, y la calles 47 y 53, entre la sede del Banco de la República y la Catedral Metropolitana María Reina.',
                localPhotoURL,
                'insecto',
                [10.988428922594359, -74.7892494693815],
                '1');
  }
}
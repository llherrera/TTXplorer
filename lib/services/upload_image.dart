import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

//Guardar las imagenes de los locales segun la categoria
Future<String> uploadImageF (File image, String type) async {
  Reference firebaseStorageRef = FirebaseStorage.instance.ref();
  String fileName = image.path.split('/').last;
  if (type == 'fruta') {
    firebaseStorageRef = firebaseStorageRef.child('locales/frutas/$fileName');
  }else if (type == 'semilla') {
    firebaseStorageRef = firebaseStorageRef.child('locales/semillas/$fileName');
  }else if (type == 'insecto') {
    firebaseStorageRef = firebaseStorageRef.child('locales/insectos/$fileName');
  }else if (type == 'usuario') {
    firebaseStorageRef = firebaseStorageRef.child('usuarios/$fileName');
  }else if (type == 'fotos') {
    firebaseStorageRef = firebaseStorageRef.child('photos/$fileName');
  }
  UploadTask uploadTask = firebaseStorageRef.putFile(image);
  TaskSnapshot taskSnapshot = await uploadTask;
  String downloadURL = await taskSnapshot.ref.getDownloadURL();
  return downloadURL;
}
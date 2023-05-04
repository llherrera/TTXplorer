import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImageF (File image, String type) async {
  Reference firebaseStorageRef = FirebaseStorage.instance.ref();
  String fileName = image.path.split('/').last;
  if (type == 'fruta') {
    firebaseStorageRef.child('locales/frutas/$fileName');
  }else if (type == 'semilla') {
    firebaseStorageRef.child('locales/semillas/$fileName');
  }else {
    firebaseStorageRef.child('locales/insectos/$fileName');
  }
  UploadTask uploadTask = firebaseStorageRef.putFile(image);
  TaskSnapshot taskSnapshot = await uploadTask;
  String downloadURL = await taskSnapshot.ref.getDownloadURL();
  return downloadURL;

}
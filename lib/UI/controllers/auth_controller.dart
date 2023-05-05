import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';

class AuthenticationController extends GetxController {
  final databaseReference = FirebaseDatabase.instance.ref();

  Future<void> login(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      
      return Future.value();
    } on FirebaseAuthException catch (e) {
      String error = '';
      if (e.code == 'user-not-found') {
        error = 'Usuario no encontrado';
      } else if (e.code == 'wrong-password') {
        error = 'Contraseña incorrecta';
      }
      return Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: Text(error),
          actions: <Widget>[
            TextButton(
              onPressed: () {Get.back();},
              child: const Text('OK'),
            )
          ],
        )
      );
    }
  }

  Future<void> signup(name, email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      UserController userController = Get.find();

      await userController.createUser(name, email, password, userCredential.user!.uid);
      return Future.value();
    } on FirebaseAuthException catch (e) {
      String error = '';
      if (e.code == 'weak-password') {
        error = 'La contraseña es muy debil';
      } else if (e.code == 'email-already-in-use') {
        error = 'El email ya esta en uso';
      }
      return Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: Text(error),
          actions: <Widget>[
            TextButton(
              onPressed: () {Get.back();},
              child: const Text('OK'),
            )
          ],
        )
      );
    }
  }

  logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: const Text('Error al cerrar sesion'),
          actions: <Widget>[
            TextButton(
              onPressed: () {Get.back();},
              child: const Text('OK'),
            )
          ],
        )
      );
    }
  }

  String userEmail() {
    String email = FirebaseAuth.instance.currentUser!.email ?? "a@a.com";
    return email;
  }

  String getUid() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return uid;
  }
}
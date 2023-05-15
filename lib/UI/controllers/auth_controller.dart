import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/src/firebase_auth_mocks_base.dart';
import 'package:firebase_auth_mocks/src/firebase_auth_mocks_base.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';

class AuthenticationController extends GetxController {
  AuthenticationController(MockFirebaseAuth auth);
  final databaseReference = FirebaseDatabase.instance.ref();

  var _auth;

  Future<void> login(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      UserController userController = Get.find();
      userController.user.value = await userController.getUser();

      return Future.value();
    } on FirebaseAuthException catch (e) {
      String error = '';
      if (e.code == 'user-not-found') {
        error = 'Usuario no encontrado';
      } else if (e.code == 'wrong-password') {
        error = 'Contraseña incorrecta';
      }
      return Get.dialog(AlertDialog(
        title: const Text('Error'),
        content: Text(error),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          )
        ],
      ));
    }
  }

  Future<void> signup(name, email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      UserController userController = Get.find();

      await userController.createUser(
          name, email, password, userCredential.user!.uid);
      return Future.value();
    } on FirebaseAuthException catch (e) {
      String error = '';
      if (e.code == 'weak-password') {
        error = 'La contraseña es muy debil';
      } else if (e.code == 'email-already-in-use') {
        error = 'El email ya esta en uso';
      }
      return Get.dialog(AlertDialog(
        title: const Text('Error'),
        content: Text(error),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          )
        ],
      ));
    }
  }

  logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Get.dialog(AlertDialog(
        title: const Text('Error'),
        content: const Text('Error al cerrar sesion'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          )
        ],
      ));
    }
  }

  Future<void> changePassword(newPassword, currentPass) async {
    try {
      var user = FirebaseAuth.instance.currentUser!;
      final cred = EmailAuthProvider.credential(
          email: user.email!, password: currentPass);
      await user.reauthenticateWithCredential(cred).then((value) async {
        await user.updatePassword(newPassword).then((_) {
          UserController userController = Get.find();
          userController.updatePassword(newPassword, getUid());
        });
      });
      return Future.value();
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      return Get.dialog(AlertDialog(
        title: const Text('Error'),
        content: const Text('Error al actualizar la contraseña'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          )
        ],
      ));
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

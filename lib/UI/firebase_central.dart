import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ttxplorer/ui/pages/home_page.dart';
import 'package:ttxplorer/ui/pages/login_page.dart';

class FirebaseCentral extends StatelessWidget {
  const FirebaseCentral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        });
  }
}
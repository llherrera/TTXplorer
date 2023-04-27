import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'authselect_page.dart';
import 'login_page.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
// ignore: todo
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Get.off(const AuthSelectPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x38005F), // set the background color to dark green
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10.0),
            Lottie.asset(
              'assets/images/dancemonkey.json',
              width: 350,
              height: 350,
              fit: BoxFit.cover,
            ),
            const Padding(padding: EdgeInsets.only(left: 20, top: 10)),
            const Text(
              'TTXplorer',
              style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'RobotoSlab',
                  color: Colors.orangeAccent),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

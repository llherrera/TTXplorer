import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'firebase_central.dart';
import 'pages/authselect_page.dart';
import 'pages/login_page.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
// ignore: todo
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Get.off(const FirebaseCentral());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF38005F), // set the background color to dark green
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10.0),
            Lottie.asset(
              'assets/images/dancemonkey.json',
              width: 280,
              height: 280,
              fit: BoxFit.cover,
            ),
            const Padding(padding: EdgeInsets.only(left: 20, top: 10)),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'TITI',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoSlab',
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: 'XPLORER',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoSlab',
                      color: Color(0xFFF07B2B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

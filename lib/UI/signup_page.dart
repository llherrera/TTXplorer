import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Add this line to import the Lottie package
import '../widgets/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 2, 76, 28),
              Color.fromARGB(255, 41, 152, 86),
            ],
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(height: 50),
                    Text(
                      'Create Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: 'RobotoSlab',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    SignupForm(),
                    SizedBox(height: 100),
                  ],
                ),
              ),
              /*Positioned(
                bottom: 0,
                right: 180,
                child: Lottie.asset(
                  'assets/images/monkeywalk.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Add this line to import the Lottie package
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
          backgroundColor: Colors
              .transparent, // Add this line to make Scaffold background transparent
          body: Stack(
            children: [
              // Add your content as the body of the Scaffold
              Positioned(
                top: 0,
                right: 0,
                child: Lottie.asset(
                  'assets/images/hangingmonkey.json',
                  width: 350,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30),
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}

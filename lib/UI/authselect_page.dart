import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'login_page.dart';
import 'signup_page.dart';

class AuthSelectPage extends StatelessWidget {
  const AuthSelectPage({Key? key}) : super(key: key);

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
              Align(
                alignment: Alignment.topRight,
                child: Image.asset('assets/images/plantilla1.png'),
              ),
              Align(
                alignment: const Alignment(
                    0, 0.4), // Adjust this value to change the button position
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 200, // Set the width of the ElevatedButton
                      child: ElevatedButton(
                        onPressed: () {
                          Get.off(const LoginPage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.black45, // Set the button color
                        ),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'RobotoSlab',
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 200, // Set the width of the ElevatedButton
                      child: ElevatedButton(
                        onPressed: () {
                          Get.off(const SignupPage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.black45, // Set the button color
                        ),
                        child: const Text(
                          'Create account',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'RobotoSlab',
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    IntrinsicWidth(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                Get.off(
                                    const SignupPage()); // Handle Google Sign In
                              },
                              icon: const FaIcon(FontAwesomeIcons.google,
                                  size: 30),
                              color: Colors.white,
                              hoverColor: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 40),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                Get.off(
                                    const SignupPage()); // Handle Facebook Sign In
                              },
                              icon: const FaIcon(FontAwesomeIcons.facebookF,
                                  size: 30),
                              color: Colors.white,
                              hoverColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Add this line to import the Lottie package
import '../../widgets/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF713D8F),
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Text('Create Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: SignupForm(),
                  ),
                  const SizedBox(height: 100),
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
    );
  }
}

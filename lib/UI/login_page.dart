import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Add this line to import the Lottie package
import '../widgets/login_form.dart';
import '../UI/signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF07B2B),
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 0),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'TITI',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'RobotoSlab',
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'XPLORER',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'RobotoSlab',
                          color: Color(0xFF713D8F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 130,
              left: 0,
              right: 0,
              child: LoginForm(),
            ),
            Positioned(
              top: 425,
              left: 10,
              right: 0,
              child: Transform.scale(
                scale: 0.45, // Increase the size by 20%
                child: Image.asset('assets/images/monoNaranja.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

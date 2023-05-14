import 'package:flutter/material.dart';
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
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text('Crear cuenta',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: 'RobotoSlab',
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Positioned(
              top: 130,
              left: 20,
              right: 20,
              child: SignupForm(),
            )
              
              /*Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Text('Crear cuenta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: SignupForm(),
                  ),
                  const SizedBox(height: 100),
                ],
              ),*/
            //),
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

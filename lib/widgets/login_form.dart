import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../ui/controllers/auth_controller.dart';
import '../ui/pages/signup_page.dart';
import '../ui/pages/home_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final AuthenticationController authControl = Get.find();
  
  bool _keepMeLoggedIn = false;
  String _password = '';
  String _email = '';

  void login(String usern, passw) {
    authControl.login(usern, passw);
  }

  @override
  Widget build(BuildContext context) {
   // authControl.
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.only(top: 0, left: 32, right: 32, bottom: 0),
        constraints: const BoxConstraints(maxWidth: 300),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF7A935),
                  labelText: '  EMAIL',
                  labelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                  contentPadding: const EdgeInsets.symmetric(vertical: 7), // Adjust vertical padding
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Adjust the corner radius
                  ),
                ),
                onChanged: (value) => _email = value,
              ),
              const SizedBox(height: 8),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF7A935),
                  labelText: '  CONTRASEÑA',
                  labelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                  contentPadding: const EdgeInsets.symmetric(vertical: 7), // Adjust vertical padding
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(15), // Adjust the corner radius
                  ),
                ),
                onChanged: (value) => _password = value,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // TODO: Handle forgot password
                  },
                  child: const Text('¿Has olvidado la contraseña?',
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                // Add a row with the two icons
                mainAxisAlignment: MainAxisAlignment.center, // Center the icons
                children: [
                  Container(/* Cambiar por iconButton */
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        FontAwesomeIcons.facebookF,
                        size: 30,
                        color: Colors.white,
                      ), // Facebook icon
                    ),
                  ),
                  const SizedBox(width: 25),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        FontAwesomeIcons.instagram,
                        size: 30,
                        color: Colors.pink,
                      ), // Instagram icon
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              /*Row(
                children: [
                  Checkbox(
                    value: _keepMeLoggedIn,
                    onChanged: (bool? value) {
                      setState(() {
                        _keepMeLoggedIn = value ?? false;
                      });
                      // TODO: Handle keep me logged in
                    },
                  ),
                  const Text(
                    'Keep me logged in',
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  ),
                ],
              ),*/
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF713D8F) // Set the button color
                  ),
                  child: const Text('Iniciar sesion', style: TextStyle(fontSize: 15)),
                  onPressed: () async {
                    if (_email.isNotEmpty || _password.isNotEmpty) {
                      login(_email, _password);
                      //Get.off(const HomePage());
                    }else {
                      return showDialog<void> (
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) =>
                        AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Por favor rellenar todos los campos'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {Get.back();},
                              child: const Text('OK'),
                            )
                          ],
                        )
                      );
                    }
                  },
                ),
              ),
              const Text('O'),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide.none, // Make the border invisible
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20), // Adjust the padding to increase the reaction area
                  child: Text('Registrarse',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () {
                  Get.off(const SignupPage());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

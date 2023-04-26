import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../UI/login_page.dart';
import '../UI/signup_page.dart';
import '../UI/home_page.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding:
            const EdgeInsets.only(top: 20, left: 32, right: 32, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: const BoxConstraints(maxWidth: 370),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(const LoginPage()); // TODO: Handle sign in
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black45, // Set the button color
                  ),
                  child: const Text('Continue',
                      style: TextStyle(fontSize: 20, fontFamily: 'RobotoSlab')),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Al crear una cuenta, aceptas las Condiciones de Uso y el Aviso de Privacidad de TTExplorer inc.'),
              const SizedBox(height: 16),
              const Text('Ya tienes una cuenta?'),
              const Text('Inicia Sesión', style: TextStyle(color: Colors.blue)),

            ],
          ),
        ),
      ),
    );
  }
}

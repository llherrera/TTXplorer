import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttxplorer/ui/pages/login_page.dart';
import '../ui/controllers/auth_controller.dart';
import '../ui/pages/conociendote_page.dart';

// ignore: must_be_immutable
class SignupForm extends StatelessWidget {
  SignupForm({Key? key}) : super(key: key);
  final AuthenticationController authControl = Get.find();

  String _username = '';
  String _password = '';
  String _email = '';

  Future<void> signIn() async {
    await authControl.signup(_username, _email, _password);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 32, right: 32, bottom: 20),
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
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _username = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _email = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _password = value,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: () async {
                    if(_username.isNotEmpty || _email.isNotEmpty || _password.isNotEmpty) {
                      try {
                        await signIn();
                        Get.off(() => const Conociendote());
                      } catch (e) {
                        Get.dialog(
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
                      //await signIn();
                      //Get.off(() => const Conociendote());
                    } else {
                      Get.dialog(
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black45, // Set the button color
                  ),
                  child: const Text('Continuar',
                      style: TextStyle(fontSize: 20, fontFamily: 'RobotoSlab')),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Al crear una cuenta, aceptas las Condiciones de Uso y el Aviso de Privacidad de TTXplorer inc.'),
              const SizedBox(height: 16),
              const Text('Ya tienes una cuenta?'),
              TextButton(
                onPressed: () { Get.off(() => const LoginPage());},
                child: const Text('Inicia Sesión', style: TextStyle(color: Colors.blue)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

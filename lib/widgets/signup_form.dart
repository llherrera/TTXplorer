import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/controllers/auth_controller.dart';
import '../ui/pages/avatarchoice_page.dart';

// ignore: must_be_immutable
class SignupForm extends StatelessWidget {
  SignupForm({Key? key}) : super(key: key);
  final AuthenticationController authControl = Get.find();

  String _username = '';
  String _password = '';
  String _email = '';

  void signIn() async {
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
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _username = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _email = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
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
                      signIn();
                      //Get.off(const AvatarChoicePage());
                    } else {
                      return showDialog<void> (
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) =>
                        AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Please fill in all the fields'),
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
                  child: const Text('Continue',
                      style: TextStyle(fontSize: 20, fontFamily: 'RobotoSlab')),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Al crear una cuenta, aceptas las Condiciones de Uso y el Aviso de Privacidad de TTXplorer inc.'),
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

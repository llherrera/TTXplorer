import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttxplorer/ui/pages/home_page.dart';

import '../ui/controllers/auth_controller.dart';
import '../ui/controllers/user_controller.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  AuthenticationController authControl = Get.find();
  UserController userControl = Get.find();
  String _username = '';
  String _password = '';

  Future<void> update(opt, para) async {
    if (opt) {
      await userControl.updateName(para, authControl.getUid());

    } else {
      String currentPass = await userControl.getPassword(authControl.getUid());
      await authControl.changePassword(para, currentPass);
      //await userControl.updatePassword(para, authControl.getUid());
    }
    //await authControl.signup(_username, _email, _password);
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
                    if (_username.isEmpty && _password.isEmpty) {
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Error'),
                          content: const Text('No se puede dejar campos vacíos'),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('Ok'),
                            )
                          ],
                        )
                      );
                    } else {
                      if (_username.isNotEmpty) {
                        try {
                          await update(true, _username);
                          userControl.user.value = await userControl.getUser();
                          Get.off(const HomePage());
                        } catch (e) {
                          Get.dialog(
                            AlertDialog(
                              title: const Text('Error'),
                              content: const Text('No se pudo actualizar el nombre de usuario'),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text('Ok'),
                                )
                              ],
                            )
                          );
                        }
                      }
                      if (_password.isNotEmpty) {
                        try {
                          await update(false, _password);
                          userControl.user.value = await userControl.getUser();
                          Get.off(const HomePage());
                        } catch (e) {
                          Get.dialog(
                            AlertDialog(
                              title: const Text('Error'),
                              content: const Text('No se pudo actualizar la contraseña de usuario'),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text('Ok'),
                                )
                              ],
                            )
                          );
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black45),
                  child: const Text('Guardar', style: TextStyle(fontSize: 20, fontFamily: 'RobotoSlab')),
                  
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
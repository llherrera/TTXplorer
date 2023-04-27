import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../UI/home_page.dart';
import '../UI/signup_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding:
            const EdgeInsets.only(top: 20, left: 32, right: 32, bottom: 10),
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
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // TODO: Handle forgot password
                  },
                  child: const Text('Forgot password?',
                      style: TextStyle(color: Colors.black45)),
                ),
              ),
              Row(
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
                  const Text('Keep me logged in'),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(const HomePage()); // TODO: Handle sign in
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black45, // Set the button color
                  ),
                  child: const Text('Sign in', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Or'),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Get.off(const SignupPage());
                },
                child: const Text('Join now',
                    style: TextStyle(fontSize: 15, color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'UI/avatarchoice_page.dart';
import 'UI/loading_screen.dart';
import 'UI/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TTXplorer',
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => const LoadingScreen(),
        '/': (context) => const AvatarChoicePage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ui/pages/avatarchoice_page.dart';
import 'ui/loading_screen.dart';
import 'ui/pages/login_page.dart';
import 'config/configuration.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'titiXplorerDB',
    options: const FirebaseOptions(
      apiKey: Configuration.apiKey,
      authDomain: Configuration.authDomain,
      databaseURL: Configuration.databaseURL,
      projectId: Configuration.projectId,
      //storageBucket: Configuration.storageBucket,
      messagingSenderId: Configuration.messagingSenderId,
      appId: Configuration.appId,
      // measurementId: Configuration.measurementId),
  ));
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

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ttxplorer/Data/model/local_hive.dart';
import 'package:ttxplorer/ui/controllers/auth_controller.dart';
import 'package:ttxplorer/ui/controllers/local_controller.dart';
import 'package:ttxplorer/ui/controllers/user_controller.dart';
import 'ui/pages/avatarchoice_page.dart';
import 'ui/loading_screen.dart';
import 'ui/pages/login_page.dart';
import 'config/configuration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(LocalInfoAdapter());
  await Hive.initFlutter();
  SystemChrome.setPreferredOrientations([  
  DeviceOrientation.portraitUp,  DeviceOrientation.portraitDown,]);
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  late Box localBox;

  @override
  void initState() {
    super.initState();
     openBoxes();
  }

  Future<void> openBoxes() async {
    localBox = await Hive.openBox<LocalInfo>('locales');
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    Get.put(AuthenticationController());
    Get.put(LocalController());
    
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

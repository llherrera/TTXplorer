import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page.dart';

class TTXplorerPage extends StatefulWidget {
  const TTXplorerPage({super.key});

  @override
  State<TTXplorerPage> createState() => _TTXplorerPageState();
}

class _TTXplorerPageState extends State<TTXplorerPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ClipPath(
            child: Container(
              height: MediaQuery.of(context).size.width * 0.60,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/titi.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            )
          )
        ),
      )
    );
  }
}
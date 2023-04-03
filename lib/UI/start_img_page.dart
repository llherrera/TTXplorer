import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page.dart';

class TTXplorerPage extends StatelessWidget {
  const TTXplorerPage({super.key});

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
            ),
          )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {Get.to(const HomePage());},
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
      )
    );
  }
}
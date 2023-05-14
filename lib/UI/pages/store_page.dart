import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF07B2B),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('STORE', style: TextStyle(fontFamily: 'RobotoSlab', fontSize: 28)),
                const SizedBox(height: 20),
                const Text('COMING SOON', style: TextStyle(fontFamily: 'RobotoSlab', fontSize: 28)),
              ],
            ),
          ],
        ),
      )
    );
  }
}
import 'package:flutter/material.dart';

import '../../widgets/edit_profile.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF713D8F),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(''),
          backgroundColor: const Color(0xFF713D8F),
          elevation: 0,
        ),
        body: Stack(
          children: const [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text('Editar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: 'RobotoSlab',
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Positioned(
              top: 130,
              left: 20,
              right: 20,
              child: ProfileForm(),
            )
          ],
        ),
      )
    );
  }
}
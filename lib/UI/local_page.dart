import 'package:flutter/material.dart';

import '../Data/local_model.dart';
import '../widgets/mision_button.dart';

// ignore: must_be_immutable
class LocalPage extends StatefulWidget {
  LocalPage({super.key, required this.local});
  Local local;

  @override
  State<LocalPage> createState() => _LocalPageState();
}

class _LocalPageState extends State<LocalPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          Text(widget.local.localName),
          const SizedBox(height: 10),
          /*SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.file(widget.local.localImage),
          ),*/
          const SizedBox(height: 10),
          Text(widget.local.localDescription),
          const SizedBox(height: 10),
          Text(widget.local.type),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: const [
                StartButton(),
                Spacer(flex: 1,),
                ProgramButton()
              ],
            ),
          )
        ],
      ),
    ));
  }
}
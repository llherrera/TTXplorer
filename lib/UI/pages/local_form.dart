import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ttxplorer/services/upload_image.dart';
import '../controllers/local_controller.dart';

class FormUploadLocal extends StatefulWidget {
  const FormUploadLocal({super.key});

  @override
  State<FormUploadLocal> createState() => _FormUploadLocalState();
}

class _FormUploadLocalState extends State<FormUploadLocal> {
  LocalController localControl = Get.find();

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  String localName = '';
  String localDesc = '';
  String localURL = '';
  String localType = '';
  String localUBI = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFD2D2D2),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Text('Formulario de subida de locales'),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre del local',
              ),
              onChanged: (value) => localName = value,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descripción del local',
              ),
              onChanged: (value) => localDesc = value,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tipo de local',
              ),
              onChanged: (value) => localType = value,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ubicación del local',
              ),
              onChanged: (value) => localUBI = value,
            ),
            IconButton(
              onPressed: getImage,
              icon: const Icon(Icons.photo_camera)
            ),
            ElevatedButton(
              onPressed: () async {
                localURL = await uploadImageF(_image!, localType);
                localControl.createLocal(
                              localName,
                              localDesc,
                              localURL,
                              localType,
                              localUBI,
                              '1');
                Get.back();
              },
              child: const Text('Subir local')
            )
          ],
        ),
      )
    );
  }
}
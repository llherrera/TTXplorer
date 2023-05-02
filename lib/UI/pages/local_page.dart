import 'package:flutter/material.dart';

import '../../Data/model/local_model.dart';
import '../../widgets/mision_button.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.close_outlined),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background_place.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/place_pic.png',
                        width: 350,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // Titulo y descripcion
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Titulo del lugar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xFF38005F),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Descripción del lugar',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              // Subtitulo de reseña y area de reseña
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 16),
                    Text(
                      'Reseña',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF38005F),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Reseñas del lugar.',
                      ),
                      maxLines: 5,
                    ),
                  ],
                ),
              ),

              // Botones inferiores
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF07B2B)),
                      onPressed: () {},
                      child: const Text(
                        'Iniciar misión',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFF07B2B)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Programar misión',
                        style: TextStyle(color: Color(0xFFF07B2B)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
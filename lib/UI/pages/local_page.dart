import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Data/model/local.dart';
import '../controllers/local_controller.dart';

// ignore: must_be_immutable
class LocalPage extends StatefulWidget {
  LocalPage({super.key, required this.local, this.callback});
  LocalB local;
  Function(Iterable<LocalB>)? callback;

  @override
  State<LocalPage> createState() => _LocalPageState();
}

class _LocalPageState extends State<LocalPage> {
  LocalController localControl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {Get.back();},
                      icon: const Icon(
                        Icons.close_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        widget.local.localImageURL,
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
                  children: [
                    Text(
                      widget.local.localName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xFF38005F),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.local.localDescription,
                      style: const TextStyle(
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
                      'Reseñas',
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
                          backgroundColor: const Color(0xFFF07B2B)),
                      child: Text(
                        localControl.localDest.value == widget.local ?
                        'Cancelar misión' :
                        'Iniciar misión',
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (localControl.localDest.value == widget.local) {
                          localControl.resetLocalDest();
                          //await localControl.setLocales([]);
                          await widget.callback!([]);
                        } else {
                          localControl.setLocalDest(widget.local);
                          //await localControl.setLocales([widget.local]);
                          await widget.callback!([widget.local]);
                        }
                        Get.back();
                      },
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFF07B2B)),
                      ),
                      child: const Text(
                        'Programar misión',
                        style: TextStyle(color: Color(0xFFF07B2B)),
                      ),
                      onPressed: () {},
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
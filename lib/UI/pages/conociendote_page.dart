// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'avatarchoice_page.dart';
import 'home_page.dart';

class Conociendote extends StatefulWidget {
  const Conociendote({Key? key}) : super(key: key);

  @override
  _ConociendoteState createState() => _ConociendoteState();
}

class _ConociendoteState extends State<Conociendote> {
  final _formKey = GlobalKey<FormState>();

  final List<int> _selectedAnswers = [-1, -1, -1, -1];

  final List<Map<String, dynamic>> _questions = [
    {
      'question': '¿Cuales son tus hobbies?',
      'answers': ['Explorar lugares', 'Comer', 'Practicar deportes', 'Leer'],
      'correctAnswerIndex': 3,
    },
    {
      'question': '¿Qué lugares te gustaria conocer?',
      'answers': ['Bares', 'Restaurantes', 'Culturales', 'Recreacionales'],
      'correctAnswerIndex': 0,
    },
    {
      'question': '¿Qué lugares frecuentas?',
      'answers': ['Centros comerciales', 'Bares', 'Restaurantes'],
      'correctAnswerIndex': 3,
    },
    {
      'question': '¿Cómo estas el día de hoy?',
      'answers': ['Bien', 'Mal', 'Neutral'],
      'correctAnswerIndex': 3,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: const Color(0xFFD2D2D2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF713D8F),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: const Text('Conociendote',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF713D8F),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      for (int i = 0; i < _questions.length; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${i + 1}. ${_questions[i]['question']}',
                              style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 15),
                            ),
                            const SizedBox(height: 10),
                            for (int j = 0;
                                j < _questions[i]['answers'].length;
                                j++)
                                
                              RadioListTile(
                                title: Text(_questions[i]['answers'][j], 
                                style:const TextStyle(fontWeight: FontWeight.normal, color: Colors.white,fontSize: 15)),
                                value: j,

                                groupValue: _selectedAnswers[i],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedAnswers[i] = value!;
                                  });
                                },
                                activeColor: Colors.white,
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF38005F)),
                        onPressed: () {Get.to(const AvatarChoicePage());},
                        child: const Text('Avatar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF38005F)),
                        ),
                        onPressed: () {Get.off(const HomePage());},
                        child: const Text('Omitir',
                          style: TextStyle(color: Color(0xFF38005F)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

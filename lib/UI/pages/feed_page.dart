import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttxplorer/ui/pages/place_description.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  Future<List<String>> _searchImages(String term) async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(
        20, (index) => 'https://source.unsplash.com/random/800x800/?$term');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  color: Color(0xFF38005F),
                  child: Row(
                    children: <Widget>[
                      const Spacer(flex: 1),
                      const Expanded(
                          flex: 8,
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFB27CD1),
                              hintText: 'Search',
                              border: InputBorder.none,
                            ),
                          )),
                      IconButton(
                        icon: const Icon(Icons.search),
                        color: const Color(0xFFF07B2B),
                        onPressed: () {},
                      ),
                    ],
                  )),
              photos(),
            ],
          ),
        ))
      ],
    );
  }

  Widget photos() {
    return FutureBuilder(
      future: _searchImages('food'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                /*onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlaceDescription()),
                  );
                },*/
                child: Image.network(
                  snapshot.data![index],
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No se encontraron resultados.'));
        }
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttxplorer/ui/controllers/local_controller.dart';

import '../../Data/model/local.dart';
import 'local_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}


class _FeedPageState extends State<FeedPage> {
  LocalController localControl = Get.find();
  List<LocalB> lista = [];  

  Future<List<LocalB>> _searchImages(String term) async {
    await Future.delayed(const Duration(seconds: 1));
    List<LocalB> list = await localControl.getLocales();
    lista = list;
    return list;
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
                  color: const Color(0xFF38005F),
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
      future: _searchImages(''),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Get.to(LocalPage(local: lista.elementAt(index),)),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFB27CD1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      snapshot.data![index].localImageURL,
                      fit: BoxFit.cover,
                    ),
                  )
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

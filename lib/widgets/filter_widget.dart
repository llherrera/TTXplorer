import 'package:flutter/material.dart';

import '../Data/local_model.dart';

// ignore: must_be_immutable
class Filter extends StatefulWidget {
  Filter({super.key, required this.locales, required this.callback});
  Iterable<Local> locales;
  Function(Iterable<Local>) callback;

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool isPressedA = false;
  bool isPressedB = false;
  bool isPressedC = false;
  double distanceValues = 0;
  double priceValues = 0;

  void filterBy(String filter) {
    if (filter != 'void') {
      widget.locales = widget.locales.where((Local local) => local.type == filter);
      widget.callback(widget.locales);
    } else {
      widget.callback(widget.locales);
    }
  }
  String _search = '';

  void setSearch(String search) {
    setState(() {
      _search = search;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFB27CD1)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(onPressed: (){}, icon: const Icon(Icons.settings_outlined, size: 40,)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 42,
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF07B2B),
                      hintText: 'Search',
                      hintStyle: const TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                      )
                    ),
                    onChanged: (value) => setSearch(value),
                  )
                ),
                IconButton(onPressed: (){}, icon: const Icon(Icons.search, size: 40,)),
              ],
            ),
            Slider(
              value: priceValues,
              max: 100,
              label: priceValues.round().toString(),
              activeColor: Colors.black,
              inactiveColor: Colors.black,
              onChanged: (newvalue) {
                setState(() {
                  priceValues = newvalue;
                });
              }
            ),
            Slider(
              value: distanceValues,
              max: 100,
              label: distanceValues.round().toString(),
              activeColor: Colors.black,
              inactiveColor: Colors.black,
              onChanged: (newvalue) {
                setState(() {
                  distanceValues = newvalue;
                });
              }
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Stack(
                  children: [
                    CircleAvatar(),
                    IconButton(onPressed: (){
                      if (isPressedB || isPressedC) {
                        filterBy('fruta');
                        isPressedA = true;
                        isPressedB = false;
                        isPressedC = false;
                      }else if (!isPressedA) {
                        filterBy('fruta');
                        isPressedA = true;
                        isPressedB = false;
                        isPressedC = false;
                      }else {
                        filterBy('void');
                        isPressedA = false;
                      }
                      }, icon: Image.asset('assets/icons/cereza_icon.png', color: isPressedA ? Colors.red : Colors.black),
                    ),
                  ],
                ),
                IconButton(onPressed: (){
                    if (isPressedA || isPressedC) {
                      filterBy('semilla');
                      isPressedB = true;
                      isPressedA = false;
                      isPressedC = false;
                    }else if (!isPressedB) {
                      filterBy('semilla');
                      isPressedB = true;
                      isPressedA = false;
                      isPressedC = false;
                    }else {
                      filterBy('void');
                      isPressedB = false;
                    }
                    }, icon: Image.asset('assets/icons/semillas_icon.png', color: isPressedB ? Colors.red : Colors.black),
                  
                ),
                IconButton(onPressed: (){
                  if (isPressedB || isPressedA) {
                    filterBy('insecto');
                    isPressedC = true;
                    isPressedB = false;
                    isPressedA = false;
                  }else if (!isPressedC) {
                    filterBy('insecto');
                    isPressedC = true;
                    isPressedB = false;
                    isPressedA = false;
                  }else {
                    filterBy('void');
                    isPressedC = false;
                  }
                  }, icon: Image.asset('assets/icons/arana_icon.png', color: isPressedC ? Colors.red : Colors.black),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
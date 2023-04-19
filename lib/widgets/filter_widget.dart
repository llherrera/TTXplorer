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
  void filterBy(String filter) {
    if (filter != 'void') {
      widget.locales = widget.locales.where((Local local) => local.type == filter);
      widget.callback(widget.locales);
    } else {
      widget.callback(widget.locales);
    }
  }

  RangeValues distanceValues = const RangeValues(1, 5);
  RangeValues priceValues = const RangeValues(50000, 5000000);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RangeSlider(
            values: distanceValues,
            min: distanceValues.start,
            max: distanceValues.end,
            onChanged: (RangeValues values){
              setState(() {
                distanceValues = values;
              });
            }
          ),
          RangeSlider(
            values: priceValues,
            min: priceValues.start,
            max: priceValues.end,
            onChanged: (RangeValues values){
              setState(() {
                priceValues = values;
              });
            }
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
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
                }, icon: Image.asset('assets/icons/fruit_icon.png', color: isPressedA ? Colors.red : Colors.black),
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
                }, icon: Image.asset('assets/icons/seed_icon.png', color: isPressedB ? Colors.red : Colors.black),
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
                }, icon: Image.asset('assets/icons/bug_icon.png', color: isPressedC ? Colors.red : Colors.black),
              ),
            ],
          )
        ],
      ),
      );
  }
}
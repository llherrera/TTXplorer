import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
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
              IconButton(onPressed: (){}, icon: const Icon(Icons.food_bank, size: 40,)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.food_bank, size: 40,)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.food_bank, size: 40,)),
            ],
          )
        ],
      ),
      );
  }
}
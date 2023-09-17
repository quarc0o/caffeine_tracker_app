import 'package:flutter/material.dart';

import '../../models/Drink.dart';

class SingleDrink extends StatefulWidget {
  final Drink drink;
  const SingleDrink({super.key, required this.drink});

  @override
  State<SingleDrink> createState() => _SingleDrinkState();
}

class _SingleDrinkState extends State<SingleDrink> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // This gives the background color
        borderRadius:
            BorderRadius.circular(16), // This gives the rounded borders
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      width: 150,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Navn på drikke"),
          Container(
            width: 100,
            height: 100,
            child: Image.asset(
              "assets/energy.png",
              fit: BoxFit.cover,
            ),
          ),
          Text("18:09")
        ],
      ),
    );
  }
}

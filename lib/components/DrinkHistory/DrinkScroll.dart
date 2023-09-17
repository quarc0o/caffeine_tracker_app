import 'package:flutter/material.dart';
import 'SingleDrink.dart';

class DrinkScroll extends StatefulWidget {
  const DrinkScroll({Key? key}) : super(key: key);

  @override
  State<DrinkScroll> createState() => _DrinkScrollState();
}

class _DrinkScrollState extends State<DrinkScroll> {
  final int numberOfDrinks =
      20; // Change this to how many drinks you want in the list.

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection:
          Axis.horizontal, // This makes the ListView scroll horizontally
      itemCount: numberOfDrinks,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleDrink(),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class SingleDrink extends StatefulWidget {
  const SingleDrink({super.key});

  @override
  State<SingleDrink> createState() => _SingleDrinkState();
}

class _SingleDrinkState extends State<SingleDrink> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      width: 150,
      height: 150,
      child: Text("text"),
    );
  }
}

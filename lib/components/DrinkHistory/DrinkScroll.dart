import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Drink.dart';
import '../../providers/UserProvider.dart';
import 'SingleDrink.dart';

class DrinkScroll extends StatefulWidget {
  final List<Drink>? drinks;
  const DrinkScroll({Key? key, required this.drinks}) : super(key: key);

  @override
  State<DrinkScroll> createState() => _DrinkScrollState();
}

class _DrinkScrollState extends State<DrinkScroll> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.drinks?.length ?? 0,
      itemBuilder: (context, index) {
        if (widget.drinks != null) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleDrink(
              drink: widget.drinks![index],
            ),
          );
        }
      },
    );
  }
}

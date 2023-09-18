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
    if (widget.drinks?.isEmpty ?? true) {
      // Using `isEmpty` is more idiomatic.
      return const Center(
        child: Text(
          "Her var det tomt! Legg til en drink.",
          style: TextStyle(fontSize: 22),
        ),
      );
    } else {
      return Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 35),
              child: IconButton(
                icon: Icon(
                  Icons.info,
                  color: Colors.blue,
                  size: 25,
                ),
                onPressed: _showInfoDialog,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
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
                return Container(); // Return an empty container if widget.drinks is null.
              },
            ),
          ),
        ],
      );
    }
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Drinker'),
        content: Text(
            'Her vises koffeinholdige drikker inntatt de siste 24 timene. Trykk og hold inne på en drink for å slette den.'),
        actions: [
          TextButton(
            child: Text('Lukk'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

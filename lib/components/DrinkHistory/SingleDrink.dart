import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/Drink.dart';
import '../../providers/UserProvider.dart';

class SingleDrink extends StatefulWidget {
  final Drink drink;
  const SingleDrink({super.key, required this.drink});

  String getImage() {
    if (drink.drinkName == "Te") {
      return "assets/tea.png";
    } else if (drink.drinkName == "Kaffe") {
      return "assets/coffee.png";
    } else {
      return "assets/energy.png";
    }
  }

  @override
  State<SingleDrink> createState() => _SingleDrinkState();
}

class _SingleDrinkState extends State<SingleDrink> {
  @override
  Widget build(BuildContext context) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.drink.timestamp);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // This gives the background color
        borderRadius:
            BorderRadius.circular(16), // This gives the rounded borders
        boxShadow: const [
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
      child: GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Slett drink'),
                content: Text('Ønsker du å slette denne drinken?'),
                actions: [
                  TextButton(
                    child: Text('Avbryt'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Slett',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      // Fetch the user provider and call the delete function.
                      final userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      userProvider.removeDrink(widget.drink.timestamp);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(widget.drink.drinkName),
            Container(
              width: 100,
              height: 100,
              child: Image.asset(
                widget.getImage(),
                fit: BoxFit.cover,
              ),
            ),
            Text(formattedTime),
          ],
        ),
      ),
    );
  }
}

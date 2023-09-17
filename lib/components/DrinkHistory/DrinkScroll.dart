import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Drink.dart';
import '../../providers/UserProvider.dart';
import 'SingleDrink.dart';

class DrinkScroll extends StatefulWidget {
  const DrinkScroll({Key? key}) : super(key: key);

  @override
  State<DrinkScroll> createState() => _DrinkScrollState();
}

class _DrinkScrollState extends State<DrinkScroll> {
  final int numberOfDrinks =
      8; // Change this to how many drinks you want in the list.

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return ListView.builder(
      scrollDirection:
          Axis.horizontal, // This makes the ListView scroll horizontally
      itemCount: userProvider.user?.drinks?.length ?? 0,
      itemBuilder: (context, index) {
        if (userProvider.user?.drinks == null) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleDrink(
              drink: userProvider.user!.drinks![index],
            ),
          );
        }
      },
    );
  }
}

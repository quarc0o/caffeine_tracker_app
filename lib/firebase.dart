import 'package:firebase_database/firebase_database.dart';

import 'models/Drink.dart';

class FirebaseFunctions {
  static final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref();

  static Future<void> addUserToDatabase(String userId, String name) async {
    try {
      await databaseReference.child('users').child(userId).set({
        'name': name,
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void addDrinkToFirebase(
      String userId, String drinkName, int caffeineContent) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final drinkRef = databaseReference
        .child('users')
        .child(userId)
        .child("drinks")
        .child(timestamp);

    drinkRef.set({
      'drink_name': drinkName,
      'caffeine_content': caffeineContent,
      'timestamp': timestamp,
    }).then((_) {
      print("Drink added successfully!");
    }).catchError((error) {
      print("Failed to add drink: $error");
    });
  }

  Future<List<Drink>> fetchRecentDrinks(String userId) async {
    List<Drink> recentDrinks = [];

    final int twentyFourHoursAgo =
        DateTime.now().millisecondsSinceEpoch - (24 * 60 * 60 * 1000);

    try {
      DatabaseReference drinksRef =
          databaseReference.child('users').child(userId).child('drinks');
      DatabaseEvent event = await drinksRef
          .orderByChild('timestamp')
          .startAt(twentyFourHoursAgo)
          .once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic> drinksMap =
            snapshot.value as Map<dynamic, dynamic>;
        drinksMap.forEach((key, value) {
          Drink drink = Drink(
            timestamp: int.parse(value['timestamp']),
            drinkName: value['drink_name'] as String,
            caffeineContent: value['caffeine_content'] as int,
          );
          recentDrinks.add(drink);
        });
      }
    } catch (e) {
      print("Error fetching drinks: $e");
    }
    return recentDrinks;
  }
}

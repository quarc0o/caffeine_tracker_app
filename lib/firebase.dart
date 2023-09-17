import 'package:din_koffein/models/UserModel.dart';
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

  void deleteDrinkFromFirebase(String userId, String timestamp) {
    final drinkRef = databaseReference
        .child('users')
        .child(userId)
        .child("drinks")
        .child(timestamp);

    drinkRef.remove().then((_) {
      print("Drink deleted successfully!");
    }).catchError((error) {
      print("Failed to delete drink: $error");
    });
  }

  void updateOrSetUserAge({required String userId, required int age}) {
    final userRef = databaseReference.child('users').child(userId);

    userRef.update({'age': age}).then((_) {
      print("User age updated/created successfully!");
    }).catchError((error) {
      print("Failed to update/create user age: $error");
    });
  }

  void updateOrSetUserWeight({required String userId, required int weight}) {
    final userRef = databaseReference.child('users').child(userId);

    userRef.update({'weight': weight}).then((_) {
      print("User weight updated/created successfully!");
    }).catchError((error) {
      print("Failed to update/create user weight: $error");
    });
  }

  void updateOrSetUserAlcoholTolerance(
      {required String userId, required CaffeineTolerance alcoholTolerance}) {
    final userRef = databaseReference.child('users').child(userId);

    userRef.update({'alcohol_tolerance': alcoholTolerance}).then((_) {
      print("User alcohol tolerance updated/created successfully!");
    }).catchError((error) {
      print("Failed to update/create user alcohol tolerance: $error");
    });
  }
}

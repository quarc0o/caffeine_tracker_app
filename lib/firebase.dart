import 'package:firebase_database/firebase_database.dart';

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
    final drinkRef = databaseReference
        .child('users')
        .child(userId)
        .child("drinks")
        .child(DateTime.now().millisecondsSinceEpoch.toString());

    drinkRef.set({
      'drink_name': drinkName,
      'caffeine_content': caffeineContent,
    }).then((_) {
      print("Drink added successfully!");
    }).catchError((error) {
      print("Failed to add drink: $error");
    });
  }
}

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
}

import 'package:din_koffein/firebase.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/Drink.dart';
import '../models/UserModel.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _currentUser;
  List<Drink?> _currentDrinks = [];

  List<Drink?> get currentDrinks => _currentDrinks;
  UserModel? get user => _currentUser;

  UserProvider() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  set user(UserModel? user) {
    _currentUser = user;
    fetchUserDrinks();
    notifyListeners();
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _currentUser = null;
    } else {
      _currentUser = UserModel(
        id: firebaseUser.uid,
        name: firebaseUser.displayName ?? "",
        email: firebaseUser.email ?? "",
      );
    }
    fetchUserDrinks();
    notifyListeners();
  }

  Future<void> refreshCurrentUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      _currentUser = UserModel(
        id: currentUser.uid,
        name: currentUser.displayName ?? '',
        email: currentUser.email ?? '',
      );
      notifyListeners();
    } else {
      _currentUser = null;
      notifyListeners();
    }
  }

  Future<void> addDrink(String drinkName, int caffeineContent) async {
    if (_currentUser == null || _currentUser!.id.isEmpty) {
      return;
    }
    FirebaseFunctions()
        .addDrinkToFirebase(_currentUser!.id, drinkName, caffeineContent);
    fetchUserDrinks();
  }

  Future<void> removeDrink(int timestamp) async {
    if (_currentUser == null || _currentUser!.id.isEmpty) {
      return;
    }
    FirebaseFunctions()
        .deleteDrinkFromFirebase(_currentUser!.id, timestamp.toString());
    fetchUserDrinks();
  }

  Future<void> fetchUserDrinks() async {
    if (_currentUser == null || _currentUser!.id.isEmpty) {
      print("No user found");
      return;
    }

    List<Drink> userDrinks =
        await FirebaseFunctions().fetchRecentDrinks(_currentUser!.id);
    _currentUser!.drinks = userDrinks;
    _currentDrinks = userDrinks;
    notifyListeners();
  }

  Future<void> setUserAge(int age) async {
    if (_currentUser == null || _currentUser!.id.isEmpty) {
      print("No user found");
      return;
    }
    FirebaseFunctions().updateOrSetUserAge(userId: _currentUser!.id, age: age);
    _currentUser!.age = age;
    notifyListeners();
  }

  Future<void> setUserWeight(int weight) async {
    if (_currentUser == null || _currentUser!.id.isEmpty) {
      print("No user found");
      return;
    }
    FirebaseFunctions()
        .updateOrSetUserWeight(userId: _currentUser!.id, weight: weight);
    _currentUser!.weight = weight;
    notifyListeners();
  }

  Future<void> setUserAlcoholTolerance(CaffeineTolerance tolerance) async {
    if (_currentUser == null || _currentUser!.id.isEmpty) {
      print("No user found");
      return;
    }
    FirebaseFunctions().updateOrSetUserAlcoholTolerance(
        userId: _currentUser!.id, alcoholTolerance: tolerance);
    _currentUser!.tolerance = tolerance;
    notifyListeners();
  }

  void signOut() {
    _auth.signOut();
    _currentUser = null;
    notifyListeners();
  }
}

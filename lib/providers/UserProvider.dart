import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/UserModel.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _currentUser;

  UserModel? get user => _currentUser;

  UserProvider() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  set user(UserModel? user) {
    _currentUser = user;
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

  void signOut() {
    _auth.signOut();
    _currentUser = null;
    notifyListeners();
  }
}

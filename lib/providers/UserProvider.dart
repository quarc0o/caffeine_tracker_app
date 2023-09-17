import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/UserModel.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> refreshCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _user = UserModel(
        id: currentUser.uid,
        name: currentUser.displayName ?? '',
        email: currentUser.email ?? '',
      );
      notifyListeners();
    } else {
      _user = null;
      notifyListeners();
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }
}

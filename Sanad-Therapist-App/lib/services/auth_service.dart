import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sanad_therapists/services/database_service.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? _user;
  User? get user {
    return _user;
  }

  AuthService() {
    _firebaseAuth.authStateChanges().listen(authStateChangesStreamListner);
  }

  Future<bool> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        _user = credential.user;
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }


  Future<bool> logout() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  void authStateChangesStreamListner(User? user) {
    if (user != null) {
      _user = user;
    } else {
      _user = null;
    }
  }
}

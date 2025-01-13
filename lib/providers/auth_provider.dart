import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  final AuthService _authService = AuthService();

  AuthProvider() {
    _initializeUser();
  }

  UserModel? get user => _user;

  Future<void> _initializeUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _user = UserModel(
        uid: currentUser.uid,
        email: currentUser.email,
        displayName: currentUser.displayName,
        photoUrl: currentUser.photoURL,
      );
    }
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    _user = await _authService.signInWithGoogle();
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}

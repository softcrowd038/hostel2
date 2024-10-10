import 'package:accident/Presentation/login_and_registration/pages/login_registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthSessionProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthStatus _status = AuthStatus.unauthenticated;

  AuthStatus get status => _status;

  AuthSessionProvider() {
    // Listen to authentication state changes
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is signed in
        _status = AuthStatus.authenticated;
      } else {
        // User is signed out
        _status = AuthStatus.unauthenticated;
      }
      // Notify listeners about the status change
      notifyListeners();
    });
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // No need to change the status here as it's handled by authStateChanges
    } catch (e) {
      Text('Error logging in: $e');
      // Handle login error here
      rethrow; // Rethrow the error to handle it in UI if needed
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _auth.signOut();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } catch (e) {
      Text('Error logging out: $e');
      // Handle logout error here
      rethrow; // Rethrow the error to handle it in UI if needed
    }
  }

  bool _isSigningIn = false;

  bool get isSigningIn => _isSigningIn;

  void startSignIn() {
    _isSigningIn = true;
    notifyListeners();
  }

  void finishSignIn() {
    _isSigningIn = false;
    notifyListeners();
  }
}

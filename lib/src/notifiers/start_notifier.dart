import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StartNotifier extends ChangeNotifier{
  String errorMessage = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      errorMessage ="There is an error while signing in";
      notifyListeners();
    }
  }

}

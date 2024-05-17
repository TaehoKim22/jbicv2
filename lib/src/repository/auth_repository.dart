import 'package:firebase_auth/firebase_auth.dart';

typedef UserUID = String;

abstract class AuthRepository {
  Stream<UserUID?> get onAuthStateChanged;
  Future<void> signOut();
  User? getCurrentUser();
}
import 'package:firebase_auth/firebase_auth.dart';
import '../auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<UserUID?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().asyncMap((user) => user?.uid);
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
  
  @override
  getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
  
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/repository/auth_repository.dart';


class ProfileNotifier extends StateNotifier<BookUser> {
  ProfileNotifier(int userID) : super(_loadBookUser(userID));
  final AuthRepository  _authRepository= getIt();

  static BookUser _loadBookUser(int userID) {
    // Load your BookUser here based on the username
    // For now, return a hardcoded BookUser
    return BookUser(id: userID, userName: "ss", email: 'johndoe@example.com');
  }

  Future<BookUser> loadBookUser() async {
    // Implement your method of loading the BookUser here
    // For now, return the current state
    return state;
  }

  Future<void> SignOut() async{
    _authRepository.signOut();
  }
}

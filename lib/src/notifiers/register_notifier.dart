import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/repository/book_user_repository.dart';

class AuthState {
  String email;
  String password;
  String? emailError;
  String? passwordError;

  AuthState(
      {this.email = '',
      this.password = '',
      this.emailError,
      this.passwordError});
}

class RegisterNotifier extends StateNotifier<AuthState> {
  RegisterNotifier() : super(AuthState());
  final BookUserRepository _bookUserRepository = getIt();

  @override
  void dispose() {
    state = AuthState(); // Reset the state

    super.dispose();
  }

  Future<void> setEmail(String email) async {
    String? emailError;
    if (email.trim().isEmpty) {
      emailError = 'Email cannot be empty';
    }
    // You can add more conditions for validating the email here

    state = AuthState(
      email: email,
      password: state.password,
      emailError: emailError,
      passwordError: state.passwordError,
    );
  }

  void setPassword(String password) {
    state = AuthState(
      email: state.email,
      password: password,
      emailError: state.emailError,
      passwordError:
          password.trim().isEmpty ? 'Password cannot be empty' : null,
    );
  }

  Future<void> addUser(String email, String password) async {
    String? result = await _bookUserRepository.newId(email, password);
    if (result != "Success") {
      if (result.contains('email')) {
        state = AuthState(
          email: state.email,
          password: state.password,
          emailError: result,
          passwordError: state.passwordError,
        );
      } else {
        state = AuthState(
          email: state.email,
          password: state.password,
          emailError: state.emailError,
          passwordError: result,
        );
      }
    }
  }
}

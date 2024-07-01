import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbicv2/src/notifiers/register_notifier.dart';

final authProvider =
    AutoDisposeStateNotifierProvider<RegisterNotifier, AuthState>(
        (ref) => RegisterNotifier());

class RegisterPage extends ConsumerWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              onChanged: (value) =>
                  ref.read(authProvider.notifier).setEmail(value),
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: authState.emailError,
              ),
            ),
            TextField(
              controller: passwordController,
              onChanged: (value) =>
                  ref.read(authProvider.notifier).setPassword(value),
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: authState.passwordError,
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                if (authState.email.trim().isEmpty) {
                  ref.read(authProvider.notifier).setEmail('');
                } else if (authState.password.trim().isEmpty) {
                  ref.read(authProvider.notifier).setPassword('');
                } else {
                  ref
                      .read(authProvider.notifier)
                      .addUser(authState.email, authState.password);
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

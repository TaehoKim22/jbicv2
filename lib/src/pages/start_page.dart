import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbicv2/src/notifiers/start_notifier.dart';
import 'package:jbicv2/src/pages/register_page.dart';

final StartProvider = ChangeNotifierProvider.autoDispose((ref) {
  return StartNotifier();
});

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startNotifier = ref.watch(StartProvider);
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Branding
              const Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    'JBIC',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.7,
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Password TextField
              FractionallySizedBox(
                widthFactor: 0.7,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  startNotifier.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Create Account Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: const Text('Create Account'),
                  ),
                  // Sign In Button
                  ElevatedButton(
                    onPressed: () {
                      startNotifier.signIn(
                          _emailController.text, _passwordController.text);
                    },
                    child: const Text('Sign In'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

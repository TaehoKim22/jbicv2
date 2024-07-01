import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbicv2/src/notifiers/auth_notifier.dart';
import 'package:jbicv2/src/navigation/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:jbicv2/src/notifiers/go_router_provider.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier()..init();
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next == AuthState.signedOut) {
        router.go('/start');
      } else if (next == AuthState.signedIn) {
        router.go('/home');
      }
    });

    return MaterialApp.router(
      routerConfig: router,
    );
  }
}

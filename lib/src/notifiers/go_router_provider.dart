import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jbicv2/src/navigation/routes.dart';

final routerProvider = Provider<GoRouter>((ref) => Routes.router());
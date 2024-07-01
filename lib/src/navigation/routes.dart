import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jbicv2/src/pages/book_list_page.dart';
import 'package:jbicv2/src/pages/book_page.dart';
import 'package:jbicv2/src/pages/home_page.dart';
import 'package:jbicv2/src/pages/splash_page.dart';
import 'package:jbicv2/src/pages/start_page.dart';

final GoRouter _router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
    GoRoute(
      path: '/start',
      builder: (BuildContext context, GoRouterState state) => const StartPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) => HomePage(),
    ),
    GoRoute(
      path: '/book/:bookId',
      builder: (BuildContext context, GoRouterState state) {
        final bookId = state.pathParameters['bookId']!.replaceAll('-', '');
        return BookPage(bookISBN: bookId);
      },
    ),
    GoRoute(
      path: '/booklist/:booklistid',
      builder: (BuildContext context, GoRouterState state) {
        if (state.pathParameters['booklistid'] != null) {
          final bookListId = state.pathParameters['booklistid']!;
          return BookListPage(bookListId: int.parse(bookListId));
        } else {
          return HomePage();
        }
      },
    ),
  ],
);

class Routes {
  static GoRouter router() => _router;
}

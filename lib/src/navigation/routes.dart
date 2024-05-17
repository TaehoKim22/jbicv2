import 'package:flutter/material.dart';
import 'package:jbicv2/src/pages/home_page.dart';
import 'package:jbicv2/src/pages/splash_page.dart';
import 'package:jbicv2/src/pages/start_page.dart';

class Routes{
  static const splash = '/';
  static const start = '/start';
  static const home = '/home';
  static const editUser ='/editUser';
  static const book='/book';
  static const post='/post';
  static const profile='/profile';
  static const search='/search';

  static Route routes(RouteSettings settings) {
    MaterialPageRoute buildRoute(Widget widget) {
      return MaterialPageRoute(builder: (_) => widget, settings: settings);
    }
  
  switch (settings.name){
    case splash:
      return buildRoute(const SplashScreen());
    case home:
      return buildRoute(const HomePage());
    case start:
      return buildRoute(const StartPage());
    default:
      throw Exception("This page does not exist");
    }
  }
}
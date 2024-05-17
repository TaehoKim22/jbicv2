import 'package:flutter/material.dart';
import 'package:jbicv2/src/pages/splash_page.dart';

class Routes{
  static const splash = '/';
  static const start = '/start';
  static const main = '/main';
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
    default:
      throw Exception("This page does not exist");
    }
  }
}
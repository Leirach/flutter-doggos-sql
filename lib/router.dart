import 'package:flutter/material.dart';
import 'package:sql/constants/routes.dart';
import 'package:sql/views/add_dog.dart';
import 'package:sql/views/edit_dog.dart';
import 'views/home.dart';
import 'dart:developer';

class AppRouter {
// actual router
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => Home());
      case Routes.add_dog:
        return animatedRoute((context, anim1, anim2) => DogAdd());
      case Routes.edit_dog:
        var data = settings.arguments as int;
        log(data.toString());
        return animatedRoute((context, anim1, anim2) => DogEdit(data));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  // animating routes appearing right to left
  static PageRouteBuilder animatedRoute(
      Widget Function(BuildContext, Animation<double>, Animation<double>)
          pageBuilder) {
    return PageRouteBuilder(
      pageBuilder: pageBuilder,
      transitionsBuilder: (_context, animation, _secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

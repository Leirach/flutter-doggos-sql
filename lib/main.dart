import 'package:flutter/material.dart';
import 'package:sql/constants/routes.dart';
import 'package:sql/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SQLite App",
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: Routes.home,
    );
  }
}

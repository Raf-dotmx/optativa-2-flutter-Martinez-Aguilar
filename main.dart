import 'package:flutter/material.dart';
import 'package:flutter_examen_2/router/ListRouters.dart';
import 'package:flutter_examen_2/router/routers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
      ),
      initialRoute: Routers.pantallaLogin,
      routes: Listrouters.listScreens,
    );
  }
}

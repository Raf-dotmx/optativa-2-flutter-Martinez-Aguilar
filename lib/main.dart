import 'package:flutter/material.dart';
import 'router/ListRouters.dart';
import 'router/routers.dart';

void main() {
  runApp(const MainApp());
}

// arreglate lib

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        // cambiar el estilow del appbar
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            centerTitle: true,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      initialRoute: Routers.pantallaLogin,
      routes: Listrouters.listScreens,
    );
  }
}

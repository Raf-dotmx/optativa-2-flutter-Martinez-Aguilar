import 'package:flutter/material.dart';
import 'package:flutter_examen_2/router/routers.dart';
import 'package:flutter_examen_2/screens/categorias_listado.dart';
import 'package:flutter_examen_2/screens/login.dart';

class Listrouters {
  static final Map<String, Widget Function(BuildContext)> listScreens = {
    Routers.pantallaLogin: (context) => const Login(),
    Routers.pantallaCategorias: (context) => const CategoriasListado(),

  };
}

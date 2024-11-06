import 'package:flutter/material.dart';
import 'package:flutter_examen_2/router/routers.dart';
import 'package:flutter_examen_2/screens/categorias_listado.dart';
import 'package:flutter_examen_2/screens/login.dart';
import 'package:flutter_examen_2/screens/productos_categoria.dart';

class Listrouters {
  static final Map<String, Widget Function(BuildContext)> listScreens = {
    Routers.pantallaLogin: (context) => const Login(),
    Routers.pantallaCategorias: (context) => CategoriasListado(),
    Routers.pantallaProductos: (context) {
      final category = ModalRoute.of(context)!.settings.arguments as String;
      return ProductosCategoria(category: category);
    },
  };
}

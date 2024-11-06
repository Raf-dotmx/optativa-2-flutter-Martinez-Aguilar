import 'package:flutter/material.dart';
import 'package:flutter_examen_2/router/routers.dart';
import 'package:flutter_examen_2/screens/categorias_listado.dart';
import 'package:flutter_examen_2/screens/detallado_producto.dart';
import 'package:flutter_examen_2/screens/login.dart';
import 'package:flutter_examen_2/screens/productos_categoria.dart';

class Listrouters {
  static final Map<String, Widget Function(BuildContext)> listScreens = {
    Routers.pantallaLogin: (context) => const Login(),
    Routers.pantallaCategorias: (context) => CategoriasListado(),
    Routers.pantallaProductos: (context) { 
      final category = ModalRoute.of(context)!.settings.arguments as String; // aqui la chamba la hace el argumento que se le pasa a la pantalla y el as String que castea el objeto a un string si no puede haber error por no saber que tipo de objeto es
      return ProductosCategoria(category: category);
    },
    Routers.pantallaDetalleProducto: (context) {
      final id = ModalRoute.of(context)!.settings.arguments as int;
      return DetalladoProducto(productId: id);
    },
  };
}

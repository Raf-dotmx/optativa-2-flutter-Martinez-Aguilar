import 'package:flutter/material.dart';
import 'package:flutter_examen_2/modules/buscador/domain/repository/buscador_repository.dart';
import 'package:flutter_examen_2/modules/buscador/useCase/buscador_usecase.dart';
import 'package:flutter_examen_2/screens/app_navigator.dart';
import 'package:flutter_examen_2/screens/buscador.dart';
import 'package:flutter_examen_2/screens/carrito.dart';
import 'package:flutter_examen_2/screens/productos_vistos.dart';
import 'routers.dart';
import '../screens/categorias_listado.dart';
import '../screens/detallado_producto.dart';
import '../screens/login.dart';
import '../screens/productos_categoria.dart';

class Listrouters {
  static final _productSearchRepository =
      ProductSearchRepository(baseUrl: 'https://dummyjson.com');
  static final _productSearchUseCase =
      ProductSearchUseCase(_productSearchRepository);

  static final Map<String, Widget Function(BuildContext)> listScreens = {
    Routers.pantallaLogin: (context) => const Login(),
    Routers.pantallaCategorias: (context) =>
        PersistentLayout(child: CategoriasListado()),
    Routers.pantallaProductos: (context) {
      final category = ModalRoute.of(context)!.settings.arguments
          as String; // aqui la chamba la hace el argumento que se le pasa a la pantalla y el as String que castea el objeto a un string si no puede haber error por no saber que tipo de objeto es
      return ProductosCategoria(category: category);
    },
    Routers.pantallaDetalleProducto: (context) {
      final id = ModalRoute.of(context)!.settings.arguments as int;
      return DetalladoProducto(productId: id);
    },
    Routers.pantallaCarrito: (context) =>
        PersistentLayout(child: ShoppingCartScreen()),
    Routers.pantallaBuscador: (context) => PersistentLayout(
            child: ProductSearchScreen(
          useCase: _productSearchUseCase,
        )),
    Routers.productosVistosPantalla: (context) =>
        PersistentLayout(child: ViewedProductsScreen()),
  };
}

import 'package:flutter_examen_2/modules/products/domain/dto/productos.dart';
import 'package:flutter_examen_2/infraestructure/app/repository/repository.dart';

class ProductUseCase {
  final Repository<String, List<Product>> repository;

  ProductUseCase(this.repository);

  Future<List<Product>> getProductsByCategory(String category) async {
    return await repository.execute(category);
  }
}

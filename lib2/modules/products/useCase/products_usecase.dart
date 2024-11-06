import '../domain/dto/productos.dart';
import '../../../infraestructure/app/repository/repository.dart';

class ProductUseCase {
  final Repository<String, List<Product>> repository;

  ProductUseCase(this.repository);

  Future<List<Product>> getProductsByCategory(String category) async {
    return await repository.execute(category);
  }
}

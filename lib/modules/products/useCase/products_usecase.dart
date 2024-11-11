import '../domain/dto/productos.dart';
import 'package:localstorage/localstorage.dart';
import '../../../infraestructure/app/repository/repository.dart';

class ProductUseCase {
  final Repository<String, List<Product>> repository;

  ProductUseCase(this.repository);

  Future<List<Product>> getProductsByCategory(String category) async {
    final LocalStorage storage = LocalStorage('token');
    await storage.ready;
    final token = storage.getItem('accessToken');
    if (token == null || token.isEmpty) {
      throw Exception('Token is missing or invalid. Please log in.');
    }

    return await repository.execute(category);
  }
}

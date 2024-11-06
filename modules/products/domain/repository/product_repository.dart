import 'package:flutter_examen_2/infraestructure/app/repository/repository.dart';
import 'package:flutter_examen_2/infraestructure/connection/connection.dart';
import 'package:flutter_examen_2/modules/products/domain/dto/productos.dart';

class ProductRepository implements Repository<String, List<Product>> {
  final Connection connection;

  ProductRepository(this.connection);

  @override
  Future<List<Product>> execute(String category) async {
    print(
        'Fetching products for category: |$category| <-- that was the category'); // Log the category
    final response = await connection.get<Map<String, dynamic>>(
      'https://dummyjson.com/products/category/$category',
    );

    print('API response: $response'); // Log the full response

    if (response.containsKey('products')) {
      return (response['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList();
    } else {
      print('Error: products key not found in response'); // Log the error
      throw Exception('Failed to load products');
    }
  }
}

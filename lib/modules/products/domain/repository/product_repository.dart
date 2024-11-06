import '../../../../infraestructure/app/repository/repository.dart';
import '../../../../infraestructure/connection/connection.dart';
import '../dto/productos.dart';

class ProductRepository implements Repository<String, List<Product>> {
  final Connection connection;

  ProductRepository(this.connection);

  @override
  Future<List<Product>> execute(String category) async {
    //print('Fetching products for category: |$category| <-- that was the category');
    final response = await connection.get<Map<String, dynamic>>(
      'https://dummyjson.com/products/category/$category',
    );

    //print('API response: $response');

    if (response.containsKey('products')) {
      return (response['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList();
    } else {
      //print('Error: products key not found in response');
      throw Exception('Failed to load products');
    }
  }
}

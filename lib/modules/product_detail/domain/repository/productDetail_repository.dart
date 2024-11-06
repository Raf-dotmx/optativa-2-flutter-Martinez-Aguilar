import '../../../../infraestructure/app/repository/repository.dart';
import '../../../../infraestructure/connection/connection.dart';
import '../dto/productDetail.dart';

class ProductDetailRepository implements Repository<int, ProductDetail> {
  ProductDetailRepository(Connection connection);

  @override
  Future<ProductDetail> execute(int productId) async {
    Connection connection = Connection();
    final response = await connection.get<Map<String, dynamic>>(
      'https://dummyjson.com/products/$productId',
    );

    return ProductDetail.fromJson(response);
  }
}

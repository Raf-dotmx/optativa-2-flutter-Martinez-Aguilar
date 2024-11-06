import 'package:flutter_examen_2/infraestructure/app/repository/repository.dart';
import 'package:flutter_examen_2/infraestructure/connection/connection.dart';
import 'package:flutter_examen_2/modules/product_detail/domain/dto/productDetail.dart';

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

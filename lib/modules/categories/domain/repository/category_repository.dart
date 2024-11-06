import '../../../../infraestructure/app/repository/repository.dart';
import '../../../../infraestructure/connection/connection.dart';
import '../dto/category.dart';

class CategoryRepository implements Repository<List<Category>, void> {
  CategoryRepository(Connection connection);


  @override
  Future<List<Category>> execute(void params) async {
    Connection connection = Connection();
    final response = await connection.get<List<dynamic>>(
      'https://dummyjson.com/products/categories',
    );

    return response.map((json) => Category.fromJson(json)).toList();
  }
}
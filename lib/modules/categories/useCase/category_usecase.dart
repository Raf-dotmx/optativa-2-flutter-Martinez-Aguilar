import '../../../infraestructure/app/useCase/use_case.dart';
import '../domain/dto/category.dart';
import 'package:localstorage/localstorage.dart';
import '../domain/repository/category_repository.dart';


class GetCategoriesUseCase implements UseCase<List<Category>, void> {
  final CategoryRepository repository;

  GetCategoriesUseCase({required this.repository});

  @override
  Future<List<Category>> execute(void params) async {
    final LocalStorage storage = LocalStorage('token');
    await storage.ready;
    final token = storage.getItem('accessToken');
    if (token == null || token.isEmpty) {
      throw Exception('Token is missing or invalid. Please log in.');
    }
    
    return await repository.execute(params);
  }
}

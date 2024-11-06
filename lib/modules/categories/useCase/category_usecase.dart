import '../../../infraestructure/app/useCase/use_case.dart';
import '../domain/dto/category.dart';
import '../domain/repository/category_repository.dart';


class GetCategoriesUseCase implements UseCase<List<Category>, void> {
  final CategoryRepository repository;

  GetCategoriesUseCase({required this.repository});

  @override
  Future<List<Category>> execute(void params) async {
    return await repository.execute(params);
  }
}

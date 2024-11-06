import 'package:flutter_examen_2/infraestructure/app/useCase/use_case.dart';
import 'package:flutter_examen_2/modules/categories/domain/dto/category.dart';
import 'package:flutter_examen_2/modules/categories/domain/repository/category_repository.dart';


class GetCategoriesUseCase extends UseCase<List<Category>, void> {
  final CategoryRepository repository;

  GetCategoriesUseCase({required this.repository});

  @override
  Future<List<Category>> execute(void params) async {
    return await repository.execute(params);
  }
}

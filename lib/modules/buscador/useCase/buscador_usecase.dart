import 'package:flutter_examen_2/infraestructure/app/useCase/use_case.dart';
import 'package:flutter_examen_2/modules/buscador/domain/dto/buscador.dart';
import 'package:flutter_examen_2/modules/buscador/domain/repository/buscador_repository.dart';

class ProductSearchUseCase implements UseCase<List<ProductSearchDTO>, String> {
  final ProductSearchRepository _repository;

  ProductSearchUseCase(this._repository);

  @override
  Future<List<ProductSearchDTO>> execute(String query) {
    return _repository.execute(query);
  }
}

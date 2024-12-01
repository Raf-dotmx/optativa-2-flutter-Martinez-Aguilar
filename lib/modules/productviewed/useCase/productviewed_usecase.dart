import 'package:flutter_examen_2/infraestructure/app/useCase/use_case.dart';
import 'package:flutter_examen_2/modules/productviewed/domain/dto/productviewed.dart';
import '../domain/repository/productoviewed_repository.dart';

class ViewedProductsUseCase implements UseCase<List<ProductViewed>, void> {
  final ViewedProductsRepository _repository;

  ViewedProductsUseCase(this._repository);

  @override
  Future<List<ProductViewed>> execute(void params) {
    return _repository.execute(params);
  }

  Future<void> saveViewedProduct(ProductViewed product) {
    return _repository.saveProduct(product);
  }
}

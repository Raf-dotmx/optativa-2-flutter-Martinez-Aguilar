import 'package:flutter_examen_2/infraestructure/app/useCase/use_case.dart';
import 'package:flutter_examen_2/modules/product_detail/domain/dto/productDetail.dart';
import 'package:flutter_examen_2/modules/product_detail/domain/repository/productDetail_repository.dart';


class ProductDetailUseCase implements UseCase<ProductDetail, int> {
  final ProductDetailRepository repository;

  ProductDetailUseCase(this.repository);

  @override
  Future<ProductDetail> execute(int productId) {
    return repository.execute(productId);
  }
}

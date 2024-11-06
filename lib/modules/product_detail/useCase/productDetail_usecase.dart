import '../../../infraestructure/app/useCase/use_case.dart';
import '../domain/dto/productDetail.dart';
import '../domain/repository/productDetail_repository.dart';


class ProductDetailUseCase implements UseCase<ProductDetail, int> {
  final ProductDetailRepository repository;

  ProductDetailUseCase(this.repository);

  @override
  Future<ProductDetail> execute(int productId) {
    return repository.execute(productId);
  }
}

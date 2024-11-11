import '../../../infraestructure/app/useCase/use_case.dart';
import '../domain/dto/productDetail.dart';
import '../domain/repository/productDetail_repository.dart';
import 'package:localstorage/localstorage.dart';

class ProductDetailUseCase implements UseCase<ProductDetail, int> {
  final ProductDetailRepository repository;

  ProductDetailUseCase(this.repository);

  @override
  Future<ProductDetail> execute(int productId) async {
    final LocalStorage storage = LocalStorage('token');
    await storage.ready;
    final token = storage.getItem('accessToken');
    if (token == null || token.isEmpty) {
      throw Exception('Token is missing or invalid. Please log in.');
    }
    return repository.execute(productId);
  }
}

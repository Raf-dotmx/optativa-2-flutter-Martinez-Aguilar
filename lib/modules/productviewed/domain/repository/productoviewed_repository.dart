import 'package:flutter_examen_2/infraestructure/app/repository/repository.dart';
import 'package:flutter_examen_2/modules/productviewed/domain/dto/productviewed.dart';
import 'package:localstorage/localstorage.dart';

class ViewedProductsRepository implements Repository<void, List<ProductViewed>> {
  final LocalStorage _storage = LocalStorage('viewed_products');

  @override
  Future<List<ProductViewed>> execute(void params) async {
    await _storage.ready;
    final List<dynamic> storedProducts = _storage.getItem('viewed_products') ?? [];
    return storedProducts.map((item) => ProductViewed.fromJson(item)).toList();
  }

  Future<void> saveProduct(ProductViewed product) async {
    await _storage.ready;
    List<dynamic> storedProducts = _storage.getItem('viewed_products') ?? [];
    final index = storedProducts.indexWhere((item) => item['productId'] == product.productId);

    if (index != -1) {
      // Update existing product views
      storedProducts[index]['views'] += 1;
    } else {
      // Add new product
      storedProducts.add(product.toJson());
    }
    _storage.setItem('viewed_products', storedProducts);
  }
}

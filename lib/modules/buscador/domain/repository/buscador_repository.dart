import 'dart:convert';
import 'package:flutter_examen_2/infraestructure/app/repository/repository.dart';
import 'package:flutter_examen_2/modules/buscador/domain/dto/buscador.dart';
import 'package:http/http.dart' as http;

class ProductSearchRepository implements Repository<String, List<ProductSearchDTO>> {
  final String baseUrl;

  ProductSearchRepository({required this.baseUrl});

  @override
  Future<List<ProductSearchDTO>> execute(String query) async {
    final url = Uri.parse('$baseUrl/products/search?q=$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List products = data['products'] ?? [];

      return products.map((json) => ProductSearchDTO.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch products: ${response.reasonPhrase}');
    }
  }
}

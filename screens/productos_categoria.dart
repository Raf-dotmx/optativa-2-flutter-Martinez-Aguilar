import 'package:flutter/material.dart';
import 'package:flutter_examen_2/modules/products/domain/dto/productos.dart';
import 'package:flutter_examen_2/modules/products/domain/repository/product_repository.dart';
import 'package:flutter_examen_2/infraestructure/connection/connection.dart';
import 'package:flutter_examen_2/modules/products/useCase/products_usecase.dart';

class ProductosCategoria extends StatefulWidget {
  final String category;

  const ProductosCategoria({super.key, required this.category});

  @override
  _ProductosCategoriaState createState() => _ProductosCategoriaState();
}

class _ProductosCategoriaState extends State<ProductosCategoria> {
  late ProductUseCase _productUseCase;
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    final productRepository = ProductRepository(Connection());
    _productUseCase = ProductUseCase(productRepository);
    _productsFuture = _productUseCase.getProductsByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          final products = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return _buildProductCard(product);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.network(
              product.thumbnail,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                // Navigate to the product details page
              },
              child: const Text(
                'Details',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

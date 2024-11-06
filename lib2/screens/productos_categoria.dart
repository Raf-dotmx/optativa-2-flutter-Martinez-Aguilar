import 'package:flutter/material.dart';
import '../modules/products/domain/dto/productos.dart';
import '../modules/products/domain/repository/product_repository.dart';
import '../infraestructure/connection/connection.dart';
import '../modules/products/useCase/products_usecase.dart';
import '../router/routers.dart';

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

          // aqui se construye la lista de productos, las cartas
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

// aqui se construye la cartas de cada producto
  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.cover, // para que la imagen se ajuste al tamaño de la caja
                width: double.infinity, // para que ocupe todo el ancho
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text( // titulo del producto
                product.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector( // para que se pueda hacer click en el texto
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routers.pantallaDetalleProducto,
                    arguments: product.id,
                  );
                },
                child: const Text(
                  'Detalles',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

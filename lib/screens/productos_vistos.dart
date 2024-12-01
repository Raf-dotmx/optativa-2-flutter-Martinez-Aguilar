import 'package:flutter/material.dart';
import 'package:flutter_examen_2/modules/productviewed/domain/dto/productviewed.dart';
import 'package:flutter_examen_2/modules/productviewed/domain/repository/productoviewed_repository.dart';
import 'package:flutter_examen_2/modules/productviewed/useCase/productviewed_usecase.dart';
import 'package:flutter_examen_2/screens/detallado_producto.dart';

class ViewedProductsScreen extends StatefulWidget {
  const ViewedProductsScreen({super.key});

  @override
  _ViewedProductsScreenState createState() => _ViewedProductsScreenState();
}

class _ViewedProductsScreenState extends State<ViewedProductsScreen> {
  late ViewedProductsUseCase _useCase;
  late Future<List<ProductViewed>> _viewedProductsFuture;

  @override
  void initState() {
    super.initState();
    final repository = ViewedProductsRepository();
    _useCase = ViewedProductsUseCase(repository);
    _viewedProductsFuture = _useCase.execute(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos Vistos'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ProductViewed>>(
        future: _viewedProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay productos vistos.'));
          }

          final products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(product.views.toString()),
                  ),
                  title: Text(product.name),
                  subtitle: Text('Precio: \$${product.price.toStringAsFixed(2)}'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to the product details screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalladoProducto(
                          productId: product.productId,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

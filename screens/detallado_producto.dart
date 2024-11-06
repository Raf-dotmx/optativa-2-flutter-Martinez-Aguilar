import 'package:flutter/material.dart';
import 'package:flutter_examen_2/modules/product_detail/domain/dto/productDetail.dart';
import 'package:flutter_examen_2/modules/product_detail/domain/repository/productDetail_repository.dart';
import 'package:flutter_examen_2/modules/product_detail/useCase/productDetail_usecase.dart';
import 'package:flutter_examen_2/infraestructure/connection/connection.dart';

class DetalladoProducto extends StatefulWidget {
  final int productId;

  const DetalladoProducto({super.key, required this.productId});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<DetalladoProducto> {
  late ProductDetailUseCase _productDetailUseCase;
  late Future<ProductDetail> _productDetailFuture;

  @override
  void initState() {
    super.initState();
    final productDetailRepository = ProductDetailRepository(Connection());
    _productDetailUseCase = ProductDetailUseCase(productDetailRepository);
    _productDetailFuture = _productDetailUseCase.execute(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: FutureBuilder<ProductDetail>(
        future: _productDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Loading circulo de carga
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Product not found.'));
          }

          final product = snapshot.data!;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    product.thumbnail,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Alinea los elementos a los extremos
                    children: [
                      Text(
                        'Price: \$${product.price}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Stock: ${product.stock}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder( // Bordes redondeados
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: const Size(80, 40),
                    ),
                    child: const Row( // esta muy raro como poner un icono a un boton me parece muy exagerado el tener que poner un row
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add),
                        Text('Agregar'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

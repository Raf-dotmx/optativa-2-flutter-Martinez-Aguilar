import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';
import '../modules/product_detail/domain/dto/productDetail.dart';
import '../modules/product_detail/domain/repository/productDetail_repository.dart';
import '../modules/product_detail/useCase/productDetail_usecase.dart';
import '../infraestructure/connection/connection.dart';

class DetalladoProducto extends StatefulWidget {
  final int productId;

  const DetalladoProducto({super.key, required this.productId});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<DetalladoProducto> {
  late ProductDetailUseCase _productDetailUseCase;
  late Future<ProductDetail> _productDetailFuture;
  final LocalStorage storage = LocalStorage('cart');
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final productDetailRepository = ProductDetailRepository(Connection());
    _productDetailUseCase = ProductDetailUseCase(productDetailRepository);
    _productDetailFuture = _productDetailUseCase.execute(widget.productId);
  }

  void _addToCart(ProductDetail product) async {
    int quantity = int.tryParse(_quantityController.text) ?? 0;

    if (quantity <= 0) {
      _showAlert('Pon una cantidad mayor a 0.');
      return;
    }
    if (quantity > product.stock) {
      _showAlert('Cantidad excede el inventario.');
      return;
    }

    await storage.ready;
    List<dynamic> cart = storage.getItem('cart') ?? [];

    final existingProduct = cart.firstWhere(
      (item) => item['name'] == product.title,
      orElse: () => <String,
          dynamic>{},
    );

    if (existingProduct.isNotEmpty) {
      int newQuantity = existingProduct['quantity'] + quantity;
      if (newQuantity > product.stock) {
        _showAlert('Inventario excedido.');
        return;
      }
      existingProduct['quantity'] = newQuantity;
      existingProduct['total'] = newQuantity * product.price;
    } else {
      if (cart.length >= 7) {
        _showAlert('Solo puedes tener 7 diferentes productos.');
        return;
      }

      cart.add({
        'name': product.title,
        'quantity': quantity,
        'price': product.price,
        'total': quantity * product.price,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'thumbnail': product.thumbnail,
      });
    }

    storage.setItem('cart', cart);
    _showAlert('Producto añadido.');
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
      ),
      body: FutureBuilder<ProductDetail>(
        future: _productDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Precio: \$${product.price}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Stock: ${product.stock}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Cantidad',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _addToCart(product),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: const Size(80, 40),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 5),
                        Text('Agregar'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

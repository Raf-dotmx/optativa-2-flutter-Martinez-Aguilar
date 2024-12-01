import 'package:flutter/material.dart';
import 'package:flutter_examen_2/modules/cart/domain/dto/carro_Dto.dart';
import 'package:flutter_examen_2/modules/cart/domain/repository/carro_repository.dart';
import 'package:flutter_examen_2/modules/cart/useCase/carro_useCase.dart';
import 'package:flutter_examen_2/screens/detallado_producto.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  late CartUseCase _cartUseCase;
  List<CartItemDTO> cartItems = [];
  double totalAmount = 0;

  @override
  void initState() {
    super.initState();
    _cartUseCase = CartUseCase(CartRepository());
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    final items = await _cartUseCase.loadCartItems();
    setState(() {
      cartItems = items;
      totalAmount = _cartUseCase.calculateTotalAmount(cartItems);
    });
  }

  void _removeItem(int index) async {
    final updatedCartItems = await _cartUseCase.removeItem(cartItems, index);
    setState(() {
      cartItems = updatedCartItems;
      totalAmount =
          _cartUseCase.calculateTotalAmount(cartItems);
    });
  }

  void _viewProductDetail(int productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalladoProducto(productId: productId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total: \$${totalAmount.toStringAsFixed(2)}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                cartItems.clear();
                totalAmount = 0;
              });
            },
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('No products in cart.'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Image.network(
                      item.thumbnail,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.name),
                    subtitle: Text('Total: \$${item.total.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeItem(index),
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

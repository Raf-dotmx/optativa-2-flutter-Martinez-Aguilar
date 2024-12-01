import 'package:flutter/material.dart';
import 'package:flutter_examen_2/modules/buscador/domain/dto/buscador.dart';
import 'package:flutter_examen_2/modules/buscador/useCase/buscador_usecase.dart';

class ProductSearchScreen extends StatefulWidget {
  final ProductSearchUseCase useCase;

  const ProductSearchScreen({super.key, required this.useCase});

  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<ProductSearchDTO> _products = [];
  bool _isLoading = false;
  String _error = '';

  void _searchProducts() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final products = await widget.useCase.execute(query);
      setState(() {
        _products = products;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Productos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchProducts,
                ),
              ),
              onSubmitted: (_) => _searchProducts(),
            ),
            const SizedBox(height: 16),
            if (_isLoading) CircularProgressIndicator(),
            if (_error.isNotEmpty) Text('Error: $_error', style: TextStyle(color: Colors.red)),
            if (!_isLoading && _error.isEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return ListTile(
                      leading: Image.network(product.thumbnail, width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(product.title),
                      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                      onTap: () {
                        // Navigate to product details if needed
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

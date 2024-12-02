import 'package:flutter/material.dart';
import '../router/routers.dart';

class PersistentLayout extends StatefulWidget {
  final Widget child;

  const PersistentLayout({super.key, required this.child});

  @override
  _PersistentLayoutState createState() => _PersistentLayoutState();
}

class _PersistentLayoutState extends State<PersistentLayout> {
  int _selectedIndex = 0;

  final List<String> _routes = [
    Routers.pantallaCategorias,
    Routers.pantallaBuscador,
    Routers.pantallaCarrito,
    Routers.productosVistosPantalla,
    Routers.pantallaPerfil,
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    _selectedIndex =
        _routes.indexOf(currentRoute ?? Routers.pantallaCategorias);
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      Navigator.pushReplacementNamed(context, _routes[index]);
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorías',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscador',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Vistos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

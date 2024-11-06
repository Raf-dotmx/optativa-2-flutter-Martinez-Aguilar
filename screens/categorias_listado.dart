import 'package:flutter/material.dart';
import 'package:flutter_examen_2/infraestructure/connection/connection.dart';
import 'package:flutter_examen_2/modules/categories/domain/dto/category.dart';
import 'package:flutter_examen_2/modules/categories/domain/repository/category_repository.dart';
import 'package:flutter_examen_2/modules/categories/useCase/category_usecase.dart';
import 'package:flutter_examen_2/router/routers.dart';

class CategoriasListado extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoriasListado> {
  late GetCategoriesUseCase _getCategoriesUseCase;
  late Future<List<Category>> _categories;

  @override
  void initState() {
    super.initState();

    Connection connection = Connection();
    CategoryRepository repository = CategoryRepository(connection);

    _getCategoriesUseCase = GetCategoriesUseCase(repository: repository);

    _categories = _getCategoriesUseCase.execute(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Category>>(
        future: _categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories available.'));
          }

          List<Category> categories = snapshot.data!;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              Category category = categories[index];

              Icon categoryIcon = index % 2 == 0
                  ? const Icon(Icons.shopping_bag, color: Colors.blue)
                  : const Icon(Icons.fastfood, color: Colors.red);

              return ListTile(
                leading: categoryIcon,
                title: Text(category.name),
                subtitle: Text(category.slug),
                trailing: Icon(Icons.arrow_forward_ios,
                    color: index % 2 == 0 ? Colors.blue : Colors.red),
                onTap: () {
                  //print("'${category.name}' category selected");
                  Navigator.pushNamed(context, Routers.pantallaProductos,
                      arguments: category.slug);
                },
              );
            },
          );
        },
      ),
    );
  }
}

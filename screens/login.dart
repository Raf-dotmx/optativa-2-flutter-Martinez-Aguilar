import 'package:flutter/material.dart';
import 'package:flutter_examen_2/router/routers.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,  
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), //
                image: const DecorationImage(
                  image: AssetImage('lib/assets/login.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Usuario',
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Contraseña',
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, Routers.pantallaCategorias);
                },
                child: const Text("Ingresar"))
          ],
        ),
      ),
    );
  }
}

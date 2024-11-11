import 'package:flutter/material.dart';
import 'package:flutter_examen_2/modules/login/domain/dto/user_credentials.dart';
import 'package:flutter_examen_2/modules/login/useCase/login_usecase.dart';
import '../router/routers.dart';
import 'package:localstorage/localstorage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerUsuario = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: const DecorationImage(
                    image: AssetImage('lib/assets/login.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _controllerUsuario,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Usuario',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _controllerPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // cambiar a la pantalla de categorias
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    final LocalStorage storage = LocalStorage('token');

                    final UserCredentials credentials = UserCredentials(
                      user: _controllerUsuario.text,
                      password: _controllerPassword.text,
                    );
                    
                    LoginUseCase().execute(credentials).then((response) {
                      storage.setItem('accessToken', response.accessToken);
                      Navigator.pushNamed(context, Routers.pantallaCategorias);
                    });
                  });
                },
                // cambiar estilo del boton login
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  minimumSize: const Size(100, 50),
                ),
                child: const Text("Ingresar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

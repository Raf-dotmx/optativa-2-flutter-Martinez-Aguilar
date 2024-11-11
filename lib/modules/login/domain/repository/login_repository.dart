import 'package:flutter_examen_2/infraestructure/app/repository/repository.dart';
import 'package:flutter_examen_2/infraestructure/connection/connection.dart';
import 'package:flutter_examen_2/modules/login/domain/dto/user_credentials.dart';
import 'package:flutter_examen_2/modules/login/domain/dto/user_login_response.dart';

class LoginRepository
    implements Repository<UserCredentials, UserLoginResponse > {
  @override
  Future<UserLoginResponse> execute(UserCredentials params) async {
    final data = {
      "username": params.user,
      "password": params.password,
      "expiresInMins": 30,
    };
    String url = "https://dummyjson.com/auth/login";
    Connection connection = Connection();
    final response = await connection.post(url, data, headers: {
      'Content-Type': 'application/json',
    });

    return UserLoginResponse.fromJson(response);
  }
}

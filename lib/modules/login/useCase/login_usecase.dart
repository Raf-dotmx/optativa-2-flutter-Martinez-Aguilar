import 'package:flutter_examen_2/infraestructure/app/useCase/use_case.dart';
import 'package:flutter_examen_2/modules/login/domain/dto/user_credentials.dart';
import 'package:flutter_examen_2/modules/login/domain/dto/user_login_response.dart';
import 'package:flutter_examen_2/modules/login/domain/repository/login_repository.dart';


class LoginUseCase implements UseCase<dynamic, UserCredentials> {

  @override
  Future<dynamic> execute(UserCredentials params) async {
    final UserCredentials credentials = UserCredentials(
      user: params.user,
      password: params.password,
    );

    final UserLoginResponse response =
        await LoginRepository().execute(credentials);
    return response;
  }
}

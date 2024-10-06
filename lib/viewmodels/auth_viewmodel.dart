import 'package:routineapp/config/app_config.dart';

import '../models/user/login_model.dart';
import '../models/user/user_model.dart';
import '../services/auth_service.dart';

class AuthViewModel {
  final AuthService _authService = AuthService();

  Future<LoginResponse?> login(String email, String password) async {
    LoginRequest authRequest = LoginRequest(email: email, password: password);
    LoginResponse? response = await _authService.login(authRequest);

    AppConfig.saveToken(response?.token);
    AppConfig.saveUser(response?.user);

    return response;
  }

  Future<UserResponse?> register(
      String name, String email, String password) async {
    CreateUserRequest createUserRequest =
        CreateUserRequest(name: name, email: email, password: password);
    UserResponse? response = await _authService.register(createUserRequest);

    return response;
  }
}

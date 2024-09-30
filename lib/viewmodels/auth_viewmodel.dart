import 'package:routineapp/models/user_model.dart';

import '../models/login_model.dart';
import '../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewmodel {
  final AuthService _authService = AuthService();

  Future<LoginResponse?> login(String email, String password) async {
    LoginRequest authRequest = LoginRequest(email: email, password: password);
    LoginResponse? response = await _authService.login(authRequest);


    return response;
  }

  Future<UserResponse?> register(
      String name, String email, String password) async {
    CreateUserRequest createUserRequest = CreateUserRequest(name: name, email: email, password: password);
    UserResponse? response = await _authService.register(createUserRequest);

    return response;
  }

  Future<void> saveToken(String? token) async {
    if (token != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_token', token);
    }
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_token');
  }
}

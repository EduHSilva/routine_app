import '../models/auth_response.dart';
import '../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewmodel {
  final AuthService _authService = AuthService();

  Future<AuthResponse?> login(String email, String password) async {
    AuthRequest authRequest = AuthRequest(email: email, password: password);
    AuthResponse? response = await _authService.login(authRequest);

    saveToken(response?.token);

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

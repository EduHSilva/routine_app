import '../models/auth_response.dart';
import '../services/auth_service.dart';

class LoginViewModel {
  final AuthService _authService = AuthService();

  Future<AuthResponse?> login(String email, String password) async {
    AuthRequest authRequest = AuthRequest(email: email, password: password);
    return await _authService.authenticate(authRequest);
  }
}

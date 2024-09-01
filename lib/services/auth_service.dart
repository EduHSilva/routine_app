import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_response.dart';

class AuthService {
  final String apiUrl = 'http://192.168.0.94:3006/api/v1/login'; // URL da API

  Future<AuthResponse?> authenticate(AuthRequest authRequest) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': authRequest.email,
          'password': authRequest.password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return AuthResponse.fromJson(jsonResponse);
      } else {
        // Falha na autenticação
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

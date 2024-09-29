import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:routineapp/config/app_config.dart';
import '../models/auth_response.dart';

class AuthService {
  final String apiUrl = '${AppConfig.apiUrl}login';

  Future<AuthResponse?> login(AuthRequest authRequest) async {
    http.Client client = await AppConfig.getHttpClient();

    try {
      final response = await client.post(
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
        return null;
      }
    } catch (e) {
      //
    }
    return null;
  }
}

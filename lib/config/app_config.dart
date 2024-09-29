import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppConfig {
  static String get apiUrl => dotenv.env['URL_API'] ?? 'http://default-url.com/';

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
  }

  static Future<http.Client> getHttpClient() async {
    final token = await getToken();

    return _HttpClientWithBearerToken(token);
  }

  static Logger getLogger() {
    var logger = Logger();
    return logger;
  }
}

class _HttpClientWithBearerToken extends http.BaseClient {
  final String? token;
  final http.Client _client = http.Client();

  _HttpClientWithBearerToken(this.token);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (token != null) {
      request.headers['x-access-token'] = '$token';
    }
    return _client.send(request);
  }
}



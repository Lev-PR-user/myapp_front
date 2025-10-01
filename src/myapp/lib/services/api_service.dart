// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Для веб-браузера используйте localhost или ваш IP
  static const String baseUrl = 'http://localhost:5000/api';

  // Или если localhost не работает, используйте:
  // static const String baseUrl = 'http://127.0.0.1:5000/api';

  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final http.Client _client = http.Client();

  Map<String, String> _getHeaders() {
    return {'Content-Type': 'application/json', 'Accept': 'application/json'};
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      print('Sending POST to: $baseUrl$endpoint');
      print('Data: $data');

      final response = await _client.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(),
        body: json.encode(data),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      print('Network error: $e');
      throw Exception('Network error: $e');
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {'success': true};
      return json.decode(response.body);
    } else {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }
  }
}

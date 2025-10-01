import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api';

  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final http.Client _client = http.Client();

  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Origin': 'http://localhost:3000',
    };
  }

  Future<dynamic> get(String endpoint) async {
    try {
      final url = '$baseUrl$endpoint';
      print('🌐 GET: $url');

      final response = await _client.get(
        Uri.parse(url),
        headers: _getHeaders(),
      );

      print('📨 Response: ${response.statusCode}');
      print('📦 Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      print('❌ Network error: $e');
      throw Exception('Network error: $e');
    }
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      final url = '$baseUrl$endpoint';
      print('🌐 POST: $url');
      print('📤 Data: $data');

      final response = await _client.post(
        Uri.parse(url),
        headers: _getHeaders(),
        body: json.encode(data),
      );

      print('📨 Response: ${response.statusCode}');
      print('📦 Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      print('❌ Network error: $e');
      throw Exception('Network error: $e');
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      final url = '$baseUrl$endpoint';
      print('🌐 DELETE: $url');

      final response = await _client.delete(
        Uri.parse(url),
        headers: _getHeaders(),
      );

      print('📨 Response: ${response.statusCode}');
      print('📦 Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      print('❌ Network error: $e');
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

  // Метод для тестирования соединения
  Future<bool> testConnection() async {
    try {
      final response = await get('/test');
      print('✅ Backend connection test: $response');
      return true;
    } catch (e) {
      print('❌ Backend connection failed: $e');
      return false;
    }
  }
}

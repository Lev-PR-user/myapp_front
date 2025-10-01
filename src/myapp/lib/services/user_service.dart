// user_service.dart
import 'api_service.dart';

class UserService {
  final ApiService _api = ApiService();

  Future<dynamic> login(String email, String password) async {
    return await _api.post('/users/login', {
      'email': email,
      'password': password,
    });
  }

  Future<dynamic> register(String login, String email, String password) async {
    return await _api.post('/users/register', {
      'login_name': login,
      'email': email,
      'password': password,
    });
  }
}

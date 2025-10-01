import 'api_service.dart';
import '../models/product.dart';

class CartService {
  final ApiService _api = ApiService();

  Future<List<Product>> getProducts() async {
    try {
      final response = await _api.get('/products');
      print('Products response: $response');

      if (response is List) {
        return response.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected response format: $response');
      }
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Failed to load products: $e');
    }
  }

  Future<Map<String, dynamic>> addToCart(
    int userId,
    int productId,
    int quantity,
  ) async {
    return await _api.post('/cart/add', {
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
    });
  }

  Future<List<CartItem>> getCart(int userId) async {
    try {
      final response = await _api.get('/cart?userId=$userId');
      print('Cart response: $response');

      if (response is List) {
        return response.map((json) => CartItem.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching cart: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> removeFromCart(int userId, int productId) async {
    return await _api.delete('/cart/$productId?userId=$userId');
  }
}

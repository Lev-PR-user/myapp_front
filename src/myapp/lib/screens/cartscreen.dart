import 'package:flutter/material.dart';
import '../models/userdata.dart';
import '../models/product.dart';
import '../services/cart_service.dart';

class CartScreen extends StatefulWidget {
  final UserData userData;

  const CartScreen({super.key, required this.userData});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();
  List<CartItem> cartItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    try {
      final userId = int.tryParse(widget.userData.userId ?? '0') ?? 0;
      if (userId == 0) return;

      final cartList = await _cartService.getCart(userId);
      setState(() {
        cartItems = cartList;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading cart: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _removeFromCart(int productId) async {
    try {
      final userId = int.tryParse(widget.userData.userId ?? '0') ?? 0;
      if (userId == 0) return;

      await _cartService.removeFromCart(userId, productId);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Item removed from cart')));

      _loadCart(); // Обновляем корзину
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to remove item: $e')));
    }
  }

  double get totalPrice {
    return cartItems.fold(
      0,
      (total, item) => total + (item.price * item.quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return CartItemCard(
                        item: item,
                        onRemove: _removeFromCart,
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final Function(int) onRemove;

  const CartItemCard({super.key, required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Image.network(
          item.imageUrl.isNotEmpty
              ? item.imageUrl
              : 'https://via.placeholder.com/60x60/4A6572/FFFFFF?text=No+Image',
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 60,
              height: 60,
              color: Colors.grey.shade300,
              child: Icon(Icons.photo, color: Colors.grey.shade600),
            );
          },
        ),
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('\$${item.price.toStringAsFixed(2)}'),
            Text('Quantity: ${item.quantity}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => onRemove(item.productId),
        ),
      ),
    );
  }
}

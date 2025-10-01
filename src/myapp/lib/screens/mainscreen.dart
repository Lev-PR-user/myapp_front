import 'package:flutter/material.dart';
import 'profilescreen.dart';
import '/models/userdata.dart';
import 'settingsscreen.dart';

class MainScreen extends StatelessWidget {
  final UserData userData;

  MainScreen({super.key, required this.userData});

  // Пример данных товаров
  final List<Product> products = [
    Product(
      name: 'Wireless Headphones',
      price: 99.99,
      imageUrl:
          'https://via.placeholder.com/150x150/4A6572/FFFFFF?text=Headphones',
      rating: 4.5,
    ),
    Product(
      name: 'Smart Watch',
      price: 199.99,
      imageUrl:
          'https://via.placeholder.com/150x150/344955/FFFFFF?text=Smart+Watch',
      rating: 4.2,
    ),
    Product(
      name: 'Laptop Backpack',
      price: 49.99,
      imageUrl:
          'https://via.placeholder.com/150x150/F9AA33/000000?text=Backpack',
      rating: 4.7,
    ),
    Product(
      name: 'Phone Case',
      price: 19.99,
      imageUrl:
          'https://via.placeholder.com/150x150/232F34/FFFFFF?text=Phone+Case',
      rating: 4.0,
    ),
    Product(
      name: 'Bluetooth Speaker',
      price: 79.99,
      imageUrl:
          'https://via.placeholder.com/150x150/4A6572/FFFFFF?text=Speaker',
      rating: 4.3,
    ),
    Product(
      name: 'Fitness Tracker',
      price: 59.99,
      imageUrl:
          'https://via.placeholder.com/150x150/344955/FFFFFF?text=Fitness',
      rating: 4.1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Store'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Приветственная секция
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade500, Colors.indigo.shade300],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Tech Store!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Discover amazing gadgets and accessories',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),

          // Заголовок товаров
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Featured Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ),

          // Сетка товаров
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              ),
            ),
          ),

          // Нижняя навигационная панель
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Кнопка профиля
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(userData: userData),
                      ),
                    );
                  },
                  icon: Icon(Icons.person, color: Colors.indigo.shade600),
                  tooltip: 'Profile',
                ),

                // Кнопка настроек
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                  icon: Icon(Icons.settings, color: Colors.indigo.shade600),
                  tooltip: 'Settings',
                ),

                // Кнопка корзины
                IconButton(
                  onPressed: () {
                    // Действие для корзины
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Cart feature coming soon!')),
                    );
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.indigo.shade600,
                  ),
                  tooltip: 'Shopping Cart',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Модель товара
class Product {
  final String name;
  final double price;
  final String imageUrl;
  final double rating;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });
}

// Виджет карточки товара
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Изображение товара
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              product.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 120,
                  color: Colors.grey.shade300,
                  child: Icon(Icons.photo, color: Colors.grey.shade600),
                );
              },
            ),
          ),

          // Информация о товаре
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Название товара
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // Рейтинг
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(
                      product.rating.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Цена
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.indigo.shade700,
                  ),
                ),

                const SizedBox(height: 8),

                // Кнопка добавления в корзину
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.name} added to cart!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade500,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 12),
                    ),
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

class Product {
  final int productId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final int stockQuantity;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.stockQuantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    print('Parsing product: $json');

    return Product(
      productId: json['product_id'] is int
          ? json['product_id']
          : int.tryParse(json['product_id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? 'No Name',
      description: json['description']?.toString() ?? '',
      price: (json['price'] is num
          ? json['price'].toDouble()
          : double.tryParse(json['price']?.toString() ?? '0') ?? 0.0),
      imageUrl:
          json['image_url']?.toString() ??
          'https://via.placeholder.com/150x150/4A6572/FFFFFF?text=No+Image',
      rating: (json['rating'] is num
          ? json['rating'].toDouble()
          : double.tryParse(json['rating']?.toString() ?? '0') ?? 0.0),
      stockQuantity: json['stock_quantity'] is int
          ? json['stock_quantity']
          : int.tryParse(json['stock_quantity']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'rating': rating,
      'stock_quantity': stockQuantity,
    };
  }
}

class CartItem {
  final int cartId;
  final int productId;
  final int quantity;
  final String name;
  final double price;
  final String imageUrl;
  final int stockQuantity;

  CartItem({
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.stockQuantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartId: json['cart_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      name: json['name'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      imageUrl: json['image_url'] ?? '',
      stockQuantity: json['stock_quantity'] ?? 0,
    );
  }
}

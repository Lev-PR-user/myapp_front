const cartRepository = require('../repositories/cartRepository');

class CartService {
  
  async addToCart(userId, productId, quantity) {
    return await cartRepository.addToCart(userId, productId, quantity);
  }

  async getCart(userId) {
    return await cartRepository.getCart(userId);
  }

  async removeFromCart(userId, productId) {
    return await cartRepository.removeFromCart(userId, productId);
  }

  async getUpdatedProducts() {
    return await cartRepository.getUpdatedProducts();
  }
}

module.exports = new CartService();
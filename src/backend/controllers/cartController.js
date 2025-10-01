const cartService = require('../servises/cartService')

class CartController {
  async addToCart(req, res) {
    try {
      const { productId, quantity = 1 } = req.body;
      const userId = 1; 
      console.log(`Adding product ${productId} to cart for user ${userId}`);
      const result = await cartService.addToCart(userId, productId, quantity);
      res.json(result);
    } catch (error) {
      console.error('Error in addToCart:', error);
      res.status(400).json({ message: error.message });
    }
  }

  async getCart(req, res) {
    try {
      const userId = 1; 
      console.log(`Getting cart for user ${userId}`);
      const cart = await cartService.getCart(userId);
      res.json(cart);
    } catch (error) {
      console.error('Error in getCart:', error);
      res.status(500).json({ message: error.message });
    }
  }

  async removeFromCart(req, res) {
    try {
      const { productId } = req.params;
      const userId = 1; 

      console.log(`Removing product ${productId} from cart for user ${userId}`);
      const result = await cartService.removeFromCart(userId, productId);
      res.json(result);
    } catch (error) {
      console.error('Error in removeFromCart:', error);
      res.status(400).json({ message: error.message });
    }
  }

  async getProducts(req, res) {
    try {
      console.log('Getting updated products from cart controller');
      const products = await cartService.getUpdatedProducts();
      res.json(products);
    } catch (error) {
      console.error('Error in getProducts:', error);
      res.status(500).json({ message: error.message });
    }
  }
}

module.exports = new CartController();
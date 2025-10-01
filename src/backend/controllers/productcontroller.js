// controllers/ProductController.js
const productService = require('../servises/productservice');

class ProductController {
  async getProducts(req, res) {
    try {
      console.log('Fetching all products...');
      const products = await productService.getAllProducts();
      console.log(`Found ${products.length} products`);
      res.json(products);
    } catch (error) {
      console.error('Error in getProducts:', error);
      res.status(500).json({ 
        message: error.message || 'Internal server error',
        error: process.env.NODE_ENV === 'development' ? error.stack : undefined
      });
    }
  }

  async getProduct(req, res) {
    try {
      const productId = parseInt(req.params.id);
      console.log(`Fetching product with ID: ${productId}`);
      
      const product = await productService.getProductById(productId);
      res.json(product);
    } catch (error) {
      console.error('Error in getProduct:', error);
      if (error.message === 'Product not found') {
        res.status(404).json({ message: error.message });
      } else {
        res.status(500).json({ 
          message: error.message || 'Internal server error' 
        });
      }
    }
  }

  async createProduct(req, res) {
    try {
      console.log('Creating new product:', req.body);
      const product = await productService.createProduct(req.body);
      res.status(201).json(product);
    } catch (error) {
      console.error('Error in createProduct:', error);
      res.status(400).json({ 
        message: error.message || 'Bad request' 
      });
    }
  }
}

module.exports = new ProductController();
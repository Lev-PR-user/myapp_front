// services/productService.js
const productRepository = require('../repositories/productrepository');

class ProductService {
  async getAllProducts() {
    try {
      return await productRepository.getAllProducts();
    } catch (error) {
      console.error('Error in ProductService.getAllProducts:', error);
      throw new Error('Failed to fetch products');
    }
  }

  async getProductById(productId) {
    try {
      const product = await productRepository.getProductById(productId);
      if (!product) {
        throw new Error('Product not found');
      }
      return product;
    } catch (error) {
      console.error('Error in ProductService.getProductById:', error);
      throw error;
    }
  }

  async createProduct(productData) {
    try {
      // Валидация
      if (!productData.name || !productData.price) {
        throw new Error('Name and price are required');
      }
      
      // Преобразование типов
      const processedData = {
        name: productData.name,
        description: productData.description || null,
        price: parseFloat(productData.price),
        image_url: productData.image_url || null,
        rating: productData.rating ? parseFloat(productData.rating) : 0.0,
        stock_quantity: productData.stock_quantity ? parseInt(productData.stock_quantity) : 0
      };

      return await productRepository.createProduct(processedData);
    } catch (error) {
      console.error('Error in ProductService.createProduct:', error);
      throw error;
    }
  }
}

module.exports = new ProductService();
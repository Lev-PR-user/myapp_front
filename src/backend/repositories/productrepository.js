const pool = require('../config/db');

class ProductRepository {
  async getAllProducts() {
    try {
      const result = await pool.query(
        'SELECT * FROM products ORDER BY product_id'
      );
      return result.rows;
    } catch (error) {
      console.error('Database error in getAllProducts:', error);
      throw error;
    }
  }

  async getProductById(productId) {
    try {
      const result = await pool.query(
        'SELECT * FROM products WHERE product_id = $1',
        [productId]
      );
      return result.rows[0];
    } catch (error) {
      console.error('Database error in getProductById:', error);
      throw error;
    }
  }

  async createProduct(productData) {
    try {
      const { name, description, price, image_url, rating, stock_quantity } = productData;
      const result = await pool.query(
        `INSERT INTO products (name, description, price, image_url, rating, stock_quantity) 
         VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
        [name, description, price, image_url, rating, stock_quantity]
      );
      return result.rows[0];
    } catch (error) {
      console.error('Database error in createProduct:', error);
      throw error;
    }
  }
}

module.exports = new ProductRepository();
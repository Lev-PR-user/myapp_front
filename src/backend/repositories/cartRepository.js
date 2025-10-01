const pool = require('../config/db');

class CartRepository {
  
  async addToCart(userId, productId, quantity = 1) {
    const client = await pool.connect();
    
    try {
      await client.query('BEGIN');

      const productResult = await client.query(
        'SELECT stock_quantity FROM products WHERE product_id = $1',
        [productId]
      );

      if (productResult.rows.length === 0) {
        throw new Error('Product not found');
      }

      const currentStock = productResult.rows[0].stock_quantity;

      if (currentStock < quantity) {
        throw new Error(`Only ${currentStock} items available`);
      }

      await client.query(
        'UPDATE products SET stock_quantity = stock_quantity - $1 WHERE product_id = $2',
        [quantity, productId]
      );

      const existingCart = await client.query(
        'SELECT * FROM cart WHERE user_id = $1 AND product_id = $2',
        [userId, productId]
      );

      if (existingCart.rows.length > 0) {
        await client.query(
          'UPDATE cart SET quantity = quantity + $1 WHERE user_id = $2 AND product_id = $3',
          [quantity, userId, productId]
        );
      } else {
        await client.query(
          'INSERT INTO cart (user_id, product_id, quantity) VALUES ($1, $2, $3)',
          [userId, productId, quantity]
        );
      }

      await client.query('COMMIT');
      
      return { 
        success: true, 
        message: 'Product added to cart',
        remainingStock: currentStock - quantity
      };
    } catch (error) {
      await client.query('ROLLBACK');
      throw error;
    } finally {
      client.release();
    }
  }

  async getCart(userId) {
    const result = await pool.query(`
      SELECT c.*, p.name, p.price, p.image_url, p.stock_quantity 
      FROM cart c 
      JOIN products p ON c.product_id = p.product_id 
      WHERE c.user_id = $1
    `, [userId]);
    
    return result.rows;
  }

  async removeFromCart(userId, productId) {
    const client = await pool.connect();
    
    try {
      await client.query('BEGIN');

      const cartItem = await client.query(
        'SELECT quantity FROM cart WHERE user_id = $1 AND product_id = $2',
        [userId, productId]
      );

      if (cartItem.rows.length > 0) {
        const quantity = cartItem.rows[0].quantity;
        
        await client.query(
          'DELETE FROM cart WHERE user_id = $1 AND product_id = $2',
          [userId, productId]
        );

        await client.query(
          'UPDATE products SET stock_quantity = stock_quantity + $1 WHERE product_id = $2',
          [quantity, productId]
        );
      }

      await client.query('COMMIT');
      return { success: true };
    } catch (error) {
      await client.query('ROLLBACK');
      throw error;
    } finally {
      client.release();
    }
  }

  async getUpdatedProducts() {
    const result = await pool.query(`
      SELECT * FROM products ORDER BY product_id
    `);
    return result.rows;
  }
}

module.exports = new CartRepository();
class Product {
  constructor(product_id, name, description, price, image_url, rating, stock_quantity) {
    this.product_id = product_id;
    this.name = name;
    this.description = description;
    this.price = price;
    this.image_url = image_url;
    this.rating = rating;
    this.stock_quantity = stock_quantity;
  }
}

module.exports = Product;
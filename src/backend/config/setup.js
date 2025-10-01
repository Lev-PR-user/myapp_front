async function CreateTables(pool){
    try {

    const CreateUsers =
    `Create table users (
        user_id Serial Primary key,
        email varchar(255) not null, 
        login_name varchar(100),
        password varchar not null
        )`;   

    const CreateProduct = `
    Create table products (
    product_id Serial Primary key,
    name varchar(255) not null,
    description TEXT,
    price DECIMAL(10, 2) not null,
    image_url varchar(500),
    rating DECIMAL(2, 1) DEFAULT 0.0,
    stock_quantity Integer DEFAULT 0
    )`;

    const CreateCart = `
    Create table cart (
    cart_id Serial Primary key,
    user_id Integer,
    product_id Integer REFERENCES products(product_id),
    quantity Integer DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);`

    const InsertProduct = `
    INSERT INTO products (name, description, price, image_url, rating, stock_quantity) VALUES
('Wireless Headphones', 'High-quality wireless headphones with noise cancellation', 8600, 'https://www.karmanow.com/fog_uploads/tag_89218039/c_pad%2Ch_1400%2Cw_1400/89218039_1729197734.webp', 4.5, 15),
('Smart Watch', 'Feature-rich smartwatch with health monitoring', 199.99, 'https://cdn0.youla.io/files/images/720_720_out/63/71/637166c55fd4a5392524577c-1.jpg', 4.2, 6),
('Laptop Backpack', 'Durable laptop backpack with USB charging port', 49.99, 'http://u.kanobu.ru/editor/images/37/4adf2df6-f998-4008-97b2-b752d8bc02f6.webp', 4.7, 20),
('Phone Case', 'Protective case with stylish design', 19.99, 'https://100comments.com/wp-content/uploads/2018/10/180823_OB_ACME2018_Social_Family_Product_v3_SetE-1920x1080-600x400.jpg', 4.0, 30),
('Bluetooth Speaker', 'Portable speaker with crystal clear sound', 79.99, 'https://via.placeholder.com/150x150/4A6572/FFFFFF?text=Speaker', 4.3, 12);`


await pool.query(CreateUsers)
console.log('users created')

await pool.query(CreateProduct)
console.log('Product created')

await pool.query(CreateCart)
console.log('cart created')

await pool.query(InsertProduct)
console.log('products added')

    } catch (error){
        console.error('Error Created', error.message)
    }

}

module.exports = CreateTables;
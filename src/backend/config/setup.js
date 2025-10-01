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


await pool.query(CreateUsers)
console.log('users created')

await pool.query(CreateProduct)
console.log('Product created')

await pool.query(CreateCart)
console.log('cart created')

    } catch (error){
        console.error('Error Created', error.message)
    }

}

module.exports = CreateTables;
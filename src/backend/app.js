const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const pool = require('./config/db');
const CreateTables = require('./config/setup');

const UserRouters = require('./routes/userroutes');
const productRoutes = require('./routes/productroutes');

dotenv.config();
const app = express()
const PORT = process.env.PORT || 5000;

app.use(cors({
    origin: true,
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization', 'Accept']
}));
app.use(express.json());


app.use('/api/users', UserRouters);
app.use('/api', productRoutes);


async function initializeApp() { 
    try{
    await CreateTables(pool) 

  app.listen(PORT, () => console.log(`Server running on port ${PORT}`)); 
} catch (error) {
console.error('Error initializeApp', error.message)
}
}

 initializeApp()
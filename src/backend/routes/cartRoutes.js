// routes/userRoutes.js
const express = require('express');
const router = express.Router();
const cartController = require('../controllers/cartController');

router.post('/cart/add', cartController.addToCart);
router.get('/cart', cartController.getCart);
router.delete('/cart/:productId', cartController.removeFromCart);
router.get('/products', cartController.getProducts);

module.exports = router;
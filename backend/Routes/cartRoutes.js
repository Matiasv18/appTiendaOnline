const express = require('express');

const authMiddleware = require('../middlewares/authmiddleware');

const {
    getCart,
    addToCart,
    updateCartItem,
    removeCartItem,
} = require('../controllers/cartController');

const router = express.Router();

router.use(authMiddleware); // Todas las rutas de este router requieren autenticación

router.get('/', getCart);
router.post('/', addToCart);
router.put('/:id', updateCartItem);
router.delete('/:id', removeCartItem);

module.exports = router;

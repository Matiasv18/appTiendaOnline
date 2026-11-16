// routes/authRoutes.js >...

//url
//POST funcion de regsitro - /routes/authRoutes/api/auth/register
//POSt funcion login - /routes/authRoutes/api/auth/login

const express = require('express');
const authMiddleware = require('../middlewares/authmiddleware');
const { register, login, getProfile } = require('../controllers/authController');

const router = express.Router();

router.post('/register', register);
router.post('/login', login);
router.get('/profile', authMiddleware, getProfile);

module.exports = router;

//GLOSARIO
// - router: agrupa rutas bajo un mismo prefijo, en este caso (/api/auth)
// - POST: método HTTP que se utiliza para enviar datos al servidor (registro y login en este caso)
// - require (): importa codigo de otros archivos, en este caso express y los controladores de autenticación

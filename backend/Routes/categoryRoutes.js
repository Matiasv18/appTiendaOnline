const express = require('express');
const { getCategories } = require('../controllers/categoryController');

const router = express.Router();

router.get('/', getCategories);

module.exports = router;

//GLOSARIO
// - router: agrupa rutas bajo un mismo prefijo, en este caso (/api/categories)
// - GET: método HTTP que se utiliza para obtener datos del servidor (categorias en este caso)
// - require (): importa codigo de otros archivos, en este caso express y los controladores de categorias

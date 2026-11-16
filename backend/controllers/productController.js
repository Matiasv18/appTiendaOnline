const pool = require('../config/db');


// TODOS LOS PRODUCTOS
async function getProducts(req, res) {
try {
    const[products]=await pool.query(`
        SELECT p.*, c.name AS category_name
        FROM products p
        JOIN categories c ON p.category_id = c.id
        ORDER BY p.name
        `);
        res.json(products);
    }catch (error) {
        console.error('Error en getproducts', error);
        res.status(500).json({ message: 'Error interno del servidor' });
    }
}

//UN PRODUCTO POR ID //url: /api/products/101
async function getProductById(req, res) {
    try {
        const { id } = req.params;

        const [products] = await pool.query(`
            SELECT p.*, c.name AS category_name
            FROM products p
            JOIN categories c ON p.category_id = c.id
            WHERE p.id = ?`, [id]);

        if (products.length === 0) {
            return res.status(404).json({ message: 'Producto no encontrado' });
        }

        return res.json(products[0]);
    } catch (error) {
        console.error('Error en getproductById', error);
        return res.status(500).json({ message: 'Error interno del servidor' });
    }
}


//Productos por categoria //url: /api/products/category/1
async function getProductsByCategory(req, res) {
    try{
        const { categoryId } = req.params;
        
        const [products] = await pool.query(`
            SELECT p.*, c.name AS category_name
            FROM products p
            JOIN categories c ON p.category_id = c.id
            WHERE p.category_id = ?
            ORDER BY p.name`, [categoryId]);
        res.json(products);// devolvemos productos que pertenecen a esa categoria

    }catch (error) {
        console.error('Error en getProductsByCategory', error);
        res.status(500).json({ message: 'Error interno del servidor' });
    }
}
module.exports = { getProducts, getProductById, getProductsByCategory };
// ========================================================================================================================================
//GLOSARIO
//- JOIN: une dos tablas relacionadas en una sola consulta, permitiendo combinar datos de ambas tablas.
//- req.params: valores de la URL (ej: :id, :categoryId)
// WHERE: filtra filas que cumplan una condición específica (ej: WHERE p.id = ?)
//- 404: codigo HTTP"no encontrado"
//==========================================================================================================================================
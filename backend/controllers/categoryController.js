const pool = require('../config/db');

async function getCategories(req, res) {
    try {
        const [categories] = await pool.query('SELECT * FROM categories ORDER BY name');
       
        res.json(categories);
    } catch (error) {
        console.error('Error fetching categories:', error);
        res.status(500).json({ message: 'Server error' });
    }

}
module.exports = { getCategories };

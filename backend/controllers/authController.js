//register
//loging

const bycrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const pool = require('../config/db');

//registro de usuario
async function register(req, res) {
    try {
    const { name, email, password } = req.body;

    //validar que todos los campos esten completos
    if (!name || !email || !password) {
        return res.status(400).json({ message: 'Please provide all required fields' });
    }
    //validar de pasword sea mayor a 6 caracteres
    if (password.length < 6) {
        return res.status(400).json({ message: 'Password must be at least 6 characters long' });
    }
    //verificar que el correo no este registrado
    const [existing] = await pool.query('SELECT * FROM users WHERE email = ?', [email]);
    if (existing.length > 0) {
        return res.status(400).json({ message: 'Email already registered' });
    }
    //encriptar la contraseña. niveles 10 de encriptacion
    const hashedPassword = await bycrypt.hash(password, 10);

    //guardar el usuario en la base de datos
    const [result] = await pool.query('INSERT INTO users (name, email, password) VALUES (?, ?, ?)', 
        [name, email, hashedPassword]

    );

    //crear token jwt(valido por 7 dias)
    const token = jwt.sign(
        { id: result.insertId, name, email }, 
        process.env.JWT_SECRET,
         { expiresIn: '7d' }
        );

        //responder 201 usuario creado con exito
        res.status(201).json({
             message: 'User registered successfully', 
             token,
            user: { id: result.insertId, name, email } 
        });
    } catch (error) {
        console.error('Error registering user:', error);
        res.status(500).json({ message: 'Server error' });
    }

}


//inicio de sesion
async function login(req, res) {
    try {
    const { email, password } = req.body;

    //validar que todos los campos esten completos
    if (!email || !password) {
        return res.status(400).json({ message: 'Please provide all required fields' });
    }
    //verificar que el correo este registrado
    const [users] = await pool.query('SELECT * FROM users WHERE email = ?', [email]);
    if (users.length === 0) {
        return res.status(401).json({ message: 'Invalid email or password' });
    }

    const user = users[0];

    //comparar la contraseña ingresada con la encriptada en la base de datos
    const isValid = await bycrypt.compare(password, user.password);

    if (!isValid) {
        return res.status(401).json({ message: 'Invalid email or password' });
    }
    
    //crear token jwt(valido por 7 dias)
    const token = jwt.sign(
        { id: user.id,  email: user.email }, 
        process.env.JWT_SECRET,
         { expiresIn: '7d' }
        );

        //le damos la bienvenida de inicio de sesion
        res.json({
             message: `Inicio de sesion exitoso para ${user.name}`, 
             token,
            user: { id: user.id, name: user.name, email: user.email }, 
        });

    }catch (error) {
        console.error('Error logging in user:', error);
        res.status(500).json({ message: 'Server error' });
    }


}
async function getProfile(req, res) {
    try {
        const [users] = await pool.query(
            'SELECT id, name, email FROM users WHERE id = ?',
            [req.user.id]
        );

        if (users.length === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        res.json(users[0]);
    } catch (error) {
        console.error('Error fetching user profile:', error);
        res.status(500).json({ message: 'Server error' });
    }
}

module.exports = { register, login, getProfile };
// ====================================================================================================================================================
// GLOSARIO
// - controller: archivo que contiene la logica de negocio de la aplicacion, en este caso, el registro y login de usuarios.
// - req.body: datos JSON que envia la app en el cuerpo de la peticion HTTP, en este caso, los datos del usuario a registrar o iniciar sesion.
// - bycrypt: convierte la contraseña en una cadena hash.
// - JWT: token que identifica al usuario logueado
// - assync/await: forma de esperar operaciones (consulta =BD) sin bloquear el hilo principal de ejecucion.
// - status 400: error del cliente | 401: no autorizado | 201: creado | 500: error servidor
// ===================================================================================================================================================

       

      
      

        //
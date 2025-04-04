// ✅ authController.js (actualizado y funcional)
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const Usuario = require("../models/Usuario");
const Alumno = require("../models/Alumno");
const Profesor = require("../models/Profesor");

// 📌 REGISTRO DE USUARIO
exports.register = async (req, res) => {
  try {
    console.log("📦 Datos recibidos en /register:", req.body);

    const { name, email, password, apellidos, telf } = req.body;

    if (!name || !email || !password) {
      return res.status(400).json({ error: "Faltan datos obligatorios" });
    }

    const existingUser = await Usuario.findOne({ where: { email } });
    if (existingUser) {
      return res.status(400).json({ msg: "El usuario ya existe" });
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    const nuevoUsuario = await Usuario.create({
      nombre: name,
      email: email,
      pass: hashedPassword,
      est_usuario: 1,
      user: email.split("@")[0],
      apellidos: apellidos,
      telf: telf,
      foto: "default.jpg",
      createdAt: new Date(),
      updatedAt: new Date()
    });

    res.json({
      msg: "✅ Usuario registrado exitosamente",
      user: nuevoUsuario
    });
  } catch (err) {
    console.error("❌ Error en /register:", err);
    res.status(500).json({ error: err.message });
  }
};

// 📌 LOGIN DE USUARIO
exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;
    console.log("📥 Intentando login con:", email);

    const user = await Usuario.findOne({ where: { email } });
    if (!user) {
      console.log("❌ Usuario no encontrado");
      return res.status(404).json({ msg: "Este correo no está registrado." });
    }

    const isMatch = await bcrypt.compare(password, user.pass);
    if (!isMatch) {
      console.log("❌ Contraseña incorrecta");
      return res.status(400).json({ msg: "Credenciales incorrectas" });
    }

    const token = jwt.sign(
      { id: user.id_usuario },
      process.env.JWT_SECRET,
      { expiresIn: "1h" }
    );

    let rol = "desconocido";
    const esAlumno = await Alumno.findOne({ where: { usuario_id_usuario: user.id_usuario } });
    const esProfesor = await Profesor.findOne({ where: { usuario_id_usuario: user.id_usuario } });

    if (esAlumno) rol = "alumno";
    else if (esProfesor) rol = "profesor";

    res.json({
      token,
      user: {
        id: user.id_usuario,
        name: user.nombre,
        email: user.email,
        rol: rol,
        telefono: user.telf,
        apellidos: user.apellidos
      }
    });
  } catch (err) {
    console.error("❌ Error en login:", err);
    res.status(500).json({ error: err.message });
  }
};

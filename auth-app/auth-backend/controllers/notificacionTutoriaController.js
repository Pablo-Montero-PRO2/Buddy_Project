const jwt = require("jsonwebtoken");
const { Op } = require("sequelize");
const Tutoria = require("../models/Tutoria");

exports.getTutoriasPendientes = async (req, res) => {
    try {
        const { auth_token } = req.headers;
        const id_usuario = jwt.verify(auth_token, process.env.JWT_SECRET)['id']
        console.log(id_usuario, jwt.verify(auth_token, process.env.JWT_SECRET))
    
        const tieneTutorias = await Tutoria.findOne({
            where: {
                [Op.or]: [
                    { profesor_usuario_id_usuario: id_usuario },
                    { alumno_usuario_id_usuario: id_usuario }
                ]
            }
        });
    
        if (!tieneTutorias) return res.status(404).json({ msg: "El usuario no tiene tutorías" });
    
        const fechaActual = new Date();
        const tutoriasPendientes = await Tutoria.findAll({
            where: {
                [Op.or]: [
                    { profesor_usuario_id_usuario: id_usuario },
                    { alumno_usuario_id_usuario: id_usuario }
                ],
                fecha_tutoria: { [Op.gte]: fechaActual } // Asegura que la fecha sea mayor o igual a la actual
            }
        });
        const cantidadTutoriasPendientes = tutoriasPendientes.length;
        return res.status(200).json({ cantidadTutoriasPendientes });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

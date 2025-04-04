const jwt = require("jsonwebtoken");
const { Op } = require("sequelize");
const Tutoria = require("../models/Tutoria");

exports.obtenerTutoriasProximas = async (req, res) => {
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
        const tutorias = await Tutoria.findAll({
            where: {
                [Op.and]: [
                    {
                        [Op.or]: [
                            { profesor_usuario_id_usuario: id_usuario },
                            { alumno_usuario_id_usuario: id_usuario }
                        ]
                    },
                    {
                        fecha_tutoria: {
                            [Op.gte]: fechaActual
                        }
                    }
                ]
            },
            order: [['fecha_tutoria', 'ASC']] // Opcional: ordenar por fecha y hora
        });
        return res.status(200).json({ tutorias })
    } catch (err) {
        res.status(500).json({ error: err.message})
    }
}
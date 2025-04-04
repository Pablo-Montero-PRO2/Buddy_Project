const jwt = require("jsonwebtoken");
const { Op } = require("sequelize");
const Mensajeria = require("../models/Mensajeria");

exports.getMensajesNoLeidos = async (req, res) => {
    try {
        const { auth_token } = req.headers;
        const id_usuario = jwt.verify(auth_token, process.env.JWT_SECRET)['id'];
        console.log(id_usuario, jwt.verify(auth_token, process.env.JWT_SECRET))
        const tieneMensajes = await Mensajeria.findOne({ where : { [Op.or]: [
            {profesor_usuario_id_usuario: id_usuario}, 
            {alumno_usuario_id_usuario: id_usuario}
        ]}});
        if (!tieneMensajes) return res.status(404).json({ msg: "El usuario no tiene mensajes "});
        const mensajesNoLeidos = await Mensajeria.findAll({ where : {
            [Op.or]: [
                { profesor_usuario_id_usuario: id_usuario}, 
                {alumno_usuario_id_usuario: id_usuario}
            ],
            est_mensaje: 0
        }});
        const cantidadMensajesNoLeidos = mensajesNoLeidos.length;
        return res.status(200).json({ cantidadMensajesNoLeidos });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

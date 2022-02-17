const Role = require('../models/role');

exports.getRoles = (req, res, next) => {
    Role.findAll()
        .then(result =>{
            console.log(result)
            res.json(result)
        })
        .catch(e => console.log(e))
}

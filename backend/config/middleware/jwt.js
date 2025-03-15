const jwt = require(`jsonwebtoken`)

const verifyToken = (req, res, next) => {
    try {
        const token = req.header(`Authorization`)?.replace(`Bearer `, ``)
        if(!token) res.status(401).json({msg: "Anda belum login"})

        jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
            if(err) return res.status(401).json({msg: "invalid or expires token"})
            req.user = decoded
            next()
        })
    } catch (error) {
        console.log(error)
        res.status(401).json({msg: error})
    }
}

module.exports = verifyToken
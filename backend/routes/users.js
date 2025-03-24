var express = require('express');
var router = express.Router();
const verifyToken = require(`../config/middleware/jwt`)
const {getUserWithProductById} = require(`../controller/userController`) 


/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

router.get('/seller', verifyToken, getUserWithProductById);

module.exports = router;

var express = require('express');
var router = express.Router();
const verifyToken = require(`../config/middleware/jwt`)
const {getUserWithProductById, updateUserById, getUsers, getAllUsers, changePassword, changeStatus} = require(`../controller/userController`) 
const multer = require("multer") 

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "public/images/user_images")
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()} - ${file.originalname}`)
    }
})

const fileFilter = (req, file, cb) => {
    console.log(file);
    if(!file.mimetype.startsWith("image/")) cb(new Error("File yang dimasukkan harus berupa gambar"), false)
    cb(null, true)
}

const upload = multer({storage, fileFilter})

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

router.get('/all-seller', getUsers);
router.get('/all-users', getAllUsers);
router.get('/change-status/:role/:id', verifyToken, changeStatus);
router.get('/seller', verifyToken, getUserWithProductById);
router.patch('/change-password', verifyToken, changePassword);
router.patch('/update', verifyToken, upload.single('path'), updateUserById);

module.exports = router;

const express = require(`express`)
const router = express.Router()
const product = require(`../controller/productController`)
const verifyToken = require(`../config/middleware/jwt`)
const multer = require("multer") 

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "public/images/product_images")
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

router.use(verifyToken)

router.get("/seller/:id", product.getProductByIdSeller)
router.get("/:id", product.getProductById)
router.get("/", product.getProduct)
router.post("/store", upload.array("path"), product.storeProduct)
router.patch("/update/:id",upload.array('path'), product.updateProduct)
router.delete("/delete/:id", product.deleteProduct)

module.exports = router
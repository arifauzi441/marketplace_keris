const express = require(`express`)
const router = express.Router()
const {register, registerAdmin, login, loginAdmin} = require(`../controller/authController`)

router.post(`/register`, register)
router.post(`/register-admin`, registerAdmin)
router.post(`/login`, login)
router.post(`/login-admin`, loginAdmin)

module.exports = router
const express = require(`express`)
const router = express.Router()
const verifyToken = require('../config/middleware/jwt')
const {
    register, 
    registerAdmin, 
    login, 
    loginAdmin, 
    forgotPassword, 
    verifyCode, 
    changePassword
} = require(`../controller/authController`)

router.post(`/register`, register)
router.post(`/register-admin`, registerAdmin)
router.post(`/login`, login)
router.post(`/login-admin`, loginAdmin)
router.post(`/forgotPassword`, forgotPassword)
router.post(`/verifyCode`, verifyCode)
router.post(`/changePassword`, verifyToken, changePassword)

module.exports = router
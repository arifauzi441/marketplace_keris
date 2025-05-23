const { Op, col } = require("sequelize")
const Admin = require("../model/Admin")
const Seller = require(`../model/SellerModel`)
const jwt = require(`jsonwebtoken`)
const AdminVerificationCode = require("../model/AdminVerificationCode")
const SellerVerificationCode = require("../model/SellerVerificationCode")
const twilio = require("twilio")
const { default: axios } = require("axios")
const qs = require('querystring');

const client = twilio(process.env.ACCOUNT_SID, process.env.AUTH_TOKEN)

const register = async (req, res, next) => {
    try {
        let { seller_phone, password, username, seller_name } = req.body
        let user = await Seller.findOne({
            where: {
                [Op.or]: [
                    { seller_phone },
                    { username }
                ]
            }
        })

        if (user) return res.status(401).json({ msg: "no hp / username telah digunakan" })

        let data = { seller_phone, password, username, seller_name, status: "belum diterima" }

        await Seller.create(data, { fields: ["seller_phone", "password", "seller_name", "username", "status"] })
        res.status(201).json({ msg: "Berhasil melakukan registrasi, menunggu konfirmasi" })
    } catch (error) {
        console.log(error)
        res.status(400).json({ msg: error })
    }
}

const registerAdmin = async (req, res, next) => {
    try {
        let { username, password, admin_phone, admin_name } = req.body
        let user = await Admin.findOne({
            where: {
                [Op.or]: [
                    { admin_phone },
                    { username }
                ]
            }
        })
        if (user) return res.status(401).json({ msg: "no hp / username telah digunakan" })

        let data = { username, password, admin_phone, admin_name, status: "belum diterima" }

        await Admin.create(data, { fields: ["username", "password", "admin_name", "admin_phone", "status"] })
        res.status(201).json({ msg: "Berhasil melakukan registrasi, menunggu konfirmasi" })
    } catch (error) {
        console.log(error)
        res.status(400).json({ msg: error })
    }
}

const login = async (req, res, next) => {
    try {
        let { username, password } = req.body
        let token = "";
        let data = await Seller.findOne({ where: { username } })

        if (!data) return res.status(404).json({ msg: "username tidak ditemukan", token: "" })

        if (password !== data.password) return res.status(401).json({ msg: "Password salah", token: "" })

        if (data.status === "belum diterima") return res.status(401).json({ msg: "register dalam status belum diterima", token: "" })
        token = jwt.sign({
            id: data.id_seller,
            username: data.username
        }, process.env.JWT_SECRET, { expiresIn: "1h" })

        res.status(200).json({ msg: "Berhasil Login", token })
    } catch (error) {
        console.log(error)
        res.status(401).json({ msg: error })
    }
}

const loginAdmin = async (req, res, next) => {
    try {
        let { username, password } = req.body
        let token = "";
        let data = await Admin.findOne({ where: { username } })

        if (!data) return res.status(404).json({ msg: "username tidak ditemukan", token: "" })

        if (password !== data.password) return res.status(401).json({ msg: "Password salah", token: "" })

        if (data.status === "belum diterima") return res.status(401).json({ msg: "register dalam status belum diterima", token: "" })
        token = jwt.sign({
            id: data.id_admin,
            username: data.username
        }, process.env.JWT_SECRET, { expiresIn: "1h" })

        res.status(200).json({ msg: "Berhasil Login", token })
    } catch (error) {
        console.log(error)
        res.status(401).json({ msg: error })
    }
}

const forgotPassword = async (req, res) => {
    try {
        let { phone_number, role } = req.body

        if (role == "admin") {
            let data = await Admin.findOne({ where: { admin_phone: phone_number, status: "diterima" } })
            if (!data) return res.status(404).json({ msg: "no telepon tidak ditemukan" })

            let random = Math.floor(100000 + Math.random() * 900000)
            let expired_at = new Date(Date.now() + 1 * 60 * 1000)

            let codeVerification = await AdminVerificationCode.create({
                id_admin: data.id_admin,
                verification_code: random,
                expired_at: expired_at.toLocaleDateString().replace(/\//g, '-') +
                    ' ' + expired_at.toLocaleTimeString('id-ID', { hour12: false }).replace(/\./g, ':')
            })
            let global_phone_number = (phone_number.startsWith('0')) ? `62` + phone_number.slice(1) : phone_number
            const payload = qs.stringify({
                userkey: process.env.ZANZIVA_USER_KEY,
                passkey: process.env.ZANZIVA_PASS_KEY,
                to: global_phone_number,
                brand: "(Marketplace Keris)",
                otp: codeVerification.dataValues.verification_code
            });

            const response = await axios.post('https://console.zenziva.net/waofficial/api/sendWAOfficial/', payload, {
                headers: {
                    'Content-Type': "application/x-www-form-urlencoded"
                }
            })
            if (response.data.status) {
                return res.status(200).json({ message: 'WA OTP sent successfully' });
            } else {
                return res.status(500).json({ error: 'Failed to send WA OTP', details: response.data.status });
            }

        } else {
            let data = await Seller.findOne({ where: { seller_phone: phone_number, status: "diterima" } })
            if (!data) return res.status(404).json({ msg: "no telepon tidak ditemukan" })

            let random = Math.floor(100000 + Math.random() * 900000)
            let expired_at = new Date(Date.now() + 1 * 60 * 1000)

            let codeVerification = await SellerVerificationCode.create({
                id_seller: data.id_seller,
                verification_code: random,
                expired_at: expired_at.toLocaleDateString().replace(/\//g, '-') +
                    ' ' + expired_at.toLocaleTimeString('id-ID', { hour12: false }).replace(/\./g, ':')
            })

            let global_phone_number = (phone_number.startsWith('0')) ? `62` + phone_number.slice(1) : phone_number
            const payload = qs.stringify({
                userkey: process.env.ZANZIVA_USER_KEY,
                passkey: process.env.ZANZIVA_PASS_KEY,
                to: global_phone_number,
                brand: "(Marketplace Keris)",
                otp: codeVerification.dataValues.verification_code
            });

            const response = await axios.post('https://console.zenziva.net/waofficial/api/sendWAOfficial/', payload, {
                headers: {
                    'Content-Type': "application/x-www-form-urlencoded"
                }
            })
            if (response.data.status) {
                return res.status(200).json({ message: 'WA OTP sent successfully' });
            } else {
                return res.status(500).json({ error: 'Failed to send WA OTP', details: response.data.status });
            }
        }

    } catch (error) {
        console.log(error)
        res.status(401).json({ msg: error })
    }
}

const verifyCode = async (req, res) => {
    try {
        let { phone_number, role, verification_code } = req.body
        console.log(req.body)
        let nowDate = new Date()

        if (role == "admin") {
            let data = await Admin.findOne({
                where: {
                    admin_phone: phone_number,
                },
                include: {
                    model: AdminVerificationCode,
                    where: {
                        verification_code,
                    },
                    required: true
                }
            })

            if (!data) return res.status(401).json({ msg: "kode verifikasi salah" })
            if (nowDate >= data.AdminVerificationCode.expired_at) return res.status(401).json({ msg: "expired code" })

            let token = jwt.sign({
                adminId: data.id_admin
            }, process.env.JWT_SECRET, { expiresIn: '5m' })

            return res.status(200).json({ msg: "berhasil verifikasi token", token })
        }

        let data = await Seller.findOne({
            where: {
                seller_phone: phone_number,
            },
            include: {
                model: SellerVerificationCode,
                where: {
                    verification_code,
                },
                required: true
            }
        })

        if (!data) return res.status(401).json({ msg: "kode verifikasi salah" })
        if (nowDate >= data.SellerVerificationCode.expired_at) return res.status(401).json({ msg: "expired code" })

        let token = jwt.sign({
            sellerId: data.id_seller
        }, process.env.JWT_SECRET, { expiresIn: '5m' })

        return res.status(200).json({ msg: "berhasil verifikasi kode", token })
    } catch (error) {
        console.log(error)
        res.status(401).json({ msg: error })
    }
}

const changePassword = async (req, res) => {
    try {
        let { password, confirm_password } = req.body

        if (password != confirm_password) return res.status(401).json({ msg: "Confirm password tidak sesuai" })

        if (!req.user.adminId && !req.user.sellerId) return res.status(401).json({ msg: "Tidak bisa merubah password" })

        if (req.user.adminId) {
            await Admin.update(
                { password },
                {
                    where: { id_admin: req.user.adminId }
                }
            )
            return res.status(200).json({ msg: "Berhasil mengubah password" })
        }

        if (req.user.sellerId) {
            await Seller.update(
                { password },
                {
                    where: { id_seller: req.user.sellerId }
                }
            )
            return res.status(200).json({ msg: "Berhasil mengubah password" })
        }

    } catch (error) {
        console.log(error)
        res.status(401).json({ msg: error })
    }
}

module.exports = { register, registerAdmin, login, loginAdmin, forgotPassword, verifyCode, changePassword }
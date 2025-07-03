import React, { useState, useEffect } from "react";
import "../styles/pesan.css";
import "../index.css";
import axios from "axios";
import { useNavigate } from "react-router";

export default function Notifikasi() {
    const navigate = useNavigate();
    const API_URL = import.meta.env.VITE_API_URL
    const [formData, setFormData] = useState({
        title: "",
        content: "",
        role: "buyer"
    });

    const [submitted, setSubmitted] = useState(false);
    const [errMsg, setErrMsg] = useState("")
    const [succMsg, setSuccMsg] = useState("")

    useEffect(() => {
        if (localStorage.getItem('token') == null) {
            navigate('/login-admin')
        }
      }, []);

    const handleChange = (e) => {
        console.log(e.target.name)
        setFormData((prev) => ({
            ...prev,
            [e.target.name]: e.target.value,
        }));
    };

    const handleLogout = () => {
        try {
            localStorage.removeItem('token')
            navigate('/login-admin')
        } catch (error) {
            console.log(error)
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        if (!formData.title || !formData.content) {
            setErrMsg("Semua kolom wajib diisi.");
            setSuccMsg(null)
            setSubmitted(true);
            return;
        }
        try {
            const response = await axios.post(`${API_URL}/auth/sendMessage`, formData);
            setSuccMsg("Berhasil mengirimkan notifikasi")
            setErrMsg(null)
            setSubmitted(true);
        } catch (err) {
            if (err.response) {
                setSubmitted(true);
                setSuccMsg(null)
                setErrMsg(err.response.data.msg || "Pengiriman gagal");
            } else {
                setSubmitted(true)
                setSuccMsg(null)
                setErrMsg(err.response.data.msg || "Pengiriman gagal");
            }
        }
        console.log("Data dikirim:", formData);
    };

    return (
        <div className="containers">
            <div className="form-box">
                <h1 className="form-title">Notifikasi</h1>
                {submitted && errMsg && (
                    <div className="error-message">{errMsg}</div>
                )}
                {submitted && succMsg && (
                    <div className="success-message">{succMsg}</div>
                )}
                <form onSubmit={handleSubmit}>
                    <div className="form-group">
                        <label htmlFor="role">Tujuan</label>
                        <select name="role" id="role" onChange={handleChange}>
                            <option value="buyer">pembeli</option>
                            <option value="seller">penjual</option>
                            <option value="admin">admin</option>
                        </select>
                    </div>
                    <div className="form-group">
                        <label htmlFor="title">Title</label>
                        <input
                            type="text"
                            name="title"
                            id="title"
                            value={formData.title}
                            onChange={handleChange}
                            placeholder="Masukkan title"
                        />
                    </div>
                    <div className="form-group">
                        <label htmlFor="content">content</label>
                        <input
                            type="content"
                            name="content"
                            id="content"
                            value={formData.content}
                            onChange={handleChange}
                            placeholder="Masukkan content"
                        />
                    </div>
                    <button type="submit" className="submit-button">
                        Kirim
                    </button>
                </form>
                    <a className="logout-button" onClick={handleLogout}>
                        Logout
                    </a>
            </div>
        </div>
    );
}

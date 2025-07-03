import React, { useState } from "react";
import "../styles/pesan.css";
import "../index.css";
import axios from "axios";
import { useNavigate } from "react-router";

export default function Pesan() {
    const navigate = useNavigate();
    const API_URL = import.meta.env.VITE_API_URL
    const [formData, setFormData] = useState({
        username: "",
        password: "",
    });

    const [submitted, setSubmitted] = useState(false);
    const [msg, setMsg] = useState("")

    const handleChange = (e) => {
        setFormData((prev) => ({
            ...prev,
            [e.target.name]: e.target.value,
        }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        if (!formData.username || !formData.password) {
            setMsg("Semua kolom wajib diisi.");
            setSubmitted(true);
            return;
        }
        try {
            const response = await axios.post(`${API_URL}/auth/login-admin`, formData);
            const data = response.data;

            console.log("Login berhasil:", data);

            if (data.token) {
                localStorage.setItem("token", data.token);
                navigate("/notifikasi");
            }

        } catch (err) {
            if (err.response) {
                setSubmitted(true);
                setMsg(err.response.data.msg || "Login gagal");
            } else {
                setSubmitted(true)
                setMsg(err.response.data.msg || "Login gagal");
            }
        }
        console.log("Data dikirim:", formData);
    };

    return (
        <div className="containers">
            <div className="form-box">
                <h1 className="form-title">Login Admin</h1>
                {submitted && (
                    <div className="error-message">{msg}</div>
                )}
                <form onSubmit={handleSubmit}>
                    <div className="form-group">
                        <label htmlFor="username">Username / No Handphone</label>
                        <input
                            type="text"
                            name="username"
                            id="username"
                            value={formData.username}
                            onChange={handleChange}
                            placeholder="Masukkan username / no hp"
                        />
                    </div>
                    <div className="form-group">
                        <label htmlFor="password">Password</label>
                        <input
                            type="password"
                            name="password"
                            id="password"
                            value={formData.password}
                            onChange={handleChange}
                            placeholder="Masukkan password"
                        />
                    </div>
                    <button type="submit" className="submit-button">
                        Kirim
                    </button>
                </form>
            </div>
        </div>
    );
}

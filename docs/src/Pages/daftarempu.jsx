import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import { motion } from "framer-motion";
import "../index.css";
import "../styles/toko.css";
import "../styles/detail.css";
import "../styles/daftarempu.css"

import logoImage from "../assets/Images/logo-keris.png";
import empuImage from "../assets/Images/empu1.jpg"
import axios from "axios";


export default function Tokokeris() {
    const API_URL = import.meta.env.VITE_API_URL
    const [search, setSearch] = useState('')

    const [allSeller, setAllSeller] = useState([])
    const [sellerImage, setSellerImage] = useState([])

    useEffect(() => {
        const fetchAllSeller = async () => {
            const response = await axios.get(`${API_URL}/users/all-seller?search=${search}`)
            setAllSeller(response.data.data)

            const blobUrls = await Promise.all(
                response.data.data.map(async seller => {
                    if (!seller.seller_photo) return ""
                    const response = await axios.get(`${API_URL}/${seller.seller_photo}`, {
                        headers: {
                            'ngrok-skip-browser-warning': 'true'
                        },
                        responseType: 'blob'
                    })
                    return URL.createObjectURL(response.data)
                })
            )
            setSellerImage(blobUrls)
        }

        fetchAllSeller()
        document.title = "Toko Keris Sumenep";

    }, [search]);

    const submit = (s) => {
        setTimeout(() => {
          setSearch(s)
        }, 1000);
      }

    const dataEmpu = allSeller?.map((seller, index) => {
        return {
            img: sellerImage[index],
            nama: seller.seller_name,
            kontak: seller.seller_phone,
            sellerId: seller.id_seller
        }
    })

    return (
        <div className="min-h-screen w-full flex flex-col">
            {/* Header */}
            <motion.header
                className="header"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ duration: 0.6 }}
            >
                <div className="header-top">
                    <div className="logo-container">
                        <img src={logoImage} alt="Logo" className="logo-img" />
                        <span className="logo">KerisSumenep</span>
                    </div>
                    <div className="search-container">
                        <input onChange={(event) => submit(event.target.value)}
                            type="text"
                            placeholder="Cari keris..."
                            className="search-input"
                        />
                    </div>
                </div>

                <nav className="nav-container">
                    <ul className="nav-links">
                        <li><a href="#">Profil</a></li>
                        <li><a href="#">Berita</a></li>
                        <li><a href="#">Arsip</a></li>
                        <li><a href="/toko-keris">Toko</a></li>
                        <li><a href="#">E-tour Guide</a></li>
                    </ul>
                </nav>
            </motion.header>

            {/* Divider */}
            <div className="divider"></div>

            {/* Tombol Kembali */}
            <motion.div
                className="kembali-wrapper"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ duration: 0.5 }}
            >
                <Link to="/toko-keris">
                    <button className="btn-kembali">Kembali</button>
                </Link>
            </motion.div>

            <section className="banner-section">
                <div className="banner-container">
                    <div className="banner-text">
                        <h1>DAFTAR EMPU</h1>
                        <div className="dividerss"></div>
                    </div>
                </div>
            </section>

            <section className="daftar-empu-section">
                <div className="daftar-grid">
                    {dataEmpu.map((empu, index) => (
                        <div className="daftar-kartu-empu" key={index}>
                            <img src={empu.img} alt={empu.nama} className="foto-empu" />
                            <div className="daftar-info-empu">
                                <h3 className="daftar-nama-empu">{empu.nama}</h3>
                                <p className="daftar-kontak-empu">{empu.kontak}</p>
                                <Link to={`/produk-empu/${empu.sellerId}`} className="link-produk">Lihat Produk</Link>
                            </div>
                        </div>
                    ))}
                </div>
            </section>

        </div>
    );
}

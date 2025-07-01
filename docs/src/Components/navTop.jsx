import React from "react";
import { Link } from "react-router";
import { motion } from "framer-motion";
import logoImage from "../assets/Images/logo-keris.png";
import { useLocation } from "react-router-dom"; // Ganti dari "react-router" ke "react-router-dom"

const API_URL = import.meta.env.VITE_API_URL
const urlKeris = "http://localhost:5173/"

const NavTop = ({ submit }) => {
  const location = useLocation();

  const handleKoleksiClick = (e) => {
    e.preventDefault();
    const isBeranda = location.pathname === "/" || location.pathname === "/index.html"; // fallback kalau di dev mode

    if (isBeranda) {
      const el = document.getElementById("produk-terbaru");
      if (el) {
        el.scrollIntoView({ behavior: "smooth" });
      }
    } else {
      // redirect ke halaman beranda dengan query
      window.location.href = `${urlKeris}?scrollTo=produk-terbaru`;
    }
  };

  return (
    <div>
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
            <input
              onChange={(event) => submit(event.target.value)}
              type="text"
              placeholder="Cari keris..."
              className="search-input"
            />
          </div>
        </div>
        <nav className="nav-container">
          <ul className="nav-links">
            <li><a href={urlKeris}>Beranda</a></li>
            <li><a href={`${urlKeris}daftar-empu`}>Empu</a></li>
            <li><a href="#" onClick={handleKoleksiClick}>Koleksi</a></li>
          </ul>
        </nav>
      </motion.header>
    </div>
  );
};

export default NavTop;
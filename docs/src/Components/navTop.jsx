import React from "react";
import { Link } from "react-router";
import { motion } from "framer-motion";
import logoImage from "../assets/Images/logo-keris.png";
import { useLocation } from "react-router-dom"; // Ganti dari "react-router" ke "react-router-dom"

const API_URL = import.meta.env.VITE_API_URL
const urlKeris = "https://toko.kerissumenep.com/"

const NavTop = ({ submit }) => {
  const location = useLocation();

  const handleKoleksiClick = (e) => {
    e.preventDefault();
    const isBeranda = location.pathname === "/";

    if (isBeranda) {
      const el = document.getElementById("produk-terbaru");
      if (el) {
        el.scrollIntoView({ behavior: "smooth" });
      }
    } else {
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
        <div className="info-download flex flex-wrap items-center justify-between gap-2 text-sm sm:text-base px-4 py-2">
          <p className="whitespace-nowrap">
            Download Aplikasi Toko Keris untuk Android
          </p>
          <div className="button-download flex flex-wrap gap-2">
          <a href={`${API_URL}/apk/toko-keris.apk`} download>
            <button className="bg-green-900 text-white font-bold px-2 sm:px-3 py-2 text-xs sm:text-sm md:text-base rounded-3xl hover:bg-green-600 whitespace-nowrap">
              Pembeli
            </button>
          </a>
          <a href={`${API_URL}/apk/toko-keris-penjual.apk`} download>
            <button className="bg-green-900 text-white font-bold px-2 sm:px-3 py-2 text-xs sm:text-sm md:text-base rounded-3xl hover:bg-green-600 whitespace-nowrap">
              Penjual
            </button>
          </a>
          <a href={`${API_URL}/apk/toko-keris-admin.apk`} download>
            <button className="bg-green-900 text-white font-bold px-2 sm:px-3 py-2 text-xs sm:text-sm md:text-base rounded-3xl hover:bg-green-600 whitespace-nowrap">
              Admin
            </button>
          </a>
        </div>

        </div>
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
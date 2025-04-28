import React, { useEffect, useRef } from "react";
import { Link } from "react-router-dom";
import { motion } from "framer-motion";
import "../index.css";
import "../styles/toko.css";

import logoImage from "../assets/Images/logo-keris.png";
import HeroTerlaris from "../Components/heroterlaris";
import ScTerlaris from "../Components/prd-terlaris";

export default function ProdukTerlaris() {
  useEffect(() => {
    document.title = "Toko Keris Sumenep";
  }, []);

  const scrollRef = useRef(null);

  const scroll = (direction) => {
    if (scrollRef.current) {
      const amount = 220;
      scrollRef.current.scrollBy({
        left: direction === "left" ? -amount : amount,
        behavior: "smooth",
      });
    }
  };

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
            <input
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
      <div className="divider"></div>
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
      {/* Hero */}
        <HeroTerlaris />

      {/* Produk Terlaris */}
      <ScTerlaris/>

    </div>
  );
}

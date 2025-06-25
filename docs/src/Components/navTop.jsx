import React from "react";
import { Link } from "react-router";
import { motion } from "framer-motion";
import logoImage from "../assets/Images/logo-keris.png";

const NavTop = () => {
  const submit = (value) => {
    console.log("Searching:", value);
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
            <li><a href="#">Profil</a></li>
            <li><a href="#">Berita</a></li>
            <li><a href="#">Arsip</a></li>
            <li><a href="/">Toko</a></li>
            <li><a href="#">E-tour Guide</a></li>
          </ul>
        </nav>
      </motion.header>
    </div>
  );
};

export default NavTop;
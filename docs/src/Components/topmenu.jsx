import React, { useEffect, useState } from 'react'
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import axios from "axios";
import "../index.css";
import "../styles/toko.css";

const TopMenu = () => {
  return (
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
        <li><a href="#">Beranda</a></li>
        <li><a href="#">Berita</a></li>
        <li><a href="#">Arsip</a></li>
        <li><a href="/">Toko</a></li>
        <li><a href="#">E-tour Guide</a></li>
        </ul>
    </nav>
    </motion.header>
  )
}

export default TopMenu


    import React, { useState, useEffect } from "react";
    import { Link } from "react-router-dom";
    import { motion } from "framer-motion";
    import "../index.css";
    import "../styles/toko.css";
    import "../styles/detail.css";
    import "../styles/produkempu.css"

    import logoImage from "../assets/Images/logo-keris.png";
    import empuImage from "../assets/Images/empu1.jpg"
    import keris4 from "../assets/Images/keris4.jpg";
    import keris5 from "../assets/Images/keris5.jpeg";
    import keris6 from "../assets/Images/keris6.jpg";
    import keris7 from "../assets/Images/keris7.jpg";
    import keris8 from "../assets/Images/keris8.jpg";

    export default function Tokokeris() {
    useEffect(() => {
        document.title = "Toko Keris Sumenep";
    }, []);

    // komponen ProductItem
    const ProdukCard = ({ image, name, price }) => (
        <div className="kartu-produk">
            <div className="gambar-produk">
            <img src={image} alt={name} />
            </div>
            <span className="nama-produk">{name}</span>
            <div className="harga-dan-beli">
            <span className="harga-produk">{price}</span>
            <Link to="/detail-produk">
            <button className="tombol-beli">Beli</button>
            </Link>
            </div>
        </div>
    );
    
    const produkData = [
        { image: keris4, name: "Ratu Pameling", price: "Rp 4.000.000" },
        { image: keris5, name: "Lindu Aji", price: "Rp 4.000.000" },
        { image: keris6, name: "Panji Mataram", price: "Rp 4.000.000" },
        { image: keris7, name: "Surya Kencana", price: "Rp 4.000.000" },
        { image: keris8, name: "Kyai Carubuk", price: "Rp 4.000.000" },
      ];

      const DetailEmpuSection = ({ name, phone, image }) => {
        return (
          <section className="empu-detail-section">
            <div className="empu-detail-container">
              <div className="empu-detail-text">
                <h1>{name}</h1>
                <div className="dividerss"></div>
                <p>{phone}</p>
              </div>
              <div className="empu-detail-image">
                <img src={image} alt={name} />
              </div>
            </div>
          </section>
        );
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

        <DetailEmpuSection
                name="EMPU SEPUH"
                phone="085236829392"
                image={empuImage}
            />


              {/* Produk Terbaru */}

              <div className="judul-produk-empu">Keris Empu Sepuh</div>
              <motion.section className="produk-section">

              <motion.div className="produk-grid"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.2, duration: 0.6 }}
              >
                {produkData.map((produk, index) => (
                  <motion.div
                  className="produk-card"
                  key={index}
                  initial={{ opacity: 0, y: 50 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: index * 0.1, duration: 0.5 }}
                ><Link to="/detail-produk">
                  <ProdukCard
                    image={produk.image}
                    name={produk.name}
                    price={produk.price}
                  />
                  </Link>
                </motion.div>
                ))}
        
              </motion.div>
            </motion.section>




        </div>
    );
    }

import React, { useEffect, useRef } from "react";
import { Link } from "react-router-dom";
import { motion } from "framer-motion";
import { BsArrowLeftCircle, BsArrowRightCircle } from "react-icons/bs";
import "../index.css";
import "../styles/toko.css";

// Gambar
import heroImage from "../assets/Images/hero1.png";
import productHeroImage from "../assets/Images/hero3.png";
import logoImage from "../assets/Images/logo-keris.png";
import empu1 from "../assets/Images/empu1.jpg";
import empu2 from "../assets/Images/empu2.jpeg";
import empu3 from "../assets/Images/empu3.jpg";
import empu4 from "../assets/Images/empu4.jpeg";
import empu5 from "../assets/Images/empu5.jpg";
import empu6 from "../assets/Images/empu6.jpeg";
import empu7 from "../assets/Images/empu7.jpeg";
import empu8 from "../assets/Images/empu8.jpeg";
import empu9 from "../assets/Images/empu9.jpg";
import empu10 from "../assets/Images/empu10.jpg";
import keris1Image from "../assets/Images/keris1.jpg";
import keris2Image from "../assets/Images/keris2.jpg";
import keris3Image from "../assets/Images/keris3.jpeg";
import keris4 from "../assets/Images/keris4.jpg";
import keris5 from "../assets/Images/keris5.jpeg";
import keris6 from "../assets/Images/keris6.jpg";
import keris7 from "../assets/Images/keris7.jpg";
import keris8 from "../assets/Images/keris8.jpg";
import keris9 from "../assets/Images/keris9.jpg";
import keris10 from "../assets/Images/keris10.jpeg";
import keris11 from "../assets/Images/keris11.jpg";
import keris12 from "../assets/Images/keris12.jpg";
import keris13 from "../assets/Images/keris13.jpg";

// Komponen EmpuCard
const EmpuCard = ({ image, name, phone }) => (
  <div className="empu-card">
    <img src={image} alt={name} className="empu-photo" />
    <div className="empu-name">{name}</div>
    <div className="empu-phone">{phone}</div>
  </div>
);

// Komponen ProdukCard
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

// komponen ProductItem
const ProductItem = ({ image, name, price }) => (
  <div className="product-item">
    <img src={image} alt={`Keris ${name}`} />
    <div className="product-item-content">
      <span className="product-name">{name}</span>
      <span className="product-price">{price}</span>
      <Link to="/detail-produk">
      <button className="buy-button">Beli</button>
      </Link>
    </div>
  </div>
);

export default function Tokokeris() {
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

  const empuData = [
    { image: empu1, name: "Empu Sepuh 1", phone: "085236829300" },
    { image: empu2, name: "Empu Sepuh 2", phone: "085236829301" },
    { image: empu3, name: "Empu Sepuh 3", phone: "085236829302" },
    { image: empu4, name: "Empu Sepuh 4", phone: "085236829303" },
    { image: empu5, name: "Empu Sepuh 5", phone: "085236829304" },
    { image: empu6, name: "Empu Sepuh 6", phone: "085236829305" },
    { image: empu7, name: "Empu Sepuh 7", phone: "085236829306" },
    { image: empu8, name: "Empu Sepuh 8", phone: "085236829307" },
    { image: empu9, name: "Empu Sepuh 9", phone: "085236829308" },
    { image: empu10, name: "Empu Sepuh 10", phone: "085236829309" },
  ];  

  const produkData = [
    { image: keris4, name: "Ratu Pameling", price: "Rp 4.000.000" },
    { image: keris5, name: "Lindu Aji", price: "Rp 4.000.000" },
    { image: keris6, name: "Panji Mataram", price: "Rp 4.000.000" },
    { image: keris7, name: "Surya Kencana", price: "Rp 4.000.000" },
    { image: keris8, name: "Kyai Carubuk", price: "Rp 4.000.000" },
    { image: keris9, name: "Rakian Naga", price: "Rp 4.000.000" },
    { image: keris10, name: "Nagasasra Sabuk", price: "Rp 4.000.000" },
    { image: keris11, name: "Kalamisani Emas", price: "Rp 4.000.000" },
    { image: keris12, name: "Pamungkas Seta", price: "Rp 4.000.000" },
    { image: keris13, name: "Sanghyang Pamenang", price: "Rp 4.000.000" },
  ];

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

      {/* Hero */}
      <motion.section
        className="hero"
        style={{
          backgroundImage: `linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url(${heroImage})`
        }}
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ duration: 1 }}
      >
        <div className="hero-overlay" />
        <div className="hero-content">
          <motion.h1
            initial={{ opacity: 0, y: -20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
          >
            Keris Warisan Leluhur <br /> dari Sumenep
          </motion.h1>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.3, duration: 0.6 }}
          >
            <p>
              Temukan keindahan dan keunikan keris buatan tangan dari Desa Aengtongtong, Sumenep. Setiap keris memiliki filosofi mendalam dan keunikan tersendiri.
              <br /><strong>Eksklusif hanya di sini!</strong>
            </p>
          </motion.div>
        </div>
      </motion.section>

      {/* Empu */}
      <motion.section className="empu-section">
        <div className="empu-header">
          <p className="empu-title">Daftar Nama Empu</p>
          <div className="nav-arrows">
            <button className="arrow-btn" onClick={() => scroll("left")}>
              <BsArrowLeftCircle size={30} />
            </button>
            <button className="arrow-btn" onClick={() => scroll("right")}>
              <BsArrowRightCircle size={30} />
            </button>
          </div>
        </div>

        <motion.div className="empu-scroll-container" ref={scrollRef}
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ duration: 1 }}
        >
          <div className="empu-list">
            {empuData.map((empu, index) => (
              <motion.div
              key={index}
              initial={{ opacity: 0, y: 50 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1, duration: 0.5 }}
            >
              <EmpuCard
                image={empu.image}
                name={empu.name}
                phone={empu.phone}
              />
            </motion.div>
            ))}
          </div>
        </motion.div>
      </motion.section>

      {/* Produk Terlaris */}
      <motion.section className="product-container">
        <motion.div className="product-header"
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ duration: 0.6 }}
        >
          <h1 className="product-title">Produk Terlaris</h1>
          <button className="see-more-btn">Selengkapnya</button>
        </motion.div>

        <motion.div className="product-grid"
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 0.2, duration: 0.8 }}
        >
          <div className="product-hero"
            style={{ backgroundImage: `url(${productHeroImage})` }}
          >
            <div className="product-subtitle">
              <p>Simbol Keagungan dan Warisan Budaya</p>
            </div>
            <div>
              <p className="product-description">
                Miliki koleksi keris eksklusif dengan ukiran khas dan desain elegan.
              </p>
            </div>
          </div>

          <ProductItem image={keris1Image} name="Naga Nawasena" price="Rp 4.000.000" />
          <ProductItem image={keris3Image} name="Sabuk Inten" price="Rp 4.000.000" />
          <ProductItem image={keris2Image} name="Lintang Kemukus" price="Rp 4.000.000" />
        </motion.div>
      </motion.section>

      {/* Produk Terbaru */}
      <motion.section className="produk-section">
      <div className="judul-produk">Produk Terbaru</div>
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

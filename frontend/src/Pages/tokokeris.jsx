import React, { useEffect, useRef, useState } from "react";
import { Link } from "react-router-dom";
import { motion } from "framer-motion";
import { BsArrowLeftCircle, BsArrowRightCircle } from "react-icons/bs";
import axios from 'axios';
import "../index.css";
import "../styles/toko.css";

// Gambar
import heroImage from "../assets/Images/hero1.png";
import productHeroImage from "../assets/Images/hero3.png";
import logoImage from "../assets/Images/logo-keris.png";

// Komponen EmpuCard
const EmpuCard = ({ image, name, phone }) => (
  <div className="empu-card">
    <img src={image} alt={name} className="empu-photo" />
    <div className="empu-name">{name}</div>
    <div className="empu-phone">{phone}</div>
  </div>
);

// Komponen ProdukCard - produk terbaru
const ProdukCard = ({ image, name, price, id_product}) => (
  <div className="kartu-produk">
    <div className="gambar-produk">
      <img src={image} alt={name} />
    </div>
    <span className="nama-produk">{name}</span>
    <div className="harga-dan-beli">
      <span className="harga-produk">{price}</span>
      <Link to={`/detail-produk/${id_product}`}>
      <button className="tombol-beli">Beli</button>
      </Link>
    </div>
  </div>
);

const incrementClick = async (id_product) => {
  try {
    let {msg} = await axios.get(`http://localhost:3000/product/increment-count/${id_product}`)
    console.log(msg)
  } catch (error) {
    console.log(error)
  }
}

// komponen ProductItem - produk terlaris
const ProductItem = ({ image, name, price, id_product }) => (
  <div className="product-item">
    <img src={image} alt={`Keris ${name}`} />
    <div className="product-item-content">
      <span className="product-name">{name}</span>
      <span className="product-price">{price}</span>
      <Link to={`/detail-produk/${id_product}`} onClick={() => incrementClick(id_product)}>
      <button className="buy-button">Beli</button>
      </Link>
    </div>
  </div>
);

export default function Tokokeris() {
  const [products, setProducts] = useState([])
  const [sellers, setSellers] = useState([])
  const [popularProducts, setPopularProduct] = useState([])
  const scrollRef = useRef(null);
  useEffect(() => {
    document.title = "Toko Keris Sumenep";
    console.log("hai")
    const fetchProducts = async () => {
      try {
        const response = await axios.get('http://localhost:3000/product/active-product');
        setProducts(response.data.product);
      } catch (error) {
        console.error("Gagal mengambil data product:", error);
      }
    };
    const fetchSellers = async () => {
      try {
        const response = await axios.get('http://localhost:3000/users/all-seller');
        setSellers(response.data.data);
      } catch (error) {
        console.error("Gagal mengambil data seller:", error);
      }
    };
    const fetchPopularProducts = async () => {
      try {
        const response = await axios.get('http://localhost:3000/product/populer-product')
        console.log(response.data.product)
        setPopularProduct(response.data.product)
      } catch (error) {
        console.log(error)
      }
    }
    fetchPopularProducts();

    fetchProducts();
    fetchSellers();
  }, []);

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
            {sellers.map((empu, index) => (
              <motion.div
              key={index}
              initial={{ opacity: 0, y: 50 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1, duration: 0.5 }}
            >
              <EmpuCard
                image={`http://localhost:3000/${empu.seller_photo}`}
                name={empu.seller_name}
                phone={empu.seller_phone}
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
          <h1 className="product-title">Paling Banyak Dilihat</h1>
          <Link to={"/produk-terlaris"}>
            <button className="see-more-btn">Selengkapnya</button>
          </Link>
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
            
          {popularProducts.length >= 0 &&
            popularProducts.slice(0, 3).map(product => (
                <Link to={`/detail-produk/${product.id_product}`}>
                  <ProductItem image={`http://localhost:3000/${product?.ProductPicts[0]?.path}`} name={product?.product_name} price={product?.product_price} id_product={product?.id_product} />
                </Link>)
            )
          }

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
        {products.map((produk, index) => (
          <motion.div
          className="produk-card"
          key={index}
          initial={{ opacity: 0, y: 50 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: index * 0.1, duration: 0.5 }}
        ><Link to={`/detail-produk/${produk.id_product}`} onClick={() => incrementClick(produk.id_product)}>
          <ProdukCard
            id_product = {produk.id_product}
            image={produk.ProductPicts.length > 0 ? `http://localhost:3000/${produk.ProductPicts[0].path}` : `http://localhost:3000/${produk.ProductPicts.path}`}
            name={produk.product_name}
            price={produk.product_price}
          />
          </Link>
        </motion.div>
        ))}

      </motion.div>
    </motion.section>

    </div>
  );
}

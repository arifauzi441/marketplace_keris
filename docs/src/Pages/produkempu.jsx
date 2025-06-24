import React, { useState, useEffect } from "react";
import { Link, useParams } from "react-router-dom";
import { motion } from "framer-motion";
import axios from "axios";
import "../index.css";
import "../styles/toko.css";
import "../styles/detail.css";
import "../styles/produkempu.css"

import logoImage from "../assets/Images/logo-keris.png";
import defaultSellerPhoto from "../assets/Images/account.png"
import sketsaKeris from "../assets/Images/keris-sketsa.png"

export default function Tokokeris() {
  const API_URL = import.meta.env.VITE_API_URL
  const { id } = useParams()
  const [sellerProducts, setSellerProducts] = useState({})
  const [sellerImage, setSellerImage] = useState('')
  const [productImage, setProductImage] = useState([])
  useEffect(() => {
    const fetchSellerProduct = async () => {
      const response = await axios.get(`${API_URL}/product/seller/${id}`, {
        headers: {
          'ngrok-skip-browser-warning': 'true'
        }
      })
      setSellerProducts(response.data.product)

      if (response.data.product.seller_photo) {
        const blobUrlSeller = await axios.get(`${API_URL}/${response.data.product.seller_photo}`, {
          responseType: 'blob'
        })
        setSellerImage(URL.createObjectURL(blobUrlSeller.data))
      } else {
        setSellerImage("")
      }

      const blobUrls = await Promise.all(
        response.data?.product?.Products?.map(async (product) => {
          const response = await axios.get(`${API_URL}/${product?.ProductPicts?.[0]?.path}`, {
            responseType: 'blob'
          })
          return URL.createObjectURL(response.data)
        })
      )
      setProductImage(blobUrls)
    }
    document.title = "Toko Keris Sumenep";

    fetchSellerProduct()
  }, []);

  const formatRupiah = (amount) => {
    return new Intl.NumberFormat("id-ID", {
      style: "currency",
      currency: "IDR"
    }).format(amount)
  }

  // komponen ProductItem
  const ProdukCard = ({ image, name, price, id }) => {
    return (
      <div className="kartu-produk">
        <div className="gambar-produk">
          <img src={image ?? sketsaKeris} alt={name} />
        </div>
        <span className="nama-produk">{name}</span>
        <div className="harga-dan-beli">
          <span className="harga-produk">{formatRupiah(price)}</span>
          <Link to={`/detail-produk/${id}`}>
            <button className="tombol-beli">Beli</button>
          </Link>
        </div>
      </div>
    )
  };

  const produkData = sellerProducts?.Products?.map((product, index) => {
    return {
      image: productImage[index],
      name: product?.product_name,
      price: product?.product_price,
      productId: product?.id_product
    }
  }) || [];

  const DetailEmpuSection = ({ name, phone, image }) => {
    return (
      <section className="empu-detail-section">
        <div className="empu-detail-container">
          <div className="empu-detail-text">
            <h1>{name}</h1>
          </div>
          <div className="empu-detail-image">
            <img src={image == "" ? defaultSellerPhoto : image} alt={name} />
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
        name={sellerProducts.seller_name}
        phone={sellerProducts.seller_phone}
        image={sellerImage}
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
            ><Link to={`/detail-produk/${produk.productId}`}>
                <ProdukCard
                  image={produk.image}
                  name={produk.name}
                  price={produk.price}
                  id={produk.productId}
                />
              </Link>
            </motion.div>
          ))}

        </motion.div>
      </motion.section>




    </div>
  );
}

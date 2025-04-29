    import React, { useState, useEffect } from "react";
    import { Link, useParams } from "react-router-dom";
    import { motion } from "framer-motion";
    import axios from "axios";
    import "../index.css";
    import "../styles/toko.css";
    import "../styles/detail.css";

    import logoImage from "../assets/Images/logo-keris.png";
    import kerisImage1 from "../assets/Images/keris2.jpg";
    import kerisImage2 from "../assets/Images/keris3.jpeg";
    import kerisImage3 from "../assets/Images/keris4.jpg";
    import kerisImage4 from "../assets/Images/keris5.jpeg";

    export default function Tokokeris() {
    const API_URL = import.meta.env.VITE_API_URL

    const {id} = useParams()
    const [detailProduct, setDetailProduct] = useState({})
    const [image, setImage] = useState([])
    const [mainImage, setMainImage] = useState(``);
    
    useEffect(() => {
        const fetchDetailProducts = async () => {
            try {
                const response = await axios.get(`${API_URL}/product/${id}`, {
                    headers: {
                      'ngrok-skip-browser-warning': 'true'
                    }
                  })
                setDetailProduct(response.data.product)

                const blobUrls = await Promise.all(
                    response.data.product.ProductPicts.map(async (imageEndpoint) => {
                      const res = await axios.get(`${API_URL}/${imageEndpoint.path}`, {
                        headers: {
                          'ngrok-skip-browser-warning': 'true'
                        },
                        responseType: 'blob'
                      });
                      return URL.createObjectURL(res.data);
                    })
                );
                setImage(blobUrls)

                setMainImage(blobUrls[0])
            } catch (error) {
                console.log(error)
            }
        }

        fetchDetailProducts()
        document.title = "Toko Keris Sumenep";
    }, []);

    const formatRupiah = (amount) => {
        return new Intl.NumberFormat("id-ID",{
            style: "currency",
            currency: "IDR"
        }).format(amount)
    }
    console.log(detailProduct.ProductPicts)

    const GambarThumbnail = () => {
        const thumbnails = [kerisImage1, kerisImage2, kerisImage3, kerisImage4];
        if(detailProduct.ProductPicts && detailProduct.ProductPicts.length > 0){
            return (
            <div className="gambar-thumbnail">
                {image.map((thumb, idx) => {
                    return (
                        <img
                            key={idx}
                            src={thumb}
                            alt={`Thumbnail ${idx + 1}`}
                            onClick={() => setMainImage(thumb)}
                        />
                        )
                } )}
            </div>
            );
        }
    };

    const ProdukInfo = () => {
        return (
        <div className="deskripsi-produk">
            <span className="nama-produk-detail">{detailProduct.product_name}</span>
            <span className="harga-produk-detail">{formatRupiah(detailProduct.product_price)}</span>
            <div className="dividers"></div>
            <span className="teks-deskripsi">{detailProduct.product_description}</span>
            <div className="dividers"></div>
            <button className="btn-hubungi">Hubungi Sekarang</button>
        </div>
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

        {/* Konten Utama */}
        <motion.section
            className="detail-produk"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ duration: 0.6 }}
        >
            <div className="konten-utama">
            {/* Gambar Utama dan Thumbnail */}
            <div className="gambar-wrapper">
                <div className="gambar-utama">
                <img src={mainImage} alt="Keris Lintang Kemukus" />
                </div>
                <GambarThumbnail />
            </div>

            {/* Detail Produk */}
            <ProdukInfo />
            </div>

            {/* Format Pembelian */}
            <span className="judul-format">Format Pembelian</span>
            <div className="dividers"></div>
            <div className="format-pembelian">
            <span className="label-wa">WhatsApp</span>
            <p>Nama:</p>
            <p>Alamat:</p>
            <p>Nama Keris:</p>
            </div>
        </motion.section>
        </div>
    );
    }

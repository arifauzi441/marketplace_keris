import React, { useState, useEffect } from "react";
import { Link, useLocation, useNavigate, useParams } from "react-router-dom";
import { motion } from "framer-motion";
import axios from "axios";
import "../index.css";
import "../styles/toko.css"; 
import "../styles/detail.css";

import empu1 from "../assets/Images/empu1.jpg";
import logoImage from "../assets/Images/logo-keris.png";
import defaultSellerPhoto from "../assets/Images/account.png";
import sketsaKeris from "../assets/Images/keris-sketsa.png";
import NavTop from "../Components/navTop";

export default function Tokokeris() {
    const API_URL = import.meta.env.VITE_API_URL;

    const { id } = useParams();
    const [detailProduct, setDetailProduct] = useState({});
    const [sellerImage, setSellerImage] = useState(``);
    const [image, setImage] = useState([]);
    const [mainImage, setMainImage] = useState(``);
    const navigate = useNavigate();
    const location = useLocation();
    const from = location.state?.from || '/';
    const [isOverlayOpen, setIsOverlayOpen] = useState(false);

    useEffect(() => {
        const fetchDetailProducts = async () => {
            try {
                const response = await axios.get(`${API_URL}/product/${id}`, {
                    headers: {
                        'ngrok-skip-browser-warning': 'true'
                    }
                });
                setDetailProduct(response.data.product);

                if (response.data.product.seller.seller_photo == null) {
                    setSellerImage(defaultSellerPhoto);
                } else {
                    const res = await axios.get(`${API_URL}/${response.data.product.seller.seller_photo}`, {
                        responseType: 'blob'
                    });
                    setSellerImage(URL.createObjectURL(res.data));
                }

                let data = response?.data?.product?.productpicts || [];
                const blobUrls = await Promise.all(
                    data.map(async (imageEndpoint) => {
                        const res = await axios.get(`${API_URL}/${imageEndpoint?.path}`, {
                            responseType: 'blob'
                        });
                        return URL.createObjectURL(res.data);
                    })
                );
                setImage(blobUrls);
                setMainImage(blobUrls[0]);
            } catch (error) {
                console.log(error);
            }
        };

        fetchDetailProducts();
        document.title = "Toko Keris Sumenep";
    }, []);

    const formatRupiah = (amount) => {
        return new Intl.NumberFormat("id-ID", {
            style: "currency",
            currency: "IDR",
            minimumFractionDigits: 0,
            maximumFractionDigits: 0
        }).format(amount);
    };

    const GambarThumbnail = () => {
        if (detailProduct?.productpicts?.length > 0) {
            return (
                <div className="gambar-thumbnail">
                    {image.map((thumb, idx) => (
                        <img
                            key={idx}
                            src={thumb}
                            alt={`Thumbnail ${idx + 1}`}
                            onClick={() => setMainImage(thumb)}
                        />
                    ))}
                </div>
            );
        }
    };

    const redirectWa = (productName) => {
        const phoneNumber = detailProduct.seller?.seller_phone || "";
        const waNumber = (phoneNumber.charAt(0) === '0') ? '62' + phoneNumber.slice(1) : phoneNumber;
        const message = `Nama: \nNo hp: \nJenis: ${productName} \njumlah keris: \nAlamat Lengkap: `;
        const encodedMessage = encodeURIComponent(message);
        const url = `https://wa.me/${waNumber}?text=${encodedMessage}`;
        window.location.href = url;
    };

    const ProdukInfo = () => (
        <div className="deskripsi-produk">
            <span className="nama-produk-detail">{detailProduct?.product_name}</span>
            <span className="harga-produk-detail">{formatRupiah(detailProduct?.product_price)}</span>
            <div className="dividers"></div>
            <div className="profil-empu">
                <img src={sellerImage} alt="Empu Sepuh" />
                <span>{detailProduct.seller?.seller_name || ""}</span>
            </div>
            <div className="dividers"></div>
            <button className="btn-hubungi" onClick={() => redirectWa(detailProduct?.product_name)}>
                Hubungi Sekarang
            </button>
        </div>
    );

    const OverlayImageViewer = () => (
        <div className="overlay-viewer">
            <button className="close-button" onClick={() => setIsOverlayOpen(false)}>✕</button>
            <img src={mainImage ?? sketsaKeris} alt="Zoomed Keris" />
        </div>
    );

    return (
        <div>
            <NavTop />
            <div className="divider"></div>

            <motion.div
                className="kembali-wrapper"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ duration: 0.5 }}
            >
                <button className="btn-kembali" onClick={() => navigate(from)}>Kembali</button>
            </motion.div>

            <motion.section
                className="detail-produk"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ duration: 0.6 }}
            >
                <div className="konten-utama">
                    <div className="gambar-wrapper">
                        <div className="gambar-utama">
                            <img
                                src={mainImage ?? sketsaKeris}
                                alt="Keris Lintang Kemukus"
                                onClick={() => setIsOverlayOpen(true)}
                                style={{ cursor: "zoom-in" }}
                            />
                        </div>
                        <GambarThumbnail />
                    </div>
                    <ProdukInfo />
                </div>

                <span className="judul-format">Deskripsi</span>
                <div className="dividers"></div>
                <div className="format-pembelian">
                    <span className="teks-deskripsi">{detailProduct?.product_description}</span>
                </div>
            </motion.section>

            {isOverlayOpen && <OverlayImageViewer />}
        </div>
    );
}

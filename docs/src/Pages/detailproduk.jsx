import React, { useState, useEffect } from "react";
import { Link, useParams } from "react-router-dom";
import { motion } from "framer-motion";
import axios from "axios";
import Lightbox from "yet-another-react-lightbox";
import Zoom from "yet-another-react-lightbox/plugins/zoom"; // ✅ path benar
import "yet-another-react-lightbox/styles.css";
import "../index.css";
import "../styles/toko.css";
import "../styles/detail.css";

import empu1 from "../assets/Images/empu1.jpg";
import logoImage from "../assets/Images/logo-keris.png";
import defaultSellerPhoto from "../assets/Images/account.png"
import sketsaKeris from "../assets/Images/keris-sketsa.png"
import NavTop from "../Components/navTop";

export default function Tokokeris() {
    const API_URL = import.meta.env.VITE_API_URL

    const { id } = useParams()
    const [detailProduct, setDetailProduct] = useState({})
    const [sellerImage, setSellerImage] = useState(``)
    const [image, setImage] = useState([])
    const [mainImage, setMainImage] = useState(``);
    const [lightboxOpen, setLightboxOpen] = useState(false);
    const [lightboxIndex, setLightboxIndex] = useState(0);


    useEffect(() => {
        const fetchDetailProducts = async () => {
            try {
                const response = await axios.get(`${API_URL}/product/${id}`, {
                    headers: {
                        'ngrok-skip-browser-warning': 'true'
                    }
                })
                setDetailProduct(response.data.product)

                if (response.data.product.seller.seller_photo == null) {
                    setSellerImage(defaultSellerPhoto)
                } else {
                    const res = await axios.get(`${API_URL}/${response.data.product.seller.seller_photo}`, {
                        responseType: 'blob'
                    });
                    console.log(res.data)
                    setSellerImage(URL.createObjectURL(res.data))
                }

                let data = response?.data?.product?.productpicts || []
                const blobUrls = await Promise.all(
                    data?.map(async (imageEndpoint) => {
                        const res = await axios.get(`${API_URL}/${imageEndpoint?.path}`, {
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
        return new Intl.NumberFormat("id-ID", {
            style: "currency",
            currency: "IDR",
            minimumFractionDigits: 0,
            maximumFractionDigits: 0
        }).format(amount)
    }

    const GambarThumbnail = () => {
        if (detailProduct?.productpicts && detailProduct?.productpicts?.length > 0) {
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
                    })}
                </div>
            );
        }
    };

    const redirectWa = (productName) => {
        const phoneNumber = detailProduct.seller.seller_phone || ""
        const waNumber = (phoneNumber.charAt(0) == '0') ? '62' + phoneNumber.substring(1) : phoneNumber
        const message = `Nama: \nNo hp: \nJenis: ${productName} \njumlah keris: \nAlamat Lengkap: `
        const encodedMessage = encodeURIComponent(message)
        const url = `https://wa.me/${waNumber}?text=${encodedMessage}`

        window.location.href = url
    }

    const ProdukInfo = () => {
        return (
            <div className="deskripsi-produk">
                <span className="nama-produk-detail">{detailProduct?.product_name}</span>
                <span className="harga-produk-detail">{formatRupiah(detailProduct?.product_price)}</span>
                <div className="dividers"></div>
                <div className="profil-empu">
                    <img src={sellerImage} alt="Empu Sepuh" />
                    <span>{detailProduct.seller?.seller_name || ""}</span>
                </div>
                <div className="dividers"></div>
                <button className="btn-hubungi" onClick={() => redirectWa(detailProduct?.product_name)}>Hubungi Sekarang</button>
            </div>
        );
    };

    return (
        <div className="min-h-screen w-full flex flex-col">
            {/* Header */}
            <NavTop />

            {/* Divider */}
            <div className="divider"></div>

            {/* Tombol Kembali */}
            <motion.div
                className="kembali-wrapper"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ duration: 0.5 }}
            >
                <Link to="/">
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
                            <img
                                src={mainImage ?? sketsaKeris}
                                alt="Keris Lintang Kemukus"
                                onClick={() => {
                                setLightboxIndex(image.indexOf(mainImage));
                                setLightboxOpen(true);
                                }}
                                style={{ cursor: "zoom-in" }}
                            />
                        </div>
                        <GambarThumbnail />
                    </div>

                    {/* Detail Produk */}
                    <ProdukInfo />
                </div>

                <span className="judul-format">Deskripsi</span>
                <div className="dividers"></div>
                <div className="format-pembelian">
                    <span className="teks-deskripsi">{detailProduct?.product_description}</span>
                </div>

            </motion.section>

            {lightboxOpen && (
            <Lightbox
                open={lightboxOpen}
                close={() => setLightboxOpen(false)}
                slides={image.map((img) => ({ src: img }))}
                index={lightboxIndex}
                plugins={[Zoom]}
            />
            )}
        </div>
    );
}

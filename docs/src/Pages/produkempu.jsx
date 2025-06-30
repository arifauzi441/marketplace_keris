import React, { useState, useEffect } from "react";
import { Link, useParams } from "react-router-dom";
import { motion } from "framer-motion";
import axios from "axios";
import "../index.css";
import "../styles/toko.css";
import "../styles/detail.css";
import "../styles/produkempu.css"

// Component
import ProductCard from "../Components/productCard"

import logoImage from "../assets/Images/logo-keris.png";
import defaultSellerPhoto from "../assets/Images/account.png"
import sketsaKeris from "../assets/Images/keris-sketsa.png"
import NavTop from "../Components/navTop";

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
        try {
          const blobUrlSeller = await axios.get(`${API_URL}/${response.data.product.seller_photo}`, {
            responseType: 'blob'
          })
          setSellerImage(URL.createObjectURL(blobUrlSeller.data))
        } catch (error) {
          setSellerImage("")
        }
      } else {
        setSellerImage("")
      }
      const blobUrls = await Promise.all(
        response.data?.product?.products?.map(async (product) => {
          if (product?.productpicts?.[0]?.path) {
            try {
              const response = await axios.get(`${API_URL}/${product?.productpicts?.[0]?.path}`, {
                responseType: 'blob'
              })
              return URL.createObjectURL(response.data)
            } catch (error) {
              console.log("gagal mengambil gambar:" + error)
              setProductImage("")
              return ""
            }
          } else {
            setProductImage("")
            return ""
          }
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
      currency: "IDR",
      minimumFractionDigits: 0,
      maximumFractionDigits: 0
    }).format(amount)
  }

  const produkData = sellerProducts?.products?.map((product, index) => {
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

      <DetailEmpuSection
        name={sellerProducts.seller_name}
        phone={sellerProducts.seller_phone}
        image={sellerImage}
      />


      {/* Produk Terbaru */}

      <motion.section className="produk-section">
        <div className="judul-produk-empu">Keris Empu Sepuh</div>

        <motion.div className="produk-grid"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.2, duration: 0.6 }}
        >
          {produkData?.map((produk, index) => (
            <motion.div
              className="produk-card"
              key={index}
              initial={{ opacity: 0, y: 50 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1, duration: 0.5 }}
            ><Link to={`/detail-produk/${produk.productId}`}>
                <ProductCard
                  image={produk.image}
                  name={produk.name}
                  price={formatRupiah(produk.price)}
                  id_product={produk.productId}
                />
              </Link>
            </motion.div>
          ))}

        </motion.div>
      </motion.section>

    </div>
  );
}

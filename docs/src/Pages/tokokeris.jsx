import React, { useEffect, useRef, useState } from "react";
import { Link } from "react-router-dom";
import { motion } from "framer-motion";
import axios from 'axios';
import "../index.css";
import "../styles/toko.css";

// Component
import ProductCard from "../Components/productCard"
import EmpuCard from "../Components/empuCard"
import NavTop from "../Components/navTop"

// Gambar
import heroImage from "../assets/Images/hero1.png";
import productHeroImage from "../assets/Images/hero3.png";
import logoImage from "../assets/Images/logo-keris.png";
import defaultSellerPhoto from "../assets/Images/account.png"
import sketsaKeris from "../assets/Images/keris-sketsa.png"

const API_URL = import.meta.env.VITE_API_URL
// // Komponen EmpuCard
// const EmpuCard = ({ image, name, phone, id_seller }) => {
//   return (
//     <Link to={`/produk-empu/${id_seller}`}>
//       <div className="empu-card">
//         <img src={image} alt={name} className="empu-photo" />
//         <div className="empu-name">{name}</div>
//       </div>
//     </Link>
//   )
// };

const incrementClick = async (id_product) => {
  try {
    let { msg } = await axios.get(`${API_URL}/product/increment-count/${id_product}`, {
      headers:
        { 'ngrok-skip-browser-warning': 'true' }
    })
  } catch (error) {
    console.log(error)
  }
}

// komponen ProductItem - produk terlaris
const ProductItem = ({ image, name, price, id_product }) => {
  return (
    <div className="product-item">
      <div className="product-image-container">
        <img src={image == " " ? sketsaKeris : image} alt={`Keris ${name}`} />
      </div>
      <div className="product-item-content">
        <span className="product-name">{name}</span>
        <span className="product-price">{price}</span>
        <Link to={`/detail-produk/${id_product}`} onClick={() => incrementClick(id_product)}>
          <button className="buy-button">Beli</button>
        </Link>
      </div>
    </div>
  )
};

export default function Tokokeris() {
  const [search, setSearch] = useState('')

  const [products, setProducts] = useState([])
  const [imageProduct, setImageProduct] = useState([])

  const [sellers, setSellers] = useState([])
  const [imageSellers, setImageSellers] = useState([])

  const [popularProducts, setPopularProduct] = useState([])
  const [imagePopularProduct, setImagePopularProduct] = useState([])
  const scrollRef = useRef(null);


  useEffect(() => {
    document.title = "Toko Keris Sumenep";
    const fetchProducts = async () => {
      try {
        const response = await axios.get(`${API_URL}/product/active-product?search=${search}`, {
          headers: {
            'ngrok-skip-browser-warning': 'true'
          }
        });

        const productData = response?.data?.product || [];
        // Generate image URLs
        const blobUrls = await Promise.all(
          productData.map(async (item) => {
            // Jika tidak ada path produk, return string kosong
            const path = item?.productpicts?.[0]?.path;
            if (path) {
              try {
                const res = await axios.get(`${API_URL}/${path}`, {
                  responseType: 'blob'
                });
                return URL.createObjectURL(res.data);
              } catch (err) {
                console.error("Gagal mengambil gambar:", err);
                return ""; // fallback jika gagal ambil gambar
              }
            }
            return ""; // fallback jika tidak ada path
          })
        );

        setImageProduct(blobUrls);
        setProducts(productData);

      } catch (error) {
        console.error("Gagal mengambil data product:", error);
      }
    };

    const fetchSellers = async () => {
      try {
        const response = await axios.get(`${API_URL}/users/all-seller?search=${search}`, {
          headers: {
            'ngrok-skip-browser-warning': 'true'
          }
        });
        const blobUrls = await Promise.all(
          response.data.data.map(async (imageEndpoint) => {
            if (imageEndpoint.seller_photo == null) {
              return " "
            }
            const res = await axios.get(`${API_URL}/${imageEndpoint.seller_photo}`, {

              responseType: 'blob'
            });
            return URL.createObjectURL(res.data);
          })
        );
        setImageSellers(blobUrls)
        setSellers(response.data.data);
      } catch (error) {
        console.error("Gagal mengambil data seller:", error);
      }
    };
    const fetchPopularProducts = async () => {
      try {
        const response = await axios.get(`${API_URL}/product/populer-product?search=${search}`, {
          headers: {
            'ngrok-skip-browser-warning': 'true'
          }
        })
        const productData = response?.data?.product || [];
        const blobUrls = await Promise.all(
          productData.map(async (item) => {
            const path = item?.productpicts?.[0]?.path;
            if (path) {
              try {
                const res = await axios.get(`${API_URL}/${path}`, {
                  responseType: 'blob'
                });
                return URL.createObjectURL(res.data);
              } catch (err) {
                console.error("Gagal mengambil gambar:", err);
                return ""; 
              }
            }
            return ""; 
          })
        );
        setImagePopularProduct(blobUrls)
        setPopularProduct(response.data.product)
      } catch (error) {
        console.log(error)
      }
    }
    fetchPopularProducts();

    fetchProducts();
    fetchSellers();
  }, [search]);

  const submit = (s) => {
    setTimeout(() => {
      setSearch(s)
    }, 1000);
  }

  const formatRupiah = (amount) => {
    return new Intl.NumberFormat("id-ID", {
      style: "currency",
      currency: "IDR",
      minimumFractionDigits: 0,
      maximumFractionDigits: 0
    }).format(amount)
  }

  return (
    <div className="min-h-screen w-full flex flex-col">
      {/* Header */}
      <NavTop />

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

            <Link to={"/daftar-empu"}>
              <button className="see-more-btn">Selengkapnya</button>
            </Link>

          </div>
        </div>

        <motion.div className="empu-scroll-container" ref={scrollRef}
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 1 }}
        >
          <div className="empu-list">
            {sellers && sellers.length > 0 && sellers.map((empu, index) => (
              <motion.div
                key={index}
                initial={{ opacity: 0, y: 50 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.1, duration: 0.5 }}
              >
                <EmpuCard
                  width={200}
                  image={(imageSellers[index] == " ") ? defaultSellerPhoto : imageSellers[index]}
                  name={empu.seller_name}
                  phone={empu.seller_phone}
                  id_seller={empu.id_seller}
                />
              </motion.div>
            ))}
          </div>
        </motion.div>
      </motion.section>

      {/* Produk Terlaris */}

      <motion.div className="product-header"
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ duration: 0.6 }}
      >
        <h1 className="product-title">Paling Banyak Dilihat</h1>
        {/* <Link to={"/produk-terlaris"}>
            <button className="see-more-btn">Selengkapnya</button>
          </Link> */}
      </motion.div>

      <motion.section className="product-container">
        <div className="product-hero"
          style={{ backgroundImage: `url(${productHeroImage})` }}
        >
          <div className="product-subtitle">
            <p>Simbol Keagungan dan Warisan Budaya</p>
          </div>
          <div>
            <p className="product-description">
              Miliki koleksi keris eksklusif dengan ukiran khas dan desain elegan.
              Setiap bilah mencerminkan keindahan seni tradisional yang penuh makna.
            </p>
          </div>
        </div>

        <motion.div className="product-grid"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.2, duration: 0.8 }}
        >
          {popularProducts && popularProducts.length >= 0 &&
            popularProducts.slice(0, 3).map((product, index) => (
              <Link to={`/detail-produk/${product.id_product}`}>
                <ProductCard image={imagePopularProduct[index]} name={product?.product_name} price={formatRupiah(product?.product_price)} id_product={product?.id_product} />
              </Link>)
            )
          }
        </motion.div>
      </motion.section>

      {/* Produk Terbaru */}
      <motion.section className="produk-section">
        <div className="judul-produk" id="produk-terbaru">Produk Terbaru</div>

        <motion.div className="produk-grid"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.2, duration: 0.6 }}
        >
          {products && products.length > 0 && products.map((produk, index) => (
            <motion.div
              className="produk-card"
              key={index}
              initial={{ opacity: 0, y: 50 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1, duration: 0.5 }}
            ><Link to={`/detail-produk/${produk.id_product}`} onClick={() => incrementClick(produk.id_product)}>
                <ProductCard
                  id_product={produk.id_product}
                  image={produk.product && produk.product.length > 0 ? imageProduct[index] : imageProduct[index]}
                  name={produk.product_name}
                  price={formatRupiah(produk.product_price)}
                />
              </Link>
            </motion.div>
          ))}

        </motion.div>
      </motion.section>

    </div>
  );
}

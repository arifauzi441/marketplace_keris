import React, { useEffect, useState } from 'react'
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import axios from "axios";
import "./style/terlaris.css"

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

const ProdukCard = ({ image, name, price }) => (
    <div className="kartu-produk-terlaris">
      <div className="gambar-produk-terlaris">
        <img src={image} alt={name} />
      </div>
      <span className="nama-produk-terlaris">{name}</span>
      <div className="harga-dan-beli-terlaris">
        <span className="harga-produk-terlaris">{price}</span>
        <button className="tombol-beli-terlaris">Beli</button>
      </div>
    </div>
  );
  
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

const ScTerlaris = () => {
  const API_URL = import.meta.env.VITE_API_URL

  const [popularProduct, setPopularProduct] = useState([])
  const [imagePopularProduct, setImagePopularProduct] = useState([])

  useEffect(() => {
    const fetchPopularProduct = async () => {
      const response = await axios.get(`${API_URL}/product/populer-product`, {
        headers: {
          'ngrok-skip-browser-warning': 'true'
        }
      })
      console.log(response.data.product)
      const blobUrls = await Promise.all(
                response.data.product.map(async (imageEndpoint) => {
                  if (imageEndpoint.ProductPicts.length > 0) {
                    const res = await axios.get(`${API_URL}/${imageEndpoint.ProductPicts[0].path}`, {
                      headers: {
                        'ngrok-skip-browser-warning': 'true'
                      },
                      responseType: 'blob'
                    });
                    return URL.createObjectURL(res.data);
                  }else{
                    return " "
                  };
                })
              );
              setImagePopularProduct(blobUrls)
      setPopularProduct(response.data.product)
    }
    fetchPopularProduct()
  },[])
  return (
        <motion.section className="produk-section-terlaris">
            <div className="judul-produk-terlaris">Paling Banyak Dilihat</div>
            <motion.div
                className="produk-grid-terlaris"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 0.2, duration: 0.6 }}
            >
              
              {
                popularProduct.length > 0 && 
                popularProduct.map((produk, index) => {
                  if(produk.ProductPicts.length > 0 && produk.ProductPicts[0])
                    console.log(produk)
                      return (
                        <motion.div
                            className="produk-card-terlaris"
                            key={index}
                            initial={{ opacity: 0, y: 50 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: index * 0.1, duration: 0.5 }}
                        >
                          <Link to={`/detail-produk/${produk.id_product}`}>
                          <ProdukCard
                              image={imagePopularProduct[index]}
                              name={produk.product_name}
                              price={produk.product_price}
                          />
                          </Link>
                        </motion.div>
                )
                } )
              }
            </motion.div>
        </motion.section>
  )
}

export default ScTerlaris
import React, { useEffect, useState } from 'react'
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import axios from "axios";
import "./style/terlaris.css"

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

const ScTerlaris = ({search}) => {
  const API_URL = import.meta.env.VITE_API_URL

  const [popularProduct, setPopularProduct] = useState([])
  const [imagePopularProduct, setImagePopularProduct] = useState([])

  useEffect(() => {
    const fetchPopularProduct = async () => {
      const response = await axios.get(`${API_URL}/product/populer-product?search=${search}`, {
        headers: {
          'ngrok-skip-browser-warning': 'true'
        }
      })
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
  },[search])
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
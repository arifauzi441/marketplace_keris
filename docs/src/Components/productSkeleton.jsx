import React from 'react'
import sketsaKeris from "../assets/Images/keris-sketsa.png"
import { Link } from 'react-router';

const ProductSkeleton = ({ image, name, price, id_product, fromPage }) => (
  <div className="kartu-produk-skeleton">
    <div className="gambar-produk">
        <img src="" alt="" />
    </div>
    <span className="nama-produk">{name}</span>
    <div className="harga-dan-beli">
      <span className="harga-produk" style={{color: "red", fontWeight: "bold"}}>{price}</span>
    </div>
  </div>
);

export default ProductSkeleton
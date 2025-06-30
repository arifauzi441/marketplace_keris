import React from 'react'
import sketsaKeris from "../assets/Images/keris-sketsa.png"
import { Link } from 'react-router';

const ProductCard = ({ image, name, price, id_product }) => (
  <div className="kartu-produk">
    <div className="gambar-produk">
      <img src={image == "" ? sketsaKeris : image} alt={name} />
    </div>
    <span className="nama-produk">{name}</span>
    <div className="harga-dan-beli">
      <span className="harga-produk" style={{color: "red"}}>{price}</span>
      <Link to={`/detail-produk/${id_product}`}>
        <button className="tombol-beli">Beli</button>
      </Link>
    </div>
  </div>
);

export default ProductCard
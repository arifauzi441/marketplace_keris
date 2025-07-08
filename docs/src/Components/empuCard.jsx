import React from 'react'
import { Link } from 'react-router';

const EmpuCard = ({ image, name, width, phone, id_seller, fromPage }) => {
  return (
    <Link to={`/produk-empu/${id_seller}`} state={{from: fromPage}}>
      <div className="empu-card" style={{width}}>
        <img src={image} alt={name} className="empu-photo"/>
        <div className="empu-name">{name}</div>
      </div>
    </Link>
  )
};

export default EmpuCard
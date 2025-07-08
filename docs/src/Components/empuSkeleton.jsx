import React from 'react'
import { Link } from 'react-router';

const EmpuSkeleton = ({ image, name, width, phone, id_seller, fromPage }) => {
  return (
      <div className="empu-card-skeleton" style={{width}}>
        <img src="" alt={name} className="empu-photo"/>
        <div className="empu-name">{name}</div>
      </div>
  )
};

export default EmpuSkeleton
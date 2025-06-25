import React, { useEffect, useRef, useState } from "react";
import { Link } from "react-router-dom";
import { motion } from "framer-motion";
import "../index.css";
import "../styles/toko.css";

import logoImage from "../assets/Images/logo-keris.png";
import HeroTerlaris from "../Components/heroterlaris";
import ScTerlaris from "../Components/prd-terlaris";

export default function ProdukTerlaris() {
  const [search, setSearch] = useState('')
  useEffect(() => {
    document.title = "Toko Keris Sumenep";
  }, []);

  const scrollRef = useRef(null);

  const scroll = (direction) => {
    if (scrollRef.current) {
      const amount = 220;
      scrollRef.current.scrollBy({
        left: direction === "left" ? -amount : amount,
        behavior: "smooth",
      });
    }
  };

  const submit = (s) => {
    setTimeout(() => {
      setSearch(s)
    }, 1000);
  }

  return (
    <div className="min-h-screen w-full flex flex-col">
      {/* Header */}
      <NavTop />
      <div className="divider"></div>
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
      {/* Hero */}
        <HeroTerlaris />

      {/* Produk Terlaris */}
      <ScTerlaris search={search}/>

    </div>
  );
}

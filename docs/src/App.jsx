import React from "react";
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import "./index.css";
import Tokokeris from "./Pages/tokokeris";
import Detailproduk from "./Pages/detailproduk";
import ProdukTerlaris from "./Pages/produkterlaris";
import Produkempu from "./Pages/produkempu";
import Daftarempu from "./Pages/daftarempu"

function App() {

  return (
      <Routes>
        <Route path="/toko-keris" element={<Tokokeris />} />
        <Route path="/detail-produk" element={<Detailproduk />} />
        <Route path="/produk-terlaris" element={<ProdukTerlaris />} />
        <Route path="/produk-empu" element={<Produkempu />} />
        <Route path="/detail-produk/:id" element={<Detailproduk />} />
        <Route path="/daftar-empu" element={<Daftarempu />} />
      </Routes>
  )
}


export default App

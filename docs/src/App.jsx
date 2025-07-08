import React from "react";
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import "./index.css";
import Tokokeris from "./Pages/tokokeris";
import Detailproduk from "./Pages/detailproduk";
import Produkempu from "./Pages/produkempu";
import Daftarempu from "./Pages/daftarempu"
import Pesan from "./Pages/pesan";
import Notifikasi from "./Pages/notifikasi";

function App() {

  return (
      <Routes>
        <Route path="/" element={<Tokokeris />} />
        <Route path="/login-admin" element={<Pesan />} />
        <Route path="/adduser" element={<Notifikasi />} />
        <Route path="/notifikasi" element={<Notifikasi />} />
        <Route path="/detail-produk" element={<Detailproduk />} />
        <Route path="/produk-empu/:id" element={<Produkempu />} />
        <Route path="/detail-produk/:id" element={<Detailproduk />} />
        <Route path="/daftar-empu" element={<Daftarempu />} />
      </Routes>
  )
}


export default App

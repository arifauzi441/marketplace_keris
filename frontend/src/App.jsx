import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import "./index.css";
import Tokokeris from "./Pages/tokokeris";
import Detailproduk from "./Pages/detailproduk";
import ProdukTerlaris from "./Pages/produkterlaris";


function App() {

  return (
    <Router>
      <Routes>
        <Route path="/toko-keris" element={<Tokokeris />} />
        <Route path="/detail-produk" element={<Detailproduk />} />
        <Route path="/produk-terlaris" element={<ProdukTerlaris />} />
      </Routes>
    </Router>
  )
}


export default App

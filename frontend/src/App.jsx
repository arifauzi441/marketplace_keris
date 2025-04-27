import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import "./index.css";
import Tokokeris from "./Pages/tokokeris";
import Detailproduk from "./Pages/detailproduk";


function App() {

  return (
    <Router>
      <Routes>
        <Route path="/toko-keris" element={<Tokokeris />} />
        <Route path="/detail-produk/:id" element={<Detailproduk />} />
      </Routes>
    </Router>
  )
}


export default App

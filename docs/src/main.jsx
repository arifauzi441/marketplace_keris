import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { BrowserRouter, HashRouter } from 'react-router-dom';
import './index.css';
import App from './App.jsx';

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <HashRouter basename="/marketplace_keris">  {/* Membungkus App */}
      <App />
    </HashRouter>
  </StrictMode>
);


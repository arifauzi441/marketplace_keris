import React from 'react'
import heroImg from "../assets/Images/heropt.png";

const HeroTerlaris = () => {
  return (
    <div className='flex justify-center items-center p-[0 4rem]'>
        <div>
        </div>
        <div className="relative w-[85%] h-96 rounded-lg overflow-hidden">
        <img
            src={heroImg}
            alt="Keris"
            className="w-full h-full object-cover"
        />
        
        {/* Layer hitam tipis */}
        <div className="absolute inset-0 bg-black opacity-20 z-10"></div>

        {/* Teks di atas */}
        <div className="absolute z-20 text-white p-6 md:p-10 max-w-xl top-1/2 left-14 transform -translate-y-1/2">
            <h1 className="text-2xl md:text-4xl font-bold mb-4">
            Simbol Keagungan dan Warisan Budaya
            </h1>
            <p className="text-sm md:text-base">
            Miliki koleksi keris dengan ukiran khas dan desain elegan. Setiap bilah mencerminkan keindahan seni tradisional yang penuh makna
            </p>
        </div>
        </div>
    </div>
  )
}

export default HeroTerlaris
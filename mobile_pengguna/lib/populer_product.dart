import 'package:flutter/material.dart';

void main() {
  runApp(PopulerProduct());
}

class PopulerProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Produk Terlaris',
      home: ProdukTerlarisPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProdukTerlarisPage extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'name': 'Naga Nuwasena',
      'price': 'Rp 4.000.000',
      'image': 'https://storage.googleapis.com/a1aa/image/12313f63-feb6-4277-67e3-c0a629dd426b.jpg',
    },
    {
      'name': 'Lintang Kemukus',
      'price': 'Rp 4.000.000',
      'image': 'https://storage.googleapis.com/a1aa/image/efbb2428-d598-4586-4085-53292bfc9df1.jpg',
    },
    {
      'name': 'Ratu Pamingg',
      'price': 'Rp 4.000.000',
      'image': 'https://storage.googleapis.com/a1aa/image/a6e77653-a32b-4dc9-495c-7c36e2c79119.jpg',
    },
    {
      'name': 'Surya Kencana',
      'price': 'Rp 4.000.000',
      'image': 'https://storage.googleapis.com/a1aa/image/4ae2db98-cdd6-4077-d604-ec09e79b3537.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  Image.network(
                    'https://storage.googleapis.com/a1aa/image/d65f6ee8-bd82-4dcc-93aa-a36d909cf701.jpg',
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        hintText: 'Search',
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(999),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(999),
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Notifikasi button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                  child: Text(
                    'Notifikasi',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),

            // Label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Produk Terlaris',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),

            // Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://storage.googleapis.com/a1aa/image/165281e1-7e8b-4e93-e73b-3f88ec3a6729.jpg',
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Text(
                      'Simbol Kegigihan dan\nWarisan Budaya',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),

            // Produk grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: (index == 1 || index == 3)
                              ? Colors.green
                              : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            product['image']!,
                            height: 112,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 8),
                          Text(
                            product['name']!,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            product['price']!,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          SizedBox(height: 6),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: StadiumBorder(),
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            child: Text(
                              'Beli',
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'E-Tour',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Produk',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
     ),
);
}
}
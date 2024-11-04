import 'package:flutter/material.dart';
import 'product_form.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil argumen dari Navigator, pastikan tidak null
    final List<Map<String, dynamic>> cartItems = ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>? ?? [];

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.person_outline, color: Colors.black),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tombol Add Data di atas header tabel
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman ProductForm
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductForm(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Add Data +', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 16),
            
            // Header tabel
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    'Foto',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    'Nama Produk',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    'Harga',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    'Aksi',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Item List
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return _buildProductItem(
                    item['title'] ?? 'Nama Produk',
                    'Rp.${item['price']?.toString() ?? '0'},00',
                    item['imagePath'] ?? 'assets/default_image.png', // Pastikan ada gambar default
                    screenWidth,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(String name, String price, String imagePath, double screenWidth) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Gambar Produk
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Nama Produk
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          // Harga
          Text(
            price,
            style: const TextStyle(fontSize: 16, color: Colors.green),
          ),
          // Tombol Hapus
          CircleAvatar(
            backgroundColor: Colors.red.withOpacity(0.1),
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {}, // Tambahkan logika hapus di sini jika diperlukan
            ),
          ),
        ],
      ),
    );
  }
}

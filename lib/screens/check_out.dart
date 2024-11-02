import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil argumen dari Navigator
    final List<Map<String, dynamic>> cartItems = ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>;

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Tabs
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // Tab Add Data
                  Container(
                    width: screenWidth * 0.2,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                      child: Text(
                        'Add Data',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  // Tab Nama Produk
                  Container(
                    width: screenWidth * 0.25,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Center(
                      child: Text(
                        'Nama Produk',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  // Tab Harga
                  Container(
                    width: screenWidth * 0.25,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Center(
                      child: Text(
                        'Harga',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  // Tab Aksi
                  Container(
                    width: screenWidth * 0.2,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Center(
                      child: Text(
                        'Aksi',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
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
                    item['title'],
                    'Rp.${item['price'].toString()},00',
                    item['imagePath'],
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
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        children: [
          // Gambar Produk
          Container(
            width: 40,
            height: 40,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          // Nama Produk
          Container(
            width: screenWidth * 0.3,
            child: Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          // Harga
          Container(
            width: screenWidth * 0.3,
            child: Text(
              price,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          // Tombol Hapus
          Container(
            width: 40,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {}, // Anda dapat menambahkan logika penghapusan jika diperlukan
            ),
          ),
        ],
      ),
    );
  }
}

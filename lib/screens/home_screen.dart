import 'package:flutter/material.dart';
import 'cart.dart';
import 'check_out.dart';
import 'history.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'product_form.dart'; // Added import for the Product Form screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Menyimpan item cart secara global
  List<Map<String, dynamic>> cartItems = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomeContent(
        onAddToCart: _addToCart,
      ),
      CartScreen(
        cartItems: cartItems,
        onCheckout: _goToCheckout,
      ),
      CheckoutScreen(
        cartItems: cartItems,
      ),
      const HistoryScreen(), // Tambahkan tab History
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header dengan background putih
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black),
                  onPressed: () {},
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(child: pages[_selectedIndex]), // Menampilkan halaman yang dipilih
        ],
      ),
      bottomNavigationBar: (_selectedIndex == 0 || _selectedIndex == 3) 
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.payment),
                  label: 'Checkout',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'History',
                ),
              ],
              selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
            )
          : null,
    );
  }

  void _addToCart(Map<String, dynamic> item) {
    setState(() {
      cartItems.add(item);
    });
  }

  void _goToCheckout() {
    setState(() {
      _selectedIndex = 2;
    });
  }
}

class HomeContent extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart;

  const HomeContent({super.key, required this.onAddToCart});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String selectedCategory = "All";

  final List<Map<String, String>> foodItems = [
    {"title": "Burger King Medium", "price": "50000", "category": "Makanan", "image": "assets/burger.png"},
    {"title": "French Fries", "price": "20000", "category": "Makanan", "image": "assets/french_fries.png"},
    {"title": "Teh Botol Sosro", "price": "15000", "category": "Minuman", "image": "assets/teh_botol.png"},
    {"title": "Coca Cola", "price": "12000", "category": "Minuman", "image": "assets/coca_cola.png"},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredItems = foodItems.where((item) {
      if (selectedCategory == "All") return true;
      return item["category"] == selectedCategory;
    }).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Background putih untuk area kategori
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                categoryBox("All", "assets/burger.png"),
                categoryBox("Makanan", "assets/iconm.png"),
                categoryBox("Minuman", "assets/teh_botol.png"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'All Food',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Daftar makanan/minuman yang sudah difilter
          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filteredItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return foodCard(
                imagePath: filteredItems[index]["image"]!,
                title: filteredItems[index]["title"]!,
                price: filteredItems[index]["price"]!,
                onAddToCart: () {
                  widget.onAddToCart({
                    'title': filteredItems[index]["title"]!,
                    'price': double.parse(filteredItems[index]["price"]!),
                    'imagePath': filteredItems[index]["image"]!,
                    'quantity': 1,
                  });
                },
              );
            },
          ),
          const SizedBox(height: 100), // Space for bottom navigation
        ],
      ),
    );
  }

  Widget categoryBox(String category, String imagePath) {
    bool isSelected = selectedCategory == category;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange[100] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.transparent,
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath, 
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.food_bank,
                size: 40,
                color: isSelected ? Colors.orange : Colors.grey,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget foodCard({
    required String imagePath,
    required String title,
    required String price,
    required VoidCallback onAddToCart,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), 
                  topRight: Radius.circular(16)
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), 
                  topRight: Radius.circular(16)
                ),
                child: Image.asset(
                  imagePath, 
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, size: 50, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title, 
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rp. $price', 
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: ElevatedButton(
                      onPressed: onAddToCart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
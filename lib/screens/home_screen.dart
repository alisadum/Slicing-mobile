import 'package:flutter/material.dart';
import 'cart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";
  int selectedIndex = 0;
  Set<int> selectedProductIndices = {}; // Set untuk menyimpan beberapa indeks terpilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Menu',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple[100],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CategoryBox(
                    label: "All",
                    isSelected: selectedCategory == "All",
                    imagePath: 'assets/iconm.png',
                    onTap: () {
                      setState(() {
                        selectedCategory = "All";
                      });
                    },
                  ),
                  CategoryBox(
                    label: "Makanan",
                    isSelected: selectedCategory == "Makanan",
                    imagePath: 'assets/iconm.png',
                    onTap: () {
                      setState(() {
                        selectedCategory = "Makanan";
                      });
                    },
                  ),
                  CategoryBox(
                    label: "Minuman",
                    isSelected: selectedCategory == "Minuman",
                    imagePath: 'assets/iconb.png',
                    onTap: () {
                      setState(() {
                        selectedCategory = "Minuman";
                      });
                    },
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'All Food',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                return FoodItemCard(
                  imagePath: index == 2 ? 'assets/teh_botol.png' : 'assets/burger.png',
                  title: index == 2 ? 'Teh Botol' : 'Burger King Medium',
                  price: index == 2 ? 'Rp. 4,000.00' : 'Rp. 50,000.00',
                  isSelected: selectedProductIndices.contains(index),
                  onAddTap: () {
                    setState(() {
                      if (selectedProductIndices.contains(index)) {
                        selectedProductIndices.remove(index);
                      } else {
                        selectedProductIndices.add(index);
                      }
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.purple),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.pink),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blue),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class CategoryBox extends StatelessWidget {
  final String label;
  final bool isSelected;
  final String imagePath;
  final VoidCallback onTap;

  const CategoryBox({
    super.key,
    required this.label,
    this.isSelected = false,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isSelected ? Border.all(color: Colors.blue, width: 3) : null,
              boxShadow: isSelected
                  ? [BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 10, spreadRadius: 2)]
                  : [],
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                width: 50,
                height: 50,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final bool isSelected;
  final VoidCallback onAddTap;

  const FoodItemCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.isSelected,
    required this.onAddTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menggunakan Flexible agar gambar memenuhi sebagian besar card
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(price, style: const TextStyle(color: Colors.green)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: IconButton(
            icon: Icon(
              isSelected ? Icons.check_circle : Icons.add_circle,
              color: isSelected ? Colors.green : Colors.blue,
              size: 30,
            ),
            onPressed: onAddTap,
          ),
        ),
      ],
    );
  }
}

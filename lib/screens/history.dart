import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _selectedIndex = 3;

  // Menangani navigasi ketika bottom navigation bar dipilih
  void _onItemTapped(int index) {
    if (index == _selectedIndex) return; // Jangan lakukan apa-apa jika halaman yang sama dipilih

    setState(() {
      _selectedIndex = index; // Update index yang dipilih
    });

    // Navigasi ke halaman sesuai index tanpa mengganti Scaffold
    switch (index) {
      case 0: // Navigate to Home
        Navigator.pushNamed(context, '/home');
        break;
      case 1: // Navigate to Cart
        Navigator.pushNamed(context, '/cart');
        break;
      case 2: // Navigate to Checkout
        Navigator.pushNamed(context, '/checkout');
        break;
      case 3: // History, jangan lakukan apa-apa jika sudah di halaman ini
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        backgroundColor: Colors.purple,
      ),
      body: transactionHistory.isEmpty
          ? const Center(
              child: Text(
                'Belum ada transaksi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: transactionHistory.length,
              itemBuilder: (context, index) {
                final transaction = transactionHistory[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tanggal: ${transaction['date']}'),
                        Column(
                          children: List.generate(
                            (transaction['items'] as List<dynamic>).length,
                            (itemIndex) {
                              final item = transaction['items'][itemIndex];
                              return ListTile(
                                leading: Image.asset(
                                  item['imagePath'] ?? 'assets/images/placeholder.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(item['title'] ?? 'Tidak diketahui'),
                                subtitle: Text('Jumlah: ${item['quantity']} x Rp. ${item['price']}'),
                                trailing: Text('Rp. ${(item['quantity'] * item['price']).toStringAsFixed(0)}'),
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                            Text('Rp. ${transaction['total']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

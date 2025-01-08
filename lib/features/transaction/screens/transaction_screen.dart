import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../data/menu_data.dart';
import '../widgets/menu_list_item.dart';
import '../widgets/total_cart_summary.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final Map<int, int> _cart = {};

  void _addToCart(int itemId) {
    setState(() {
      _cart[itemId] = (_cart[itemId] ?? 0) + 1;
    });
    Fluttertoast.showToast(
      msg: "Item berhasil ditambahkan ke keranjang",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  void _removeFromCart(int itemId) {
    if (_cart[itemId] != null && _cart[itemId]! > 0) {
      setState(() {
        _cart[itemId] = _cart[itemId]! - 1;
        if (_cart[itemId] == 0) {
          _cart.remove(itemId);
        }
      });
      Fluttertoast.showToast(
        msg: "Item berhasil dikurangi dari keranjang",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
      );
    }
  }

  int _calculateTotal() {
    return _cart.entries.fold(0, (sum, entry) {
      final menuItem = menuItems.firstWhere((item) => item.id == entry.key);
      return sum + (menuItem.price * entry.value);
    });
  }

  void _checkout() {
    if (_cart.isEmpty) {
      Fluttertoast.showToast(
        msg: "Keranjang masih kosong!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    setState(() {
      _cart.clear();
    });

    Fluttertoast.showToast(
      msg: "Transaksi selesai! Terima kasih.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.brown,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_cafe, color: Colors.brown),
            const SizedBox(width: 8),
            const Text(
              'RF Coffee Shop',
              style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        elevation: 1,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Menu Pilihan',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.brown,
                ),
              ),
              const Divider(thickness: 1, color: Colors.grey),
              Expanded(
                child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: MenuListItem(
                        item: item,
                        quantity: _cart[item.id] ?? 0,
                        onAdd: () => _addToCart(item.id),
                        onRemove: () => _removeFromCart(item.id),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              TotalCartSummary(
                total: _calculateTotal(),
                onCheckout: _checkout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

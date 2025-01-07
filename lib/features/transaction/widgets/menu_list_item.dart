import 'package:flutter/material.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/models/menu_item.dart';

class MenuListItem extends StatelessWidget {
  final MenuItem item;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const MenuListItem({
    super.key,
    required this.item,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.brown.shade100,
          child: Text(
            item.name[0],
            style: const TextStyle(color: Colors.brown),
          ),
        ),
        title: Text(item.name, style: const TextStyle(fontSize: 18)),
        subtitle: Text(CurrencyFormatter.format(item.price)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.remove, color: Colors.red),
            ),
            Text(
              '$quantity',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: onAdd,
              icon: const Icon(Icons.add, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
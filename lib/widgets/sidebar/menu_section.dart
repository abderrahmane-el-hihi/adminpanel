import 'package:flutter/material.dart';
import '../../models/menu_item.dart';

class MenuSection extends StatelessWidget {
  final String title;
  final List<MenuItem> items;

  const MenuSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => _buildMenuItem(item)).toList(),
      ],
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    return ListTile(
      selected: item.isSelected,
      selectedTileColor: Colors.grey[100],
      leading: Icon(
        item.icon,
        color: item.isSelected ? Colors.black : Colors.grey[600],
        size: 20,
      ),
      title: Text(
        item.title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: item.isSelected ? FontWeight.w600 : FontWeight.normal,
          color: item.isSelected ? Colors.black : Colors.grey[800],
        ),
      ),
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
    );
  }
}

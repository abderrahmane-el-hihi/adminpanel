import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final bool isSelected;

  MenuItem({required this.title, required this.icon, this.isSelected = false});
}

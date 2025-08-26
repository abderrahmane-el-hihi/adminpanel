import 'package:flutter/material.dart';

class Project {
  final String name;
  final Color dotColor;
  final bool isSelected;

  Project({
    required this.name,
    required this.dotColor,
    this.isSelected = false,
  });
}

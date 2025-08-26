// import 'package:flutter/material.dart';

// class MenuItem {
//   final String title;
//   final IconData icon;
//   final bool isSelected;

//   MenuItem({required this.title, required this.icon, this.isSelected = false});
// }

import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final bool isSelected;

  const MenuItem({
    required this.title,
    required this.icon,
    this.isSelected = false,
  });

  MenuItem copyWith({bool? isSelected}) {
    return MenuItem(
      title: title,
      icon: icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

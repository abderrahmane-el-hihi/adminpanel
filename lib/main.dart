import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const HiveQApp());
}

class HiveQApp extends StatelessWidget {
  const HiveQApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HiveQ Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const DashboardScreen(),
    );
  }
}

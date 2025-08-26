import 'package:flutter/material.dart';

class KpiCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;

  const KpiCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // child: Card(
      //   elevation: 0,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      //   color: iconBgColor.withOpacity(0.15),
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Row(
      //           children: [
      //             Container(
      //               padding: const EdgeInsets.all(8),
      //               decoration: BoxDecoration(
      //                 color: iconColor,
      //                 borderRadius: BorderRadius.circular(8),
      //               ),
      //               child: Icon(icon, color: Colors.white, size: 20),
      //             ),
      //           ],
      //         ),
      //         const SizedBox(height: 16),
      //         Text(
      //           value,
      //           style: const TextStyle(
      //             fontSize: 24,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         const SizedBox(height: 4),
      //         Text(
      //           label,
      //           style: TextStyle(color: Colors.grey[700], fontSize: 14),
      //         ),
      //         const SizedBox(height: 16),
      //         Row(
      //           children: [
      //             Text(
      //               'View details',
      //               style: TextStyle(fontSize: 13, color: Colors.grey[800]),
      //             ),
      //             const SizedBox(width: 4),
      //             const Icon(Icons.arrow_forward, size: 16),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: .5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: iconColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: Colors.white, size: 20),
                  ),
                  Column(
                    children: [
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        label,
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'View details',
                    style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward, size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

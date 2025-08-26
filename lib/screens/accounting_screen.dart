import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import '../constants/app_colors.dart';

class AccountingScreen extends StatelessWidget {
  const AccountingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Accounting',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage your finances, track revenue, and monitor expenses',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Quick stats cards
        Row(
          children: [
            _buildStatCard(
              'Total Revenue',
              '\$128,420',
              FeatherIcons.trendingUp,
              Colors.green,
              '+12% from last month',
            ),
            const SizedBox(width: 16),
            _buildStatCard(
              'Total Expenses',
              '\$42,850',
              FeatherIcons.trendingDown,
              Colors.orange,
              '+5% from last month',
            ),
            const SizedBox(width: 16),
            _buildStatCard(
              'Net Profit',
              '\$85,570',
              FeatherIcons.dollarSign,
              AppColors.primary,
              '+18% from last month',
            ),
            const SizedBox(width: 16),
            _buildStatCard(
              'Pending Invoices',
              '24',
              FeatherIcons.fileText,
              Colors.blue,
              '\$36,240 outstanding',
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Main content placeholder
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: const Center(
            child: Text(
              'Accounting Dashboard Content',
              style: TextStyle(fontSize: 18),
            ),
          ),
          height: 400,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 16, color: color),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

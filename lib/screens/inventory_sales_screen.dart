import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import '../constants/app_colors.dart';

class InventorySalesScreen extends StatelessWidget {
  const InventorySalesScreen({super.key});

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
              'Inventory & Sales',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Monitor stock levels and track sales performance',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Quick action buttons
        Row(
          children: [
            _buildActionButton('Add Product', FeatherIcons.plus),
            const SizedBox(width: 12),
            _buildActionButton('Stock Adjustment', FeatherIcons.refreshCw),
            const SizedBox(width: 12),
            _buildActionButton('Generate Report', FeatherIcons.fileText),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    FeatherIcons.alertTriangle,
                    size: 16,
                    color: Colors.red[700],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '12 items below threshold',
                    style: TextStyle(
                      color: Colors.red[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Stats cards
        Row(
          children: [
            _buildStatCard(
              'Total Products',
              '1,248',
              FeatherIcons.package,
              '36 categories',
              Colors.blue,
            ),
            const SizedBox(width: 16),
            _buildStatCard(
              'Top Selling',
              'Laptops',
              FeatherIcons.trendingUp,
              '82 units this month',
              Colors.green,
            ),
            const SizedBox(width: 16),
            _buildStatCard(
              'Low Stock',
              '12',
              FeatherIcons.alertCircle,
              'Need reordering',
              Colors.red,
            ),
            const SizedBox(width: 16),
            _buildStatCard(
              'This Month Sales',
              '\$86,240',
              FeatherIcons.dollarSign,
              '+12% from last month',
              AppColors.primary,
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
              'Inventory & Sales Dashboard Content',
              style: TextStyle(fontSize: 18),
            ),
          ),
          height: 300,
        ),
      ],
    );
  }

  Widget _buildActionButton(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    String subtitle,
    Color color,
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

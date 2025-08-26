import 'package:flutter/material.dart';
import '../../models/performer.dart';

class PerformersList extends StatelessWidget {
  final List<Performer> performers;

  const PerformersList({super.key, required this.performers});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      padding: const EdgeInsets.all(16.0),
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
              const Text(
                'Top Performers',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  _buildFilterButton('7d', isSelected: true),
                  const SizedBox(width: 8),
                  _buildFilterButton('1M'),
                  const SizedBox(width: 8),
                  _buildFilterButton('1y'),
                  const SizedBox(width: 8),
                  _buildFilterButton('All'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...performers
              .map((performer) => _buildPerformerItem(performer))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.shade200 : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildPerformerItem(Performer performer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(performer.avatarUrl),
            radius: 16,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                performer.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                performer.email,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.more_horiz, color: Colors.grey),
        ],
      ),
    );
  }
}

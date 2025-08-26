import 'package:flutter/material.dart';
import '../../models/project.dart';

class ProjectList extends StatelessWidget {
  final List<Project> projects;

  const ProjectList({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Projects',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(Icons.add_circle_outline, size: 16, color: Colors.grey[600]),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...projects.map((project) => _buildProjectItem(project)).toList(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                'See all',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                size: 14,
                color: Colors.grey[600],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProjectItem(Project project) {
    return ListTile(
      leading: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: project.dotColor,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(
        project.name,
        style: TextStyle(
          fontSize: 14,
          fontWeight: project.isSelected ? FontWeight.w600 : FontWeight.normal,
          color: project.isSelected ? Colors.black : Colors.grey[800],
        ),
      ),
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
    );
  }
}

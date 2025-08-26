import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/menu_item.dart';
import '../../models/project.dart';
import 'menu_section.dart';
import 'project_list.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final mainMenuItems = [
      MenuItem(title: 'Dashboard', icon: Icons.dashboard, isSelected: true),
      MenuItem(title: 'Tasks', icon: Icons.check_box),
      MenuItem(title: 'Notes', icon: Icons.note),
      MenuItem(title: 'Email', icon: Icons.email),
      MenuItem(title: 'Calendar', icon: Icons.calendar_today),
    ];

    final secondaryMenuItems = [
      MenuItem(title: 'Reports', icon: Icons.bar_chart),
      MenuItem(title: 'Contacts', icon: Icons.people),
      MenuItem(title: 'Invite Team', icon: Icons.person_add),
    ];

    final projects = [
      Project(name: 'Figma Design System', dotColor: Colors.red),
      Project(name: 'Keep React', dotColor: Colors.cyan),
      Project(name: 'Static Mania', dotColor: Colors.blue),
    ];

    return Container(
      width: 240,
      color: AppColors.sidebar,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.change_history,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search, size: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(height: 8),
          MenuSection(title: 'Main Menu', items: mainMenuItems),
          const Divider(height: 32),
          MenuSection(title: 'Main Menu', items: secondaryMenuItems),
          const Divider(height: 32),
          ProjectList(projects: projects),
          const Spacer(),
          const Divider(height: 1),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: const Text('WP', style: TextStyle(color: Colors.white)),
            ),
            title: const Text(
              'Admin',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: const Text('Workspace'),
            trailing: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../constants/app_colors.dart';

// class TasksTab extends StatelessWidget {
//   const TasksTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Header
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Tasks',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             ElevatedButton.icon(
//               onPressed: () {},
//               icon: const Icon(Icons.add, size: 18),
//               label: const Text('Add Task'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 12,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 24),

//         // Task filters
//         Row(
//           children: [
//             _buildFilterChip('All', true),
//             _buildFilterChip('In Progress', false),
//             _buildFilterChip('Completed', false),
//             _buildFilterChip('Pending', false),
//           ],
//         ),
//         const SizedBox(height: 24),

//         // Tasks list
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Column(
//             children: [
//               _buildTaskItem(
//                 'Design new dashboard interface',
//                 'Design',
//                 DateTime.now(),
//                 'High',
//                 [
//                   'https://i.pravatar.cc/150?img=1',
//                   'https://i.pravatar.cc/150?img=2',
//                 ],
//                 true,
//               ),
//               const Divider(height: 1),
//               _buildTaskItem(
//                 'Implement authentication flow',
//                 'Development',
//                 DateTime.now().add(const Duration(days: 2)),
//                 'Medium',
//                 ['https://i.pravatar.cc/150?img=3'],
//                 false,
//               ),
//               const Divider(height: 1),
//               _buildTaskItem(
//                 'Create user documentation',
//                 'Documentation',
//                 DateTime.now().add(const Duration(days: 5)),
//                 'Low',
//                 [
//                   'https://i.pravatar.cc/150?img=4',
//                   'https://i.pravatar.cc/150?img=5',
//                 ],
//                 false,
//               ),
//               const Divider(height: 1),
//               _buildTaskItem(
//                 'User testing for new features',
//                 'Testing',
//                 DateTime.now().add(const Duration(days: 3)),
//                 'High',
//                 [
//                   'https://i.pravatar.cc/150?img=6',
//                   'https://i.pravatar.cc/150?img=7',
//                   'https://i.pravatar.cc/150?img=8',
//                 ],
//                 false,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFilterChip(String label, bool isSelected) {
//     return Container(
//       margin: const EdgeInsets.only(right: 12),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: isSelected ? AppColors.primary : Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: isSelected ? AppColors.primary : Colors.grey.shade300,
//         ),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           color: isSelected ? Colors.white : Colors.grey[800],
//           fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
//         ),
//       ),
//     );
//   }

//   Widget _buildTaskItem(
//     String title,
//     String category,
//     DateTime dueDate,
//     String priority,
//     List<String> assignees,
//     bool isCompleted,
//   ) {
//     Color priorityColor;
//     switch (priority.toLowerCase()) {
//       case 'high':
//         priorityColor = Colors.red;
//         break;
//       case 'medium':
//         priorityColor = Colors.orange;
//         break;
//       default:
//         priorityColor = Colors.green;
//     }

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           // Checkbox
//           SizedBox(
//             width: 24,
//             height: 24,
//             child: Checkbox(
//               value: isCompleted,
//               onChanged: (value) {},
//               activeColor: AppColors.primary,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),

//           // Task details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     decoration: isCompleted ? TextDecoration.lineThrough : null,
//                     color: isCompleted ? Colors.grey : Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 2,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.blue.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Text(
//                         category,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     const Icon(
//                       Icons.calendar_today,
//                       size: 14,
//                       color: Colors.grey,
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       '${dueDate.day}/${dueDate.month}/${dueDate.year}',
//                       style: const TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                     const SizedBox(width: 12),
//                     Container(
//                       width: 8,
//                       height: 8,
//                       decoration: BoxDecoration(
//                         color: priorityColor,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       priority,
//                       style: TextStyle(fontSize: 12, color: priorityColor),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // Assignees
//           SizedBox(
//             width: 100,
//             child: Stack(
//               children: [
//                 for (int i = 0; i < assignees.length; i++)
//                   Positioned(
//                     left: i * 20.0,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.white, width: 2),
//                       ),
//                       child: CircleAvatar(
//                         radius: 12,
//                         backgroundImage: NetworkImage(assignees[i]),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),

//           // Actions
//           IconButton(
//             icon: const Icon(Icons.more_vert, color: Colors.grey),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import '../constants/app_colors.dart';
import '../widgets/shared/avatar_group.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage Your Tasks',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Organize, prioritize, and track your work progress',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Task filters
        Row(
          children: [
            _buildFilterChip('All', true),
            _buildFilterChip('In Progress', false),
            _buildFilterChip('Completed', false),
            _buildFilterChip('Pending', false),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(FeatherIcons.plus, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  const Text(
                    'Add Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Tasks list
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              _buildTaskItem(
                'Design new dashboard interface',
                'Design',
                DateTime.now(),
                'High',
                [
                  'https://i.pravatar.cc/150?img=1',
                  'https://i.pravatar.cc/150?img=2',
                ],
                true,
              ),
              const Divider(height: 1),
              _buildTaskItem(
                'Implement authentication flow',
                'Development',
                DateTime.now().add(const Duration(days: 2)),
                'Medium',
                ['https://i.pravatar.cc/150?img=3'],
                false,
              ),
              const Divider(height: 1),
              _buildTaskItem(
                'Create user documentation',
                'Documentation',
                DateTime.now().add(const Duration(days: 5)),
                'Low',
                [
                  'https://i.pravatar.cc/150?img=4',
                  'https://i.pravatar.cc/150?img=5',
                ],
                false,
              ),
              const Divider(height: 1),
              _buildTaskItem(
                'User testing for new features',
                'Testing',
                DateTime.now().add(const Duration(days: 3)),
                'High',
                [
                  'https://i.pravatar.cc/150?img=6',
                  'https://i.pravatar.cc/150?img=7',
                  'https://i.pravatar.cc/150?img=8',
                ],
                false,
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Task statistics
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Total Tasks',
                '42',
                FeatherIcons.clipboard,
                Colors.blue.shade100,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'In Progress',
                '12',
                FeatherIcons.loader,
                Colors.orange.shade100,
                Colors.orange,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Completed',
                '27',
                FeatherIcons.checkCircle,
                Colors.green.shade100,
                Colors.green,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Overdue',
                '3',
                FeatherIcons.alertCircle,
                Colors.red.shade100,
                Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey.shade300,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[800],
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTaskItem(
    String title,
    String category,
    DateTime dueDate,
    String priority,
    List<String> assignees,
    bool isCompleted,
  ) {
    Color priorityColor;
    switch (priority.toLowerCase()) {
      case 'high':
        priorityColor = Colors.red;
        break;
      case 'medium':
        priorityColor = Colors.orange;
        break;
      default:
        priorityColor = Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Checkbox
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: isCompleted,
              onChanged: (value) {},
              activeColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Task details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted ? Colors.grey : Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(FeatherIcons.calendar, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      '${dueDate.day}/${dueDate.month}/${dueDate.year}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: priorityColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      priority,
                      style: TextStyle(fontSize: 12, color: priorityColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Assignees
          AvatarGroup(avatarUrls: assignees),

          // Actions
          IconButton(
            icon: Icon(FeatherIcons.moreVertical, size: 18, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color bgColor,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              const Spacer(),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

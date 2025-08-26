// import 'package:flutter/material.dart';
// import '../constants/app_colors.dart';

// class NotesTab extends StatelessWidget {
//   const NotesTab({super.key});

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
//               'Notes',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             ElevatedButton.icon(
//               onPressed: () {},
//               icon: const Icon(Icons.add, size: 18),
//               label: const Text('Create Note'),
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

//         // Notes filters
//         Row(
//           children: [
//             _buildFilterChip('All Notes', true),
//             _buildFilterChip('Personal', false),
//             _buildFilterChip('Work', false),
//             _buildFilterChip('Archived', false),
//           ],
//         ),
//         const SizedBox(height: 24),

//         // Notes grid
//         GridView.count(
//           crossAxisCount: 3,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           children: [
//             _buildNoteCard(
//               'Project Kickoff Notes',
//               'Meeting notes from the project kickoff with design team. Discussed timeline, deliverables and resource allocation.',
//               'Aug 25, 2025',
//               Colors.blue.shade100,
//             ),
//             _buildNoteCard(
//               'Feature Ideas',
//               'Potential features for next sprint:\n- User profile customization\n- Notification center\n- Export reports as PDF',
//               'Aug 24, 2025',
//               Colors.green.shade100,
//             ),
//             _buildNoteCard(
//               'Client Feedback',
//               'Client requested following changes:\n1. Larger font size in dashboard\n2. More color contrast\n3. Simpler navigation',
//               'Aug 22, 2025',
//               Colors.orange.shade100,
//             ),
//             _buildNoteCard(
//               'Week Planning',
//               'Monday: Team meeting\nTuesday: Design review\nWednesday: Client presentation\nThursday: Development\nFriday: Testing',
//               'Aug 21, 2025',
//               Colors.purple.shade100,
//             ),
//             _buildNoteCard(
//               'Resources to Share',
//               'Useful articles and resources to share with the team during next meeting',
//               'Aug 20, 2025',
//               Colors.red.shade100,
//             ),
//             _buildNoteCard(
//               'Quick Ideas',
//               'Random ideas to explore later:\n- Night mode\n- Voice commands\n- AI-powered suggestions',
//               'Aug 18, 2025',
//               Colors.teal.shade100,
//             ),
//           ],
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

//   Widget _buildNoteCard(
//     String title,
//     String content,
//     String date,
//     Color color,
//   ) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               PopupMenuButton(
//                 icon: const Icon(Icons.more_vert, size: 18),
//                 itemBuilder: (context) => [
//                   const PopupMenuItem(value: 'edit', child: Text('Edit')),
//                   const PopupMenuItem(value: 'share', child: Text('Share')),
//                   const PopupMenuItem(value: 'archive', child: Text('Archive')),
//                   const PopupMenuItem(value: 'delete', child: Text('Delete')),
//                 ],
//                 padding: EdgeInsets.zero,
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Expanded(
//             child: Text(
//               content,
//               style: const TextStyle(fontSize: 14),
//               overflow: TextOverflow.ellipsis,
//               maxLines: 6,
//             ),
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               const Icon(Icons.access_time, size: 14, color: Colors.grey),
//               const SizedBox(width: 4),
//               Text(
//                 date,
//                 style: const TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import '../constants/app_colors.dart';

class NotesTab extends StatelessWidget {
  const NotesTab({super.key});

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
              'Your Notes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Capture ideas, organize thoughts, and keep track of important information',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Notes filters
        Row(
          children: [
            _buildFilterChip('All Notes', true),
            _buildFilterChip('Personal', false),
            _buildFilterChip('Work', false),
            _buildFilterChip('Archived', false),
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
                    'Create Note',
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

        // Notes grid
        GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildNoteCard(
              'Project Kickoff Notes',
              'Meeting notes from the project kickoff with design team. Discussed timeline, deliverables and resource allocation.',
              'Aug 25, 2025',
              Colors.blue.shade100,
            ),
            _buildNoteCard(
              'Feature Ideas',
              'Potential features for next sprint:\n- User profile customization\n- Notification center\n- Export reports as PDF',
              'Aug 24, 2025',
              Colors.green.shade100,
            ),
            _buildNoteCard(
              'Client Feedback',
              'Client requested following changes:\n1. Larger font size in dashboard\n2. More color contrast\n3. Simpler navigation',
              'Aug 22, 2025',
              Colors.orange.shade100,
            ),
            _buildNoteCard(
              'Week Planning',
              'Monday: Team meeting\nTuesday: Design review\nWednesday: Client presentation\nThursday: Development\nFriday: Testing',
              'Aug 21, 2025',
              Colors.purple.shade100,
            ),
            _buildNoteCard(
              'Resources to Share',
              'Useful articles and resources to share with the team during next meeting',
              'Aug 20, 2025',
              Colors.red.shade100,
            ),
            _buildNoteCard(
              'Quick Ideas',
              'Random ideas to explore later:\n- Night mode\n- Voice commands\n- AI-powered suggestions',
              'Aug 18, 2025',
              Colors.teal.shade100,
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

  Widget _buildNoteCard(
    String title,
    String content,
    String date,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuButton(
                icon: Icon(FeatherIcons.moreVertical, size: 16),
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'share', child: Text('Share')),
                  const PopupMenuItem(value: 'archive', child: Text('Archive')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
              maxLines: 6,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(FeatherIcons.clock, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                date,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

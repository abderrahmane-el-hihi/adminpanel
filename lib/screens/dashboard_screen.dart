// import 'package:admindashboard/models/meetings.dart';
// import 'package:flutter/material.dart';
// import '../constants/app_colors.dart';

// import '../models/performer.dart';
// import '../widgets/dashboard/calendar_widget.dart';
// import '../widgets/dashboard/hiring_chart.dart';
// import '../widgets/dashboard/kpi_card.dart';
// import '../widgets/dashboard/performers_list.dart';
// import '../widgets/dashboard/upcoming_meetings.dart';
// import '../widgets/shared/avatar_group.dart';
// import '../widgets/sidebar/sidebar.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Mock data for performers
//     final performers = [
//       Performer(
//         name: 'Rainer Brown',
//         email: 'rainer@example.com',
//         avatarUrl: 'https://i.pravatar.cc/150?img=1',
//       ),
//       Performer(
//         name: 'Alex Sullivan',
//         email: 'alex@example.com',
//         avatarUrl: 'https://i.pravatar.cc/150?img=2',
//       ),
//       Performer(
//         name: 'Conny Rany',
//         email: 'conny@example.com',
//         avatarUrl: 'https://i.pravatar.cc/150?img=3',
//       ),
//       Performer(
//         name: 'Lily Alexa',
//         email: 'lily@example.com',
//         avatarUrl: 'https://i.pravatar.cc/150?img=4',
//       ),
//     ];

//     // Mock data for meetings
//     final meetings = [
//       Meeting(
//         title: 'Meeting with Harry',
//         timeRange: '12:00 - 01:00 PM',
//         date: DateTime.now(),
//         attendees: [
//           'https://i.pravatar.cc/150?img=5',
//           'https://i.pravatar.cc/150?img=6',
//           'https://i.pravatar.cc/150?img=7',
//         ],
//         indicatorColor: AppColors.meetingGreen,
//       ),
//       Meeting(
//         title: 'Meeting with Salah',
//         timeRange: '05:00 - 11:30 AM',
//         date: DateTime.now().add(const Duration(days: 1)),
//         attendees: [
//           'https://i.pravatar.cc/150?img=8',
//           'https://i.pravatar.cc/150?img=9',
//           'https://i.pravatar.cc/150?img=10',
//         ],
//         indicatorColor: AppColors.meetingBlue,
//       ),
//       Meeting(
//         title: 'Meeting with Mbappe',
//         timeRange: '02:00 - 03:05 PM',
//         date: DateTime.now().add(const Duration(days: 1)),
//         attendees: [
//           'https://i.pravatar.cc/150?img=11',
//           'https://i.pravatar.cc/150?img=12',
//           'https://i.pravatar.cc/150?img=13',
//         ],
//         indicatorColor: AppColors.meetingOrange,
//       ),
//     ];

//     return Scaffold(
//       body: Row(
//         children: [
//           // Sidebar
//           const Sidebar(),

//           // Main content
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Left: Page title
//                       const Text(
//                         'Dashboard',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       // Right: User actions
//                       Row(
//                         children: [
//                           // Avatars group
//                           AvatarGroup(
//                             avatarUrls: [
//                               'https://i.pravatar.cc/150?img=14',
//                               'https://i.pravatar.cc/150?img=15',
//                               'https://i.pravatar.cc/150?img=16',
//                             ],
//                           ),
//                           const SizedBox(width: 16),
//                           const Icon(Icons.add_circle_outline),
//                           const SizedBox(width: 16),
//                           const Icon(Icons.circle_outlined),
//                           const SizedBox(width: 16),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 8,
//                             ),
//                             decoration: BoxDecoration(
//                               color: AppColors.primary,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: const Row(
//                               children: [
//                                 Icon(
//                                   Icons.share,
//                                   color: Colors.white,
//                                   size: 16,
//                                 ),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   'Share',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           const Icon(Icons.more_vert),
//                         ],
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 24),

//                   // Welcome section
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           const Text(
//                             'Welcome Back, Admin',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           const Text('👋', style: TextStyle(fontSize: 24)),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Your Team\'s Success Starts Here. Let\'s Make Progress Together!',
//                         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 24),

//                   // KPI Cards and Date Range
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // KPI Cards
//                       const Expanded(
//                         flex: 3,
//                         child: Row(
//                           children: [
//                             KpiCard(
//                               value: '560',
//                               label: 'Attendance',
//                               icon: Icons.people,
//                               iconBgColor: AppColors.attendanceIcon,
//                               iconColor: AppColors.attendanceIcon,
//                             ),
//                             SizedBox(width: 16),
//                             KpiCard(
//                               value: '010',
//                               label: 'Absent',
//                               icon: Icons.person_off,
//                               iconBgColor: AppColors.absentIcon,
//                               iconColor: AppColors.absentIcon,
//                             ),
//                             SizedBox(width: 16),
//                             KpiCard(
//                               value: '40',
//                               label: 'Leave Apply',
//                               icon: Icons.calendar_today,
//                               iconBgColor: AppColors.leaveIcon,
//                               iconColor: AppColors.leaveIcon,
//                             ),
//                           ],
//                         ),
//                       ),

//                       // Add New Button
//                       Container(
//                         margin: const EdgeInsets.only(left: 16),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 12,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppColors.primary,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Row(
//                           children: [
//                             Icon(Icons.add, color: Colors.white, size: 18),
//                             SizedBox(width: 8),
//                             Text(
//                               'Add New',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 24),

//                   // Charts and Calendar Section
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Left: Hiring Chart
//                       const Expanded(flex: 7, child: HiringChart()),

//                       const SizedBox(width: 24),

//                       // Right: Calendar and Meetings
//                       Expanded(
//                         flex: 5,
//                         child: Column(
//                           children: [
//                             const CalendarWidget(),
//                             const SizedBox(height: 24),
//                             UpcomingMeetings(meetings: meetings),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 24),

//                   // Bottom Section: Performers and Job Applications
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Left: Performers List
//                       Expanded(
//                         flex: 7,
//                         child: PerformersList(performers: performers),
//                       ),

//                       const SizedBox(width: 24),

//                       // Right: Job Applications
//                       Expanded(
//                         flex: 5,
//                         child: Container(
//                           padding: const EdgeInsets.all(16.0),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Colors.grey.shade200),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Top Performers',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               Container(
//                                 padding: const EdgeInsets.all(16),
//                                 decoration: BoxDecoration(
//                                   color: Colors.orange.shade50,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Job Applications',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 16),
//                                     Row(
//                                       children: [
//                                         _buildJobStat('246', 'Interviews'),
//                                         const SizedBox(width: 24),
//                                         _buildJobStat('101', 'Hired'),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 24),
//                               const Text(
//                                 'UPCOMING INTERVIEWS',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   letterSpacing: 1,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildJobStat(String value, String label) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           value,
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 4),
//         Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
//       ],
//     );
//   }
// }

///=============================================

// import 'package:admindashboard/models/meetings.dart';
// import 'package:flutter/material.dart';
// import 'package:feather_icons/feather_icons.dart';
// import '../constants/app_colors.dart';

// import '../models/performer.dart';
// import '../widgets/dashboard/calendar_widget.dart';
// import '../widgets/dashboard/hiring_chart.dart';
// import '../widgets/dashboard/kpi_card.dart';
// import '../widgets/dashboard/performers_list.dart';
// import '../widgets/dashboard/upcoming_meetings.dart';
// import '../widgets/shared/avatar_group.dart';
// import '../widgets/sidebar/sidebar.dart';
// import 'tasks_tab.dart';
// import 'notes_tab.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   int _selectedNavIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     // Mock data for performers
//     final performers = [
//       Performer(
//         name: 'Rainer Brown',
//         email: 'rainer@example.com',
//         avatarUrl: 'https://i.pravatar.cc/150?img=1',
//       ),
//       Performer(
//         name: 'Alex Sullivan',
//         email: 'alex@example.com',
//         avatarUrl: 'https://i.pravatar.cc/150?img=2',
//       ),
//       Performer(
//         name: 'Conny Rany',
//         email: 'conny@example.com',
//         avatarUrl: 'https://i.pravatar.cc/150?img=3',
//       ),
//       Performer(
//         name: 'Lily Alexa',
//         email: 'lily@example.com',
//         avatarUrl: 'https://i.pravatar.cc/150?img=4',
//       ),
//     ];

//     // Mock data for meetings
//     final meetings = [
//       Meeting(
//         title: 'Meeting with Harry',
//         timeRange: '12:00 - 01:00 PM',
//         date: DateTime.now(),
//         attendees: [
//           'https://i.pravatar.cc/150?img=5',
//           'https://i.pravatar.cc/150?img=6',
//           'https://i.pravatar.cc/150?img=7',
//         ],
//         indicatorColor: AppColors.meetingGreen,
//       ),
//       Meeting(
//         title: 'Meeting with Salah',
//         timeRange: '05:00 - 11:30 AM',
//         date: DateTime.now().add(const Duration(days: 1)),
//         attendees: [
//           'https://i.pravatar.cc/150?img=8',
//           'https://i.pravatar.cc/150?img=9',
//           'https://i.pravatar.cc/150?img=10',
//         ],
//         indicatorColor: AppColors.meetingBlue,
//       ),
//       Meeting(
//         title: 'Meeting with Mbappe',
//         timeRange: '02:00 - 03:05 PM',
//         date: DateTime.now().add(const Duration(days: 1)),
//         attendees: [
//           'https://i.pravatar.cc/150?img=11',
//           'https://i.pravatar.cc/150?img=12',
//           'https://i.pravatar.cc/150?img=13',
//         ],
//         indicatorColor: AppColors.meetingOrange,
//       ),
//     ];

//     return Scaffold(
//       body: Row(
//         children: [
//           // Sidebar
//           Sidebar(
//             selectedIndex: _selectedNavIndex,
//             onNavigate: (index) {
//               setState(() {
//                 _selectedNavIndex = index;
//               });
//             },
//           ),

//           // Main content
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Left: Page title
//                       Text(
//                         _getPageTitle(),
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       // Right: User actions
//                       Row(
//                         children: [
//                           // Avatars group
//                           AvatarGroup(
//                             avatarUrls: [
//                               'https://i.pravatar.cc/150?img=14',
//                               'https://i.pravatar.cc/150?img=15',
//                               'https://i.pravatar.cc/150?img=16',
//                             ],
//                           ),
//                           const SizedBox(width: 16),
//                           const Icon(FeatherIcons.plusCircle, size: 18),
//                           const SizedBox(width: 16),
//                           const Icon(FeatherIcons.bell, size: 18),
//                           const SizedBox(width: 16),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 8,
//                             ),
//                             decoration: BoxDecoration(
//                               color: AppColors.primary,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   FeatherIcons.share2,
//                                   color: Colors.white,
//                                   size: 16,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 const Text(
//                                   'Share',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           const Icon(FeatherIcons.moreVertical, size: 18),
//                         ],
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 24),

//                   // Content based on selected navigation
//                   _getContent(performers, meetings),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _getPageTitle() {
//     switch (_selectedNavIndex) {
//       case 1:
//         return 'Tasks';
//       case 2:
//         return 'Notes';
//       default:
//         return 'Dashboard';
//     }
//   }

//   Widget _getContent(List<Performer> performers, List<Meeting> meetings) {
//     switch (_selectedNavIndex) {
//       case 1:
//         return const TasksTab();
//       case 2:
//         return const NotesTab();
//       default:
//         return _buildDashboardContent(performers, meetings);
//     }
//   }

//   Widget _buildDashboardContent(
//     List<Performer> performers,
//     List<Meeting> meetings,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Welcome section
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const Text(
//                   'Welcome Back, Wolf Pixel',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(width: 8),
//                 const Text('👋', style: TextStyle(fontSize: 24)),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Your Team\'s Success Starts Here. Let\'s Make Progress Together!',
//               style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//             ),
//           ],
//         ),

//         const SizedBox(height: 24),

//         // KPI Cards and Date Range
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // KPI Cards
//             const Expanded(
//               flex: 3,
//               child: Row(
//                 children: [
//                   KpiCard(
//                     value: '560',
//                     label: 'Attendance',
//                     icon: FeatherIcons.users,
//                     iconBgColor: AppColors.attendanceIcon,
//                     iconColor: AppColors.attendanceIcon,
//                   ),
//                   SizedBox(width: 16),
//                   KpiCard(
//                     value: '010',
//                     label: 'Absent',
//                     icon: FeatherIcons.userX,
//                     iconBgColor: AppColors.absentIcon,
//                     iconColor: AppColors.absentIcon,
//                   ),
//                   SizedBox(width: 16),
//                   KpiCard(
//                     value: '40',
//                     label: 'Leave Apply',
//                     icon: FeatherIcons.calendar,
//                     iconBgColor: AppColors.leaveIcon,
//                     iconColor: AppColors.leaveIcon,
//                   ),
//                 ],
//               ),
//             ),

//             // Add New Button
//             Container(
//               margin: const EdgeInsets.only(left: 16),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 color: AppColors.primary,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 children: [
//                   Icon(FeatherIcons.plus, color: Colors.white, size: 18),
//                   const SizedBox(width: 8),
//                   const Text(
//                     'Add New',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),

//         const SizedBox(height: 24),

//         // Charts and Calendar Section
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Left: Hiring Chart
//             const Expanded(flex: 7, child: HiringChart()),

//             const SizedBox(width: 24),

//             // Right: Calendar and Meetings
//             Expanded(
//               flex: 5,
//               child: Column(
//                 children: [
//                   const CalendarWidget(),
//                   const SizedBox(height: 24),
//                   UpcomingMeetings(meetings: meetings),
//                 ],
//               ),
//             ),
//           ],
//         ),

//         const SizedBox(height: 24),

//         // Bottom Section: Performers and Job Applications
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Left: Performers List
//             Expanded(flex: 7, child: PerformersList(performers: performers)),

//             const SizedBox(width: 24),

//             // Right: Job Applications
//             Expanded(
//               flex: 5,
//               child: Container(
//                 padding: const EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade200),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Top Performers',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.orange.shade50,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Job Applications',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Row(
//                             children: [
//                               _buildJobStat('246', 'Interviews'),
//                               const SizedBox(width: 24),
//                               _buildJobStat('101', 'Hired'),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     const Text(
//                       'UPCOMING INTERVIEWS',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildJobStat(String value, String label) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           value,
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 4),
//         Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
//       ],
//     );
//   }
// }
//===================

// import 'package:admindashboard/screens/inventory_sales_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:feather_icons/feather_icons.dart';
// import '../constants/app_colors.dart';
// import '../models/meeting.dart';
// import '../models/performer.dart';
// import '../widgets/dashboard/calendar_widget.dart';
// import '../widgets/dashboard/hiring_chart.dart';
// import '../widgets/dashboard/kpi_card.dart';
// import '../widgets/dashboard/performers_list.dart';
// import '../widgets/dashboard/upcoming_meetings.dart';
// import '../widgets/shared/avatar_group.dart';
// import '../widgets/sidebar/sidebar.dart';
// import 'tasks_tab.dart';
// import 'notes_tab.dart';
// import 'accounting_screen.dart';
// import 'pos_screen.dart';
// import 'purchase_screen.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   int _selectedNavIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     // Mock data for performers
//     final performers = [
//       Performer(
//         name: 'Rainer Brown',
//         email: 'rainer@example.com',
//         avatarUrl: 'https://i.pravatar.cc/150?img=1',
//       ),
//       Performer(
//         name: 'Alex Sullivan',
//         email: 'alex@example.com',
//         avatarUrl: 'https://i.pravatar.cc/150?img=2',
//       ),
//       Performer(
//         name: 'Conny Rany',
//         email: 'conny@example.com',
//         avatarUrl: 'https://i.pravatar.cc/150?img=3',
//       ),
//       Performer(
//         name: 'Lily Alexa',
//         email: 'lily@example.com',
//         avatarUrl: 'https://i.pravatar.cc/150?img=4',
//       ),
//     ];

//     // Mock data for meetings
//     final meetings = [
//       Meeting(
//         title: 'Meeting with Harry',
//         timeRange: '12:00 - 01:00 PM',
//         date: DateTime.now(),
//         attendees: [
//           'https://i.pravatar.cc/150?img=5',
//           'https://i.pravatar.cc/150?img=6',
//           'https://i.pravatar.cc/150?img=7',
//         ],
//         indicatorColor: AppColors.meetingGreen,
//       ),
//       Meeting(
//         title: 'Meeting with Salah',
//         timeRange: '05:00 - 11:30 AM',
//         date: DateTime.now().add(const Duration(days: 1)),
//         attendees: [
//           'https://i.pravatar.cc/150?img=8',
//           'https://i.pravatar.cc/150?img=9',
//           'https://i.pravatar.cc/150?img=10',
//         ],
//         indicatorColor: AppColors.meetingBlue,
//       ),
//       Meeting(
//         title: 'Meeting with Mbappe',
//         timeRange: '02:00 - 03:05 PM',
//         date: DateTime.now().add(const Duration(days: 1)),
//         attendees: [
//           'https://i.pravatar.cc/150?img=11',
//           'https://i.pravatar.cc/150?img=12',
//           'https://i.pravatar.cc/150?img=13',
//         ],
//         indicatorColor: AppColors.meetingOrange,
//       ),
//     ];

//     return Scaffold(
//       body: Row(
//         children: [
//           // Sidebar
//           Sidebar(
//             selectedIndex: _selectedNavIndex,
//             onNavigate: (index) {
//               setState(() {
//                 _selectedNavIndex = index;
//               });
//             },
//           ),

//           // Main content
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Left: Page title
//                       Text(
//                         _getPageTitle(),
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       // Right: User actions
//                       Row(
//                         children: [
//                           // Avatars group
//                           AvatarGroup(
//                             avatarUrls: [
//                               'https://i.pravatar.cc/150?img=14',
//                               'https://i.pravatar.cc/150?img=15',
//                               'https://i.pravatar.cc/150?img=16',
//                             ],
//                           ),
//                           const SizedBox(width: 16),
//                           const Icon(FeatherIcons.plusCircle, size: 18),
//                           const SizedBox(width: 16),
//                           const Icon(FeatherIcons.bell, size: 18),
//                           const SizedBox(width: 16),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 8,
//                             ),
//                             decoration: BoxDecoration(
//                               color: AppColors.primary,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   FeatherIcons.share2,
//                                   color: Colors.white,
//                                   size: 16,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 const Text(
//                                   'Share',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           const Icon(FeatherIcons.moreVertical, size: 18),
//                         ],
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 24),

//                   // Content based on selected navigation
//                   _getContent(performers, meetings),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _getPageTitle() {
//     switch (_selectedNavIndex) {
//       case 1:
//         return 'Tasks';
//       case 2:
//         return 'Notes';
//       case 3:
//         return 'Accounting';
//       case 4:
//         return 'Point of Sale';
//       case 5:
//         return 'Purchase';
//       case 6:
//         return 'Inventory Sales';
//       default:
//         return 'Dashboard';
//     }
//   }

//   Widget _getContent(List<Performer> performers, List<Meeting> meetings) {
//     switch (_selectedNavIndex) {
//       case 1:
//         return const TasksTab();
//       case 2:
//         return const NotesTab();
//       case 3:
//         return const AccountingScreen();
//       case 4:
//         return const POSScreen();
//       case 5:
//         return const PurchaseScreen();
//       case 6:
//         return const InventorySalesScreen();
//       default:
//         return _buildDashboardContent(performers, meetings);
//     }
//   }

//   Widget _buildDashboardContent(
//     List<Performer> performers,
//     List<Meeting> meetings,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Welcome section
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const Text(
//                   'Welcome Back, Wolf Pixel',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(width: 8),
//                 const Text('👋', style: TextStyle(fontSize: 24)),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Your Team\'s Success Starts Here. Let\'s Make Progress Together!',
//               style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//             ),
//           ],
//         ),

//         const SizedBox(height: 24),

//         // KPI Cards and Date Range
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // KPI Cards
//             const Expanded(
//               flex: 3,
//               child: Row(
//                 children: [
//                   KpiCard(
//                     value: '560',
//                     label: 'Attendance',
//                     icon: FeatherIcons.users,
//                     iconBgColor: AppColors.attendanceIcon,
//                     iconColor: AppColors.attendanceIcon,
//                   ),
//                   SizedBox(width: 16),
//                   KpiCard(
//                     value: '010',
//                     label: 'Absent',
//                     icon: FeatherIcons.userX,
//                     iconBgColor: AppColors.absentIcon,
//                     iconColor: AppColors.absentIcon,
//                   ),
//                   SizedBox(width: 16),
//                   KpiCard(
//                     value: '40',
//                     label: 'Leave Apply',
//                     icon: FeatherIcons.calendar,
//                     iconBgColor: AppColors.leaveIcon,
//                     iconColor: AppColors.leaveIcon,
//                   ),
//                 ],
//               ),
//             ),

//             // Add New Button
//             Container(
//               margin: const EdgeInsets.only(left: 16),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 color: AppColors.primary,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 children: [
//                   Icon(FeatherIcons.plus, color: Colors.white, size: 18),
//                   const SizedBox(width: 8),
//                   const Text(
//                     'Add New',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),

//         const SizedBox(height: 24),

//         // Charts and Calendar Section
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Left: Hiring Chart
//             const Expanded(flex: 7, child: HiringChart()),

//             const SizedBox(width: 24),

//             // Right: Calendar and Meetings
//             Expanded(
//               flex: 5,
//               child: Column(
//                 children: [
//                   const CalendarWidget(),
//                   const SizedBox(height: 24),
//                   UpcomingMeetings(meetings: meetings),
//                 ],
//               ),
//             ),
//           ],
//         ),

//         const SizedBox(height: 24),

//         // Bottom Section: Performers and Job Applications
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Left: Performers List
//             Expanded(flex: 7, child: PerformersList(performers: performers)),

//             const SizedBox(width: 24),

//             // Right: Job Applications
//             Expanded(
//               flex: 5,
//               child: Container(
//                 padding: const EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade200),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Top Performers',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.orange.shade50,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Job Applications',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Row(
//                             children: [
//                               _buildJobStat('246', 'Interviews'),
//                               const SizedBox(width: 24),
//                               _buildJobStat('101', 'Hired'),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     const Text(
//                       'UPCOMING INTERVIEWS',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildJobStat(String value, String label) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           value,
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 4),
//         Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
//       ],
//     );
//   }
// }

//=====================
import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import '../constants/app_colors.dart';
import '../models/meeting.dart';
import '../models/performer.dart';
import '../widgets/dashboard/calendar_widget.dart';
import '../widgets/dashboard/hiring_chart.dart';
import '../widgets/dashboard/kpi_card.dart';
import '../widgets/dashboard/performers_list.dart';
import '../widgets/dashboard/upcoming_meetings.dart';
import '../widgets/shared/avatar_group.dart';
import '../widgets/sidebar/sidebar.dart';
import 'tasks_tab.dart';
import 'notes_tab.dart';
import 'accounting_screen.dart';
import 'pos_screen.dart';
import 'purchase_screen.dart';
import 'inventory_sales_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedNavIndex = 0;
  bool _isSidebarCollapsed = false;

  @override
  Widget build(BuildContext context) {
    // Mock data for performers
    final performers = [
      Performer(
        name: 'Rainer Brown',
        email: 'rainer@example.com',
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
      ),
      Performer(
        name: 'Alex Sullivan',
        email: 'alex@example.com',
        avatarUrl: 'https://i.pravatar.cc/150?img=2',
      ),
      Performer(
        name: 'Conny Rany',
        email: 'conny@example.com',
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
      ),
      Performer(
        name: 'Lily Alexa',
        email: 'lily@example.com',
        avatarUrl: 'https://i.pravatar.cc/150?img=4',
      ),
    ];

    // Mock data for meetings
    final meetings = [
      Meeting(
        title: 'Meeting with Harry',
        timeRange: '12:00 - 01:00 PM',
        date: DateTime.now(),
        attendees: [
          'https://i.pravatar.cc/150?img=5',
          'https://i.pravatar.cc/150?img=6',
          'https://i.pravatar.cc/150?img=7',
        ],
        indicatorColor: AppColors.meetingGreen,
      ),
      Meeting(
        title: 'Meeting with Salah',
        timeRange: '05:00 - 11:30 AM',
        date: DateTime.now().add(const Duration(days: 1)),
        attendees: [
          'https://i.pravatar.cc/150?img=8',
          'https://i.pravatar.cc/150?img=9',
          'https://i.pravatar.cc/150?img=10',
        ],
        indicatorColor: AppColors.meetingBlue,
      ),
      Meeting(
        title: 'Meeting with Mbappe',
        timeRange: '02:00 - 03:05 PM',
        date: DateTime.now().add(const Duration(days: 1)),
        attendees: [
          'https://i.pravatar.cc/150?img=11',
          'https://i.pravatar.cc/150?img=12',
          'https://i.pravatar.cc/150?img=13',
        ],
        indicatorColor: AppColors.meetingOrange,
      ),
    ];

    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Sidebar(
            selectedIndex: _selectedNavIndex,
            isCollapsed: _isSidebarCollapsed,
            onNavigate: (index) {
              setState(() {
                _selectedNavIndex = index;
              });
            },
            onToggleCollapse: () {
              setState(() {
                _isSidebarCollapsed = !_isSidebarCollapsed;
              });
            },
          ),

          // Main content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left: Page title
                      Text(
                        _getPageTitle(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Right: User actions
                      Row(
                        children: [
                          // Avatars group
                          AvatarGroup(
                            avatarUrls: [
                              'https://i.pravatar.cc/150?img=14',
                              'https://i.pravatar.cc/150?img=15',
                              'https://i.pravatar.cc/150?img=16',
                            ],
                          ),
                          const SizedBox(width: 16),
                          const Icon(FeatherIcons.plusCircle, size: 18),
                          const SizedBox(width: 16),
                          const Icon(FeatherIcons.bell, size: 18),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  FeatherIcons.share2,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Share',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(FeatherIcons.moreVertical, size: 18),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Content based on selected navigation
                  _getContent(performers, meetings),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPageTitle() {
    switch (_selectedNavIndex) {
      case 1:
        return 'Tasks';
      case 2:
        return 'Notes';
      case 3:
        return 'Accounting';
      case 4:
        return 'Point of Sale';
      case 5:
        return 'Purchase';
      case 6:
        return 'Inventory Sales';
      default:
        return 'Dashboard';
    }
  }

  Widget _getContent(List<Performer> performers, List<Meeting> meetings) {
    switch (_selectedNavIndex) {
      case 1:
        return const TasksTab();
      case 2:
        return const NotesTab();
      case 3:
        return const AccountingScreen();
      case 4:
        return const POSScreen();
      case 5:
        return const PurchaseScreen();
      case 6:
        return const InventorySalesScreen();
      default:
        return _buildDashboardContent(performers, meetings);
    }
  }

  // Rest of the code remains the same
  // ...
  Widget _buildDashboardContent(
    List<Performer> performers,
    List<Meeting> meetings,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Welcome Back, Wolf Pixel',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                const Text('👋', style: TextStyle(fontSize: 24)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Your Team\'s Success Starts Here. Let\'s Make Progress Together!',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // KPI Cards and Date Range
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // KPI Cards
            const Expanded(
              flex: 3,
              child: Row(
                children: [
                  KpiCard(
                    value: '560',
                    label: 'Attendance',
                    icon: FeatherIcons.users,
                    iconBgColor: AppColors.attendanceIcon,
                    iconColor: AppColors.attendanceIcon,
                  ),
                  SizedBox(width: 16),
                  KpiCard(
                    value: '010',
                    label: 'Absent',
                    icon: FeatherIcons.userX,
                    iconBgColor: AppColors.absentIcon,
                    iconColor: AppColors.absentIcon,
                  ),
                  SizedBox(width: 16),
                  KpiCard(
                    value: '40',
                    label: 'Leave Apply',
                    icon: FeatherIcons.calendar,
                    iconBgColor: AppColors.leaveIcon,
                    iconColor: AppColors.leaveIcon,
                  ),
                ],
              ),
            ),

            // Add New Button
            Container(
              margin: const EdgeInsets.only(left: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(FeatherIcons.plus, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  const Text(
                    'Add New',
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

        // Charts and Calendar Section
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Hiring Chart
            const Expanded(flex: 7, child: HiringChart()),

            const SizedBox(width: 24),

            // Right: Calendar and Meetings
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  const CalendarWidget(),
                  const SizedBox(height: 24),
                  UpcomingMeetings(meetings: meetings),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Bottom Section: Performers and Job Applications
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Performers List
            Expanded(flex: 7, child: PerformersList(performers: performers)),

            const SizedBox(width: 24),

            // Right: Job Applications
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Top Performers',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Job Applications',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildJobStat('246', 'Interviews'),
                              const SizedBox(width: 24),
                              _buildJobStat('101', 'Hired'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'UPCOMING INTERVIEWS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildJobStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      ],
    );
  }
}

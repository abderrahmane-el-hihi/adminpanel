// import 'package:flutter/material.dart';
// import 'package:feather_icons/feather_icons.dart';
// import '../../constants/app_colors.dart';
// import '../../models/menu_item.dart';
// import '../../models/project.dart';
// import 'menu_section.dart';
// import 'project_list.dart';

// class Sidebar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onNavigate;

//   const Sidebar({
//     super.key,
//     required this.selectedIndex,
//     required this.onNavigate,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final mainMenuItems = [
//       MenuItem(
//         title: 'Dashboard',
//         icon: FeatherIcons.layout,
//         isSelected: selectedIndex == 0,
//       ),
//       MenuItem(
//         title: 'Tasks',
//         icon: FeatherIcons.checkSquare,
//         isSelected: selectedIndex == 1,
//       ),
//       MenuItem(
//         title: 'Notes',
//         icon: FeatherIcons.fileText,
//         isSelected: selectedIndex == 2,
//       ),
//       MenuItem(title: 'Email', icon: FeatherIcons.mail, isSelected: false),
//       MenuItem(
//         title: 'Calendar',
//         icon: FeatherIcons.calendar,
//         isSelected: false,
//       ),
//     ];

//     final secondaryMenuItems = [
//       MenuItem(title: 'Reports', icon: FeatherIcons.barChart2),
//       MenuItem(title: 'Contacts', icon: FeatherIcons.users),
//       MenuItem(title: 'Invite Team', icon: FeatherIcons.userPlus),
//     ];

//     final projects = [
//       Project(name: 'Figma Design System', dotColor: Colors.red),
//       Project(name: 'Keep React', dotColor: Colors.cyan),
//       Project(name: 'Static Mania', dotColor: Colors.blue),
//     ];

//     return Container(
//       width: 240,
//       color: AppColors.sidebar,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: AppColors.primary,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Icon(
//                     FeatherIcons.hexagon,
//                     color: Colors.white,
//                     size: 18,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 const Text(
//                   'HiveQ',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 16.0,
//               vertical: 8.0,
//             ),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search',
//                 prefixIcon: const Icon(FeatherIcons.search, size: 18),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//                 contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
//                 isDense: true,
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           MenuSection(
//             title: 'Main Menu',
//             items: mainMenuItems,
//             onItemTap: onNavigate,
//           ),
//           const Divider(height: 32),
//           MenuSection(
//             title: 'Main Menu',
//             items: secondaryMenuItems,
//             onItemTap: (_) {},
//           ),
//           const Divider(height: 32),
//           ProjectList(projects: projects),
//           const Spacer(),
//           const Divider(height: 1),
//           ListTile(
//             leading: CircleAvatar(
//               backgroundColor: AppColors.primary,
//               child: const Text('WP', style: TextStyle(color: Colors.white)),
//             ),
//             title: const Text(
//               'Wolf Pixel',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             subtitle: const Text('Workspace'),
//             trailing: const Icon(FeatherIcons.moreVertical, size: 18),
//           ),
//         ],
//       ),
//     );
//   }
// }

//=================================

// import 'package:flutter/material.dart';
// import 'package:feather_icons/feather_icons.dart';
// import '../../constants/app_colors.dart';
// import '../../models/menu_item.dart';
// import '../../models/project.dart';
// import 'menu_section.dart';
// import 'project_list.dart';

// class Sidebar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onNavigate;

//   const Sidebar({
//     super.key,
//     required this.selectedIndex,
//     required this.onNavigate,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final mainMenuItems = [
//       MenuItem(
//         title: 'Dashboard',
//         icon: FeatherIcons.layout,
//         isSelected: selectedIndex == 0,
//       ),
//       MenuItem(
//         title: 'Tasks',
//         icon: FeatherIcons.checkSquare,
//         isSelected: selectedIndex == 1,
//       ),
//       MenuItem(
//         title: 'Notes',
//         icon: FeatherIcons.fileText,
//         isSelected: selectedIndex == 2,
//       ),
//       MenuItem(title: 'Email', icon: FeatherIcons.mail, isSelected: false),
//       MenuItem(
//         title: 'Calendar',
//         icon: FeatherIcons.calendar,
//         isSelected: false,
//       ),
//     ];

//     final businessItems = [
//       MenuItem(
//         title: 'Accounting',
//         icon: FeatherIcons.dollarSign,
//         isSelected: selectedIndex == 3,
//       ),
//       MenuItem(
//         title: 'POS',
//         icon: FeatherIcons.shoppingCart,
//         isSelected: selectedIndex == 4,
//       ),
//       MenuItem(
//         title: 'Purchase',
//         icon: FeatherIcons.shoppingBag,
//         isSelected: selectedIndex == 5,
//       ),
//       MenuItem(
//         title: 'Inventory Sales',
//         icon: FeatherIcons.package,
//         isSelected: selectedIndex == 6,
//       ),
//     ];

//     final secondaryMenuItems = [
//       MenuItem(title: 'Reports', icon: FeatherIcons.barChart2),
//       MenuItem(title: 'Contacts', icon: FeatherIcons.users),
//       MenuItem(title: 'Invite Team', icon: FeatherIcons.userPlus),
//     ];

//     final projects = [
//       Project(name: 'Figma Design System', dotColor: Colors.red),
//       Project(name: 'Keep React', dotColor: Colors.cyan),
//       Project(name: 'Static Mania', dotColor: Colors.blue),
//     ];

//     return Container(
//       width: 240,
//       color: AppColors.sidebar,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: AppColors.primary,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Icon(
//                     FeatherIcons.hexagon,
//                     color: Colors.white,
//                     size: 18,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 const Text(
//                   'HiveQ',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 16.0,
//               vertical: 8.0,
//             ),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search',
//                 prefixIcon: const Icon(FeatherIcons.search, size: 18),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//                 contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
//                 isDense: true,
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   MenuSection(
//                     title: 'Main Menu',
//                     items: mainMenuItems,
//                     onItemTap: onNavigate,
//                   ),
//                   const Divider(height: 32),
//                   MenuSection(
//                     title: 'Business',
//                     items: businessItems,
//                     onItemTap: (index) {
//                       // Add 3 because business items start after the main menu items (0, 1, 2)
//                       onNavigate(index + 3);
//                     },
//                   ),
//                   const Divider(height: 32),
//                   MenuSection(
//                     title: 'Tools',
//                     items: secondaryMenuItems,
//                     onItemTap: (_) {},
//                   ),
//                   const Divider(height: 32),
//                   ProjectList(projects: projects),
//                 ],
//               ),
//             ),
//           ),
//           const Divider(height: 1),
//           ListTile(
//             leading: CircleAvatar(
//               backgroundColor: AppColors.primary,
//               child: const Text('WP', style: TextStyle(color: Colors.white)),
//             ),
//             title: const Text(
//               'Wolf Pixel',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             subtitle: const Text('Workspace'),
//             trailing: const Icon(FeatherIcons.moreVertical, size: 18),
//           ),
//         ],
//       ),
//     );
//   }
// }

//========================
import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import '../../constants/app_colors.dart';
import '../../models/menu_item.dart';
import '../../models/project.dart';
import 'menu_section.dart';
import 'project_list.dart';

class Sidebar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onNavigate;
  final bool isCollapsed;
  final VoidCallback onToggleCollapse;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onNavigate,
    required this.isCollapsed,
    required this.onToggleCollapse,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _setupAnimations();

    if (widget.isCollapsed) {
      _animationController.value = 1.0;
    } else {
      _animationController.value = 0.0;
    }
  }

  void _setupAnimations() {
    _widthAnimation = Tween<double>(begin: 240, end: 80).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOutCubic),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(-0.2, 0)).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
          ),
        );
  }

  @override
  void didUpdateWidget(Sidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCollapsed != oldWidget.isCollapsed) {
      if (widget.isCollapsed) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainMenuItems = [
      MenuItem(
        title: 'Dashboard',
        icon: FeatherIcons.layout,
        isSelected: widget.selectedIndex == 0,
      ),
      MenuItem(
        title: 'Tasks',
        icon: FeatherIcons.checkSquare,
        isSelected: widget.selectedIndex == 1,
      ),
      MenuItem(
        title: 'Notes',
        icon: FeatherIcons.fileText,
        isSelected: widget.selectedIndex == 2,
      ),
      MenuItem(title: 'Email', icon: FeatherIcons.mail, isSelected: false),
      MenuItem(
        title: 'Calendar',
        icon: FeatherIcons.calendar,
        isSelected: false,
      ),
    ];

    final businessItems = [
      MenuItem(
        title: 'Accounting',
        icon: FeatherIcons.dollarSign,
        isSelected: widget.selectedIndex == 3,
      ),
      MenuItem(
        title: 'POS',
        icon: FeatherIcons.shoppingCart,
        isSelected: widget.selectedIndex == 4,
      ),
      MenuItem(
        title: 'Purchase',
        icon: FeatherIcons.shoppingBag,
        isSelected: widget.selectedIndex == 5,
      ),
      MenuItem(
        title: 'Inventory Sales',
        icon: FeatherIcons.package,
        isSelected: widget.selectedIndex == 6,
      ),
    ];

    final secondaryMenuItems = [
      MenuItem(title: 'Reports', icon: FeatherIcons.barChart2),
      MenuItem(title: 'Contacts', icon: FeatherIcons.users),
      MenuItem(title: 'Invite Team', icon: FeatherIcons.userPlus),
    ];

    final projects = [
      Project(name: 'Figma Design System', dotColor: Colors.red),
      Project(name: 'Keep React', dotColor: Colors.cyan),
      Project(name: 'Static Mania', dotColor: Colors.blue),
    ];

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: _widthAnimation.value,
          color: AppColors.sidebar,
          child: Column(
            children: [
              // Logo and collapse button row
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _widthAnimation.value <= 120 ? 12.0 : 16.0,
                  vertical: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: _widthAnimation.value <= 120
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo with animation
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                            );
                          },
                      child: _widthAnimation.value <= 120
                          ? Container(
                              key: const ValueKey('logo-collapsed'),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                FeatherIcons.hexagon,
                                color: Colors.white,
                                size: 18,
                              ),
                            )
                          : Row(
                              key: const ValueKey('logo-expanded'),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    FeatherIcons.hexagon,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SlideTransition(
                                  position: _slideAnimation,
                                  child: FadeTransition(
                                    opacity: _fadeAnimation,
                                    child: const Text(
                                      'HiveQ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),

                    // Collapse/expand button with smooth rotation
                    Transform.translate(
                      offset: Offset(_widthAnimation.value <= 120 ? 0 : 0, 0),
                      child: IconButton(
                        onPressed: widget.onToggleCollapse,
                        icon: TweenAnimationBuilder<double>(
                          tween: Tween<double>(
                            begin: widget.isCollapsed ? 0.5 : 0,
                            end: widget.isCollapsed ? 0.5 : 0,
                          ),
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOutCubic,
                          builder: (context, value, child) {
                            return Transform.rotate(
                              angle: value * 3.14159,
                              child: Icon(FeatherIcons.chevronLeft, size: 18),
                            );
                          },
                        ),
                        tooltip: widget.isCollapsed ? 'Expand' : 'Collapse',
                        padding: EdgeInsets.zero,
                        iconSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              // Search field with fade and slide
              if (_widthAnimation.value > 120)
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(FeatherIcons.search, size: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ),

              // Search icon - only when collapsed
              if (_widthAnimation.value <= 120)
                FadeTransition(
                  opacity: ReverseAnimation(_fadeAnimation),
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.5,
                          1.0,
                          curve: Curves.elasticOut,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: IconButton(
                        icon: const Icon(FeatherIcons.search, size: 18),
                        onPressed: () {},
                        tooltip: 'Search',
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 8),

              // Menu items
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MenuSection(
                        title: 'Main Menu',
                        items: mainMenuItems,
                        onItemTap: widget.onNavigate,
                        isCollapsed: _widthAnimation.value <= 120,
                        animationController: _animationController,
                      ),
                      const Divider(height: 32),
                      MenuSection(
                        title: 'Business',
                        items: businessItems,
                        onItemTap: (index) {
                          widget.onNavigate(index + 3);
                        },
                        isCollapsed: _widthAnimation.value <= 120,
                        animationController: _animationController,
                      ),
                      const Divider(height: 32),
                      MenuSection(
                        title: 'Tools',
                        items: secondaryMenuItems,
                        onItemTap: (_) {},
                        isCollapsed: _widthAnimation.value <= 120,
                        animationController: _animationController,
                      ),

                      // Projects section - fade out when collapsing
                      if (_widthAnimation.value > 120) ...[
                        const Divider(height: 32),
                        SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: ProjectList(projects: projects),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // User profile section with fluid transition
              const Divider(height: 1),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      axis: Axis.horizontal,
                      child: child,
                    ),
                  );
                },
                child: _widthAnimation.value <= 120
                    ? Padding(
                        key: const ValueKey('user-collapsed'),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          radius: 18,
                          child: const Text(
                            'WP',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      )
                    : ListTile(
                        key: const ValueKey('user-expanded'),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: const Text(
                            'WP',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: FadeTransition(
                          opacity: _fadeAnimation,
                          child: const Text(
                            'Wolf Pixel',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        subtitle: FadeTransition(
                          opacity: _fadeAnimation,
                          child: const Text('Workspace'),
                        ),
                        trailing: FadeTransition(
                          opacity: _fadeAnimation,
                          child: const Icon(
                            FeatherIcons.moreVertical,
                            size: 18,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

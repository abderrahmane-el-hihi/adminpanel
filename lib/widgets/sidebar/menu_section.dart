// import 'package:flutter/material.dart';
// import '../../models/menu_item.dart';

// class MenuSection extends StatelessWidget {
//   final String title;
//   final List<MenuItem> items;

//   const MenuSection({super.key, required this.title, required this.items});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             title,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         ...items.map((item) => _buildMenuItem(item)).toList(),
//       ],
//     );
//   }

//   Widget _buildMenuItem(MenuItem item) {
//     return ListTile(
//       selected: item.isSelected,
//       selectedTileColor: Colors.grey[100],
//       leading: Icon(
//         item.icon,
//         color: item.isSelected ? Colors.black : Colors.grey[600],
//         size: 20,
//       ),
//       title: Text(
//         item.title,
//         style: TextStyle(
//           fontSize: 14,
//           fontWeight: item.isSelected ? FontWeight.w600 : FontWeight.normal,
//           color: item.isSelected ? Colors.black : Colors.grey[800],
//         ),
//       ),
//       dense: true,
//       visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
//     );
//   }
// }

//==========================
// import 'package:flutter/material.dart';
// import '../../models/menu_item.dart';

// class MenuSection extends StatelessWidget {
//   final String title;
//   final List<MenuItem> items;
//   final Function(int)? onItemTap;

//   const MenuSection({
//     super.key,
//     required this.title,
//     required this.items,
//     this.onItemTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             title,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         ...items.asMap().entries.map((entry) {
//           final index = entry.key;
//           final item = entry.value;
//           return _buildMenuItem(item, index);
//         }).toList(),
//       ],
//     );
//   }

//   Widget _buildMenuItem(MenuItem item, int index) {
//     return InkWell(
//       onTap: onItemTap != null ? () => onItemTap!(index) : null,
//       child: ListTile(
//         selected: item.isSelected,
//         selectedTileColor: Colors.grey[100],
//         leading: Icon(
//           item.icon,
//           color: item.isSelected ? Colors.black : Colors.grey[600],
//           size: 18,
//         ),
//         title: Text(
//           item.title,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: item.isSelected ? FontWeight.w600 : FontWeight.normal,
//             color: item.isSelected ? Colors.black : Colors.grey[800],
//           ),
//         ),
//         dense: true,
//         visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
//       ),
//     );
//   }
// }

//=====================================

// import 'package:flutter/material.dart';
// import '../../models/menu_item.dart';
// import '../../constants/app_colors.dart';

// class MenuSection extends StatelessWidget {
//   final String title;
//   final List<MenuItem> items;
//   final Function(int)? onItemTap;

//   const MenuSection({
//     super.key,
//     required this.title,
//     required this.items,
//     this.onItemTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             title,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         ...items.asMap().entries.map((entry) {
//           final index = entry.key;
//           final item = entry.value;
//           return MenuItemWidget(item: item, index: index, onTap: onItemTap);
//         }).toList(),
//       ],
//     );
//   }
// }

// class MenuItemWidget extends StatefulWidget {
//   final MenuItem item;
//   final int index;
//   final Function(int)? onTap;

//   const MenuItemWidget({
//     super.key,
//     required this.item,
//     required this.index,
//     this.onTap,
//   });

//   @override
//   State<MenuItemWidget> createState() => _MenuItemWidgetState();
// }

// class _MenuItemWidgetState extends State<MenuItemWidget>
//     with SingleTickerProviderStateMixin {
//   bool isHovering = false;
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _slideAnimation;
//   late Animation<Color?> _colorAnimation;
//   late Animation<Color?> _iconColorAnimation;
//   late Animation<Color?> _textColorAnimation;
//   late Animation<double> _leftBorderAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 350),
//     );

//     _setupAnimations();

//     if (widget.item.isSelected) {
//       _controller.value = 1.0;
//     }
//   }

//   @override
//   void didUpdateWidget(MenuItemWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     if (widget.item.isSelected != oldWidget.item.isSelected) {
//       if (widget.item.isSelected) {
//         _controller.forward();
//       } else {
//         _controller.reverse();
//       }
//     }
//   }

//   void _setupAnimations() {
//     final CurvedAnimation curve = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOutCubic,
//     );

//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(curve);
//     _slideAnimation = Tween<double>(begin: 0, end: 4).animate(curve);
//     _leftBorderAnimation = Tween<double>(begin: 0, end: 4).animate(curve);

//     _colorAnimation = ColorTween(
//       begin: Colors.transparent,
//       end: AppColors.primary.withOpacity(0.1),
//     ).animate(curve);

//     _iconColorAnimation = ColorTween(
//       begin: Colors.grey[600],
//       end: AppColors.primary,
//     ).animate(curve);

//     _textColorAnimation = ColorTween(
//       begin: Colors.grey[800],
//       end: AppColors.primary,
//     ).animate(curve);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => isHovering = true),
//       onExit: (_) => setState(() => isHovering = false),
//       cursor: SystemMouseCursors.click,
//       child: GestureDetector(
//         onTap: widget.onTap != null ? () => widget.onTap!(widget.index) : null,
//         child: AnimatedBuilder(
//           animation: _controller,
//           builder: (context, child) {
//             // Determine colors based on animation and hover state
//             final backgroundColor = widget.item.isSelected
//                 ? _colorAnimation.value
//                 : isHovering
//                 ? Colors.grey.withOpacity(0.1)
//                 : Colors.transparent;

//             final iconColor = widget.item.isSelected
//                 ? _iconColorAnimation.value
//                 : isHovering
//                 ? AppColors.primary.withOpacity(0.8)
//                 : Colors.grey[600];

//             final textColor = widget.item.isSelected
//                 ? _textColorAnimation.value
//                 : isHovering
//                 ? Colors.black87
//                 : Colors.grey[800];

//             final fontWeight = widget.item.isSelected || isHovering
//                 ? FontWeight.w600
//                 : FontWeight.normal;

//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 curve: Curves.easeOutCubic,
//                 height: 42,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   color: backgroundColor,
//                   boxShadow: widget.item.isSelected
//                       ? [
//                           BoxShadow(
//                             color: AppColors.primary.withOpacity(0.1),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ]
//                       : null,
//                 ),
//                 child: Row(
//                   children: [
//                     // Left accent border for selected item with fluid animation
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 350),
//                       curve: Curves.easeOutCubic,
//                       width: _leftBorderAnimation.value,
//                       height: 42,
//                       decoration: BoxDecoration(
//                         color: widget.item.isSelected
//                             ? AppColors.primary
//                             : Colors.transparent,
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(8),
//                           bottomLeft: Radius.circular(8),
//                         ),
//                       ),
//                     ),

//                     // Animated Icon Transform
//                     Transform.translate(
//                       offset: Offset(_slideAnimation.value, 0),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         child: Transform.scale(
//                           scale: isHovering
//                               ? _scaleAnimation.value
//                               : widget.item.isSelected
//                               ? 1.05
//                               : 1.0,
//                           child: Icon(
//                             widget.item.icon,
//                             color: iconColor,
//                             size: 18,
//                           ),
//                         ),
//                       ),
//                     ),

//                     // Text with fluid animation
//                     AnimatedDefaultTextStyle(
//                       duration: const Duration(milliseconds: 250),
//                       curve: Curves.easeOutCubic,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: fontWeight,
//                         color: textColor,
//                       ),
//                       child: Text(widget.item.title),
//                     ),

//                     // Animated indicator dot for active item
//                     if (widget.item.isSelected) ...[
//                       const Spacer(),
//                       AnimatedContainer(
//                         duration: const Duration(milliseconds: 450),
//                         curve: Curves.elasticOut,
//                         width: 6,
//                         height: 6,
//                         margin: const EdgeInsets.only(right: 12),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

//-===============================
import 'package:flutter/material.dart';
import '../../models/menu_item.dart';
import '../../constants/app_colors.dart';

class MenuSection extends StatelessWidget {
  final String title;
  final List<MenuItem> items;
  final Function(int)? onItemTap;
  final bool isCollapsed;
  final AnimationController? animationController;

  const MenuSection({
    super.key,
    required this.title,
    required this.items,
    this.onItemTap,
    this.isCollapsed = false,
    this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    // Create fade animations for text elements
    final fadeTextAnimation = animationController != null
        ? Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: animationController!,
              curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
            ),
          )
        : null;

    // Create slide animations
    final slideAnimation = animationController != null
        ? Tween<Offset>(begin: Offset.zero, end: const Offset(-0.2, 0)).animate(
            CurvedAnimation(
              parent: animationController!,
              curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
            ),
          )
        : null;

    // Inverse fade for collapsed elements
    final inverseFadeAnimation = animationController != null
        ? Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController!,
              curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
            ),
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title with animation
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: isCollapsed
              ? Padding(
                  key: const ValueKey('collapsed-title'),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(color: Colors.grey[300], thickness: 0.5),
                )
              : Padding(
                  key: const ValueKey('expanded-title'),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: fadeTextAnimation != null && slideAnimation != null
                      ? SlideTransition(
                          position: slideAnimation,
                          child: FadeTransition(
                            opacity: fadeTextAnimation,
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Text(
                          title,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
        ),

        const SizedBox(height: 8),
        ...items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return MenuItemWidget(
            item: item,
            index: index,
            onTap: onItemTap,
            isCollapsed: isCollapsed,
            fadeTextAnimation: fadeTextAnimation,
            inverseFadeAnimation: inverseFadeAnimation,
            slideAnimation: slideAnimation,
          );
        }).toList(),
      ],
    );
  }
}

class MenuItemWidget extends StatefulWidget {
  final MenuItem item;
  final int index;
  final Function(int)? onTap;
  final bool isCollapsed;
  final Animation<double>? fadeTextAnimation;
  final Animation<double>? inverseFadeAnimation;
  final Animation<Offset>? slideAnimation;

  const MenuItemWidget({
    super.key,
    required this.item,
    required this.index,
    this.onTap,
    this.isCollapsed = false,
    this.fadeTextAnimation,
    this.inverseFadeAnimation,
    this.slideAnimation,
  });

  @override
  State<MenuItemWidget> createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget>
    with SingleTickerProviderStateMixin {
  bool isHovering = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _leftBorderAnimation;
  late Animation<Color?> _iconColorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _setupAnimations();

    if (widget.item.isSelected) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(MenuItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.item.isSelected != oldWidget.item.isSelected) {
      if (widget.item.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  void _setupAnimations() {
    final CurvedAnimation curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(curve);
    _leftBorderAnimation = Tween<double>(begin: 0, end: 4).animate(curve);

    _iconColorAnimation = ColorTween(
      begin: Colors.grey[600],
      end: AppColors.primary,
    ).animate(curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap != null ? () => widget.onTap!(widget.index) : null,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // Determine colors based on animation and hover state
            final backgroundColor = widget.item.isSelected
                ? AppColors.primary.withOpacity(0.1)
                : isHovering
                ? Colors.grey.withOpacity(0.1)
                : Colors.transparent;

            final iconColor = widget.item.isSelected
                ? _iconColorAnimation.value
                : isHovering
                ? AppColors.primary.withOpacity(0.8)
                : Colors.grey[600];

            final textColor = widget.item.isSelected
                ? AppColors.primary
                : isHovering
                ? Colors.black87
                : Colors.grey[800];

            final fontWeight = widget.item.isSelected || isHovering
                ? FontWeight.w600
                : FontWeight.normal;

            // For collapsed sidebar, create a simplified version
            if (widget.isCollapsed) {
              return Tooltip(
                message: widget.item.title,
                preferBelow: false,
                verticalOffset: 20,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  margin: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 4.0,
                  ),
                  width: 72,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: backgroundColor,
                    boxShadow: widget.item.isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: FadeTransition(
                    opacity:
                        widget.inverseFadeAnimation ??
                        const AlwaysStoppedAnimation(1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon with hover effect
                        Icon(widget.item.icon, color: iconColor, size: 18),

                        // Small indicator dot for selected items
                        if (widget.item.isSelected)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 450),
                            curve: Curves.elasticOut,
                            width: 4,
                            height: 4,
                            margin: const EdgeInsets.only(top: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }

            // Original expanded version with fluid animations
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: backgroundColor,
                  boxShadow: widget.item.isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  children: [
                    // Left accent border for selected item with fluid animation
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeOutCubic,
                      width: _leftBorderAnimation.value,
                      height: 42,
                      decoration: BoxDecoration(
                        color: widget.item.isSelected
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                    ),

                    // Icon with animation
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Transform.scale(
                        scale: isHovering
                            ? _scaleAnimation.value
                            : widget.item.isSelected
                            ? 1.05
                            : 1.0,
                        child: Icon(
                          widget.item.icon,
                          color: iconColor,
                          size: 18,
                        ),
                      ),
                    ),

                    // Text with animation
                    if (widget.slideAnimation != null &&
                        widget.fadeTextAnimation != null)
                      SlideTransition(
                        position: widget.slideAnimation!,
                        child: FadeTransition(
                          opacity: widget.fadeTextAnimation!,
                          child: Text(
                            widget.item.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: fontWeight,
                              color: textColor,
                            ),
                          ),
                        ),
                      )
                    else
                      Text(
                        widget.item.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: fontWeight,
                          color: textColor,
                        ),
                      ),

                    // Animated indicator dot for active item
                    if (widget.item.isSelected) ...[
                      const Spacer(),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 450),
                        curve: Curves.elasticOut,
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

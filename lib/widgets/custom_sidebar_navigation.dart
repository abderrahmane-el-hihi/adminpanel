import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'dart:math';

/// Navigation item data structure for sidebar navigation
class SideNavItem {
  final String route;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String tooltip;

  const SideNavItem({
    required this.route,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.tooltip,
  });
}

/// Custom sidebar navigation optimized for web and desktop views
/// Provides professional navigation with expanded menu items and icons
class CustomSidebarNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final bool isExpanded;
  final VoidCallback? onToggleExpanded;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  // Hardcoded navigation items for business intelligence dashboards
  static const List<SideNavItem> _navItems = [
    SideNavItem(
      route: '/executive-overview-dashboard',
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      label: 'Executive Overview',
      tooltip: 'Executive Overview Dashboard',
    ),
    SideNavItem(
      route: '/hr-management-dashboard',
      icon: Icons.people_outline,
      activeIcon: Icons.people,
      label: 'HR Management',
      tooltip: 'HR Management Dashboard',
    ),
    SideNavItem(
      route: '/sales-performance-dashboard',
      icon: Icons.trending_up_outlined,
      activeIcon: Icons.trending_up,
      label: 'Sales Performance',
      tooltip: 'Sales Performance Dashboard',
    ),
    SideNavItem(
      route: '/operations-monitoring-dashboard',
      icon: Icons.monitor_heart_outlined,
      activeIcon: Icons.monitor_heart,
      label: 'Operations Monitoring',
      tooltip: 'Operations Monitoring Dashboard',
    ),
  ];

  const CustomSidebarNavigation({
    super.key,
    required this.currentIndex,
    this.onTap,
    this.isExpanded = true,
    this.onToggleExpanded,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Responsive width based on screen size
    double sidebarWidth;
    if (kIsWeb || 100.w > 1200) {
      sidebarWidth = isExpanded ? 280 : 80;
    } else {
      sidebarWidth = isExpanded ? min(240, 30.w) : 70;
    }

    return Container(
      width: sidebarWidth,
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            offset: const Offset(2, 0),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
        border: Border(
          right: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Header with app branding
          Container(
            height: kIsWeb ? 80 : 70,
            padding: EdgeInsets.symmetric(
                horizontal: isExpanded ? 24 : 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: colorScheme.outline.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [colorScheme.primary, colorScheme.secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.analytics_rounded,
                    color: colorScheme.onPrimary,
                    size: 24,
                  ),
                ),
                if (isExpanded) ...[
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'HiveQ Mobile',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
                if (onToggleExpanded != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: onToggleExpanded,
                    icon: Icon(
                      isExpanded ? Icons.chevron_left : Icons.chevron_right,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    iconSize: 20,
                  ),
                ],
              ],
            ),
          ),

          // Navigation items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: List.generate(_navItems.length, (index) {
                  final item = _navItems[index];
                  final isSelected = index == currentIndex;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isExpanded ? 16 : 12,
                      vertical: 4,
                    ),
                    child: _SideNavButton(
                      item: item,
                      isSelected: isSelected,
                      isExpanded: isExpanded,
                      selectedColor: selectedItemColor ?? colorScheme.primary,
                      unselectedColor:
                          unselectedItemColor ?? colorScheme.onSurfaceVariant,
                      onTap: () => _handleNavigation(context, index),
                    ),
                  );
                }),
              ),
            ),
          ),

          // Footer with user profile (if expanded)
          if (isExpanded)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Text(
                      'U',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Admin User',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          'admin@hiveq.com',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    if (index != currentIndex) {
      onTap?.call(index);
      Navigator.pushNamed(context, _navItems[index].route);
    }
  }
}

/// Individual sidebar navigation button with hover animations
class _SideNavButton extends StatefulWidget {
  final SideNavItem item;
  final bool isSelected;
  final bool isExpanded;
  final Color selectedColor;
  final Color unselectedColor;
  final VoidCallback onTap;

  const _SideNavButton({
    required this.item,
    required this.isSelected,
    required this.isExpanded,
    required this.selectedColor,
    required this.unselectedColor,
    required this.onTap,
  });

  @override
  State<_SideNavButton> createState() => _SideNavButtonState();
}

class _SideNavButtonState extends State<_SideNavButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _hoverAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _hoverAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: AnimatedBuilder(
        animation: _hoverAnimation,
        builder: (context, child) {
          return GestureDetector(
            onTap: widget.onTap,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? widget.selectedColor.withValues(alpha: 0.15)
                    : _isHovered
                        ? colorScheme.onSurface.withValues(alpha: 0.05)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: widget.isSelected
                    ? Border.all(
                        color: widget.selectedColor.withValues(alpha: 0.3),
                        width: 1,
                      )
                    : null,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isExpanded ? 16 : 12,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Icon(
                      widget.isSelected
                          ? widget.item.activeIcon
                          : widget.item.icon,
                      size: 24,
                      color: widget.isSelected
                          ? widget.selectedColor
                          : widget.unselectedColor,
                    ),
                    if (widget.isExpanded) ...[
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          widget.item.label,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: widget.isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: widget.isSelected
                                ? widget.selectedColor
                                : widget.unselectedColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered && !widget.isSelected) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}
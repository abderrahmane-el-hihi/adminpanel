import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Navigation item data structure for bottom navigation
class BottomNavItem {
  final String route;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String tooltip;

  const BottomNavItem({
    required this.route,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.tooltip,
  });
}

/// Custom bottom navigation bar optimized for business intelligence dashboards
/// Provides gesture-based navigation between dashboard modules with thumb-friendly interactions
class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final bool showLabels;
  final double elevation;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  // Hardcoded navigation items for business intelligence dashboards
  static const List<BottomNavItem> _navItems = [
    BottomNavItem(
      route: '/executive-overview-dashboard',
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      label: 'Overview',
      tooltip: 'Executive Overview Dashboard',
    ),
    BottomNavItem(
      route: '/hr-management-dashboard',
      icon: Icons.people_outline,
      activeIcon: Icons.people,
      label: 'HR',
      tooltip: 'HR Management Dashboard',
    ),
    BottomNavItem(
      route: '/sales-performance-dashboard',
      icon: Icons.trending_up_outlined,
      activeIcon: Icons.trending_up,
      label: 'Sales',
      tooltip: 'Sales Performance Dashboard',
    ),
    BottomNavItem(
      route: '/operations-monitoring-dashboard',
      icon: Icons.monitor_heart_outlined,
      activeIcon: Icons.monitor_heart,
      label: 'Operations',
      tooltip: 'Operations Monitoring Dashboard',
    ),
  ];

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    this.onTap,
    this.showLabels = true,
    this.elevation = 8.0,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color:
            backgroundColor ?? theme.bottomNavigationBarTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.15),
            offset: const Offset(0, -2),
            blurRadius: elevation,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: showLabels ? 80 : 60,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_navItems.length, (index) {
              final item = _navItems[index];
              final isSelected = index == currentIndex;

              return Expanded(
                child: _BottomNavButton(
                  item: item,
                  isSelected: isSelected,
                  showLabel: showLabels,
                  selectedColor: selectedItemColor ??
                      theme.bottomNavigationBarTheme.selectedItemColor,
                  unselectedColor: unselectedItemColor ??
                      theme.bottomNavigationBarTheme.unselectedItemColor,
                  onTap: () => _handleNavigation(context, index),
                ),
              );
            }),
          ),
        ),
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

/// Individual bottom navigation button with smooth animations
class _BottomNavButton extends StatefulWidget {
  final BottomNavItem item;
  final bool isSelected;
  final bool showLabel;
  final Color? selectedColor;
  final Color? unselectedColor;
  final VoidCallback onTap;

  const _BottomNavButton({
    required this.item,
    required this.isSelected,
    required this.showLabel,
    required this.selectedColor,
    required this.unselectedColor,
    required this.onTap,
  });

  @override
  State<_BottomNavButton> createState() => _BottomNavButtonState();
}

class _BottomNavButtonState extends State<_BottomNavButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _fadeAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.isSelected) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(_BottomNavButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with selection animation
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: widget.isSelected
                        ? BoxDecoration(
                            color: (widget.selectedColor ?? colorScheme.primary)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
                    child: Icon(
                      widget.isSelected
                          ? widget.item.activeIcon
                          : widget.item.icon,
                      size: 24,
                      color: widget.isSelected
                          ? widget.selectedColor ?? colorScheme.primary
                          : widget.unselectedColor ??
                              colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                );
              },
            ),
            // Label with fade animation
            if (widget.showLabel) ...[
              const SizedBox(height: 4),
              AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: widget.isSelected ? 1.0 : _fadeAnimation.value,
                    child: Text(
                      widget.item.label,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: widget.isSelected
                            ? FontWeight.w500
                            : FontWeight.w400,
                        color: widget.isSelected
                            ? widget.selectedColor ?? colorScheme.primary
                            : widget.unselectedColor ??
                                colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Floating variant of bottom navigation for contextual actions
class CustomFloatingBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final EdgeInsets margin;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  const CustomFloatingBottomBar({
    super.key,
    required this.currentIndex,
    this.onTap,
    this.margin = const EdgeInsets.all(16),
    this.borderRadius = 24,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.15),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(CustomBottomBar._navItems.length, (index) {
              final item = CustomBottomBar._navItems[index];
              final isSelected = index == currentIndex;

              return Expanded(
                child: GestureDetector(
                  onTap: () => _handleNavigation(context, index),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: isSelected
                        ? BoxDecoration(
                            color: (selectedItemColor ?? colorScheme.primary)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          )
                        : null,
                    child: Icon(
                      isSelected ? item.activeIcon : item.icon,
                      size: 24,
                      color: isSelected
                          ? selectedItemColor ?? colorScheme.primary
                          : unselectedItemColor ??
                              colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    if (index != currentIndex) {
      onTap?.call(index);
      Navigator.pushNamed(context, CustomBottomBar._navItems[index].route);
    }
  }
}

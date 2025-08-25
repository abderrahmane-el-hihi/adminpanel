import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tab item data structure for custom tab navigation
class TabItem {
  final String route;
  final String label;
  final IconData? icon;
  final String? tooltip;
  final Widget? badge;

  const TabItem({
    required this.route,
    required this.label,
    this.icon,
    this.tooltip,
    this.badge,
  });
}

/// Custom tab bar widget optimized for dashboard module navigation
/// Provides smooth transitions and professional appearance for business intelligence
class CustomTabBar extends StatefulWidget {
  final List<TabItem> tabs;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final bool isScrollable;
  final TabAlignment tabAlignment;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? indicatorColor;
  final double indicatorWeight;
  final EdgeInsets padding;
  final double height;

  // Default dashboard tabs for business intelligence
  static const List<TabItem> defaultDashboardTabs = [
    TabItem(
      route: '/executive-overview-dashboard',
      label: 'Overview',
      icon: Icons.dashboard_outlined,
      tooltip: 'Executive Overview Dashboard',
    ),
    TabItem(
      route: '/hr-management-dashboard',
      label: 'HR Management',
      icon: Icons.people_outline,
      tooltip: 'Human Resources Dashboard',
    ),
    TabItem(
      route: '/sales-performance-dashboard',
      label: 'Sales',
      icon: Icons.trending_up_outlined,
      tooltip: 'Sales Performance Analytics',
    ),
    TabItem(
      route: '/operations-monitoring-dashboard',
      label: 'Operations',
      icon: Icons.monitor_heart_outlined,
      tooltip: 'Operations Monitoring Dashboard',
    ),
  ];

  const CustomTabBar({
    super.key,
    this.tabs = defaultDashboardTabs,
    required this.currentIndex,
    this.onTap,
    this.isScrollable = true,
    this.tabAlignment = TabAlignment.start,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.indicatorColor,
    this.indicatorWeight = 3.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.height = 56,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.currentIndex,
    );
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _tabController.addListener(_handleTabChange);
  }

  @override
  void didUpdateWidget(CustomTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      _tabController.animateTo(widget.currentIndex);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      widget.onTap?.call(_tabController.index);
      _navigateToTab(_tabController.index);
    }
  }

  void _navigateToTab(int index) {
    if (index >= 0 && index < widget.tabs.length) {
      Navigator.pushNamed(context, widget.tabs[index].route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: widget.height,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        tabs: widget.tabs.map((tab) => _buildTab(context, tab)).toList(),
        isScrollable: widget.isScrollable,
        tabAlignment: widget.tabAlignment,
        labelColor: widget.selectedColor ?? colorScheme.primary,
        unselectedLabelColor: widget.unselectedColor ??
            colorScheme.onSurface.withValues(alpha: 0.6),
        indicatorColor: widget.indicatorColor ?? colorScheme.primary,
        indicatorWeight: widget.indicatorWeight,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.1,
        ),
        overlayColor: WidgetStateProperty.all(
          colorScheme.primary.withValues(alpha: 0.1),
        ),
        splashFactory: InkRipple.splashFactory,
        dividerColor: Colors.transparent,
      ),
    );
  }

  Widget _buildTab(BuildContext context, TabItem tab) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (tab.icon != null) ...[
            Icon(tab.icon, size: 20),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              tab.label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          if (tab.badge != null) ...[
            const SizedBox(width: 4),
            tab.badge!,
          ],
        ],
      ),
    );
  }
}

/// Segmented control variant for compact tab navigation
class CustomSegmentedTabBar extends StatelessWidget {
  final List<TabItem> tabs;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final EdgeInsets margin;
  final double borderRadius;
  final double height;

  const CustomSegmentedTabBar({
    super.key,
    this.tabs = CustomTabBar.defaultDashboardTabs,
    required this.currentIndex,
    this.onTap,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.margin = const EdgeInsets.all(16),
    this.borderRadius = 12,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: margin,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final tab = tabs[index];
          final isSelected = index == currentIndex;
          final isFirst = index == 0;
          final isLast = index == tabs.length - 1;

          return Expanded(
            child: GestureDetector(
              onTap: () => _handleTap(context, index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected
                      ? selectedColor ?? colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.horizontal(
                    left: isFirst
                        ? Radius.circular(borderRadius - 1)
                        : Radius.zero,
                    right: isLast
                        ? Radius.circular(borderRadius - 1)
                        : Radius.zero,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (tab.icon != null) ...[
                        Icon(
                          tab.icon,
                          size: 18,
                          color: isSelected
                              ? colorScheme.onPrimary
                              : unselectedColor ??
                                  colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                        const SizedBox(width: 6),
                      ],
                      Flexible(
                        child: Text(
                          tab.label,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w500,
                            color: isSelected
                                ? colorScheme.onPrimary
                                : unselectedColor ??
                                    colorScheme.onSurface
                                        .withValues(alpha: 0.7),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      if (tab.badge != null) ...[
                        const SizedBox(width: 4),
                        tab.badge!,
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _handleTap(BuildContext context, int index) {
    if (index != currentIndex) {
      onTap?.call(index);
      Navigator.pushNamed(context, tabs[index].route);
    }
  }
}

/// Pill-style tab bar for modern dashboard navigation
class CustomPillTabBar extends StatelessWidget {
  final List<TabItem> tabs;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final EdgeInsets padding;
  final double spacing;
  final double height;

  const CustomPillTabBar({
    super.key,
    this.tabs = CustomTabBar.defaultDashboardTabs,
    required this.currentIndex,
    this.onTap,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.padding = const EdgeInsets.all(16),
    this.spacing = 8,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: padding,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(tabs.length, (index) {
            final tab = tabs[index];
            final isSelected = index == currentIndex;

            return Padding(
              padding:
                  EdgeInsets.only(right: index < tabs.length - 1 ? spacing : 0),
              child: GestureDetector(
                onTap: () => _handleTap(context, index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: height,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? selectedColor ?? colorScheme.primary
                        : backgroundColor ?? colorScheme.surface,
                    borderRadius: BorderRadius.circular(height / 2),
                    border: isSelected
                        ? null
                        : Border.all(
                            color: colorScheme.outline.withValues(alpha: 0.3),
                            width: 1,
                          ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: colorScheme.shadow.withValues(alpha: 0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (tab.icon != null) ...[
                        Icon(
                          tab.icon,
                          size: 16,
                          color: isSelected
                              ? colorScheme.onPrimary
                              : unselectedColor ??
                                  colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                        const SizedBox(width: 6),
                      ],
                      Text(
                        tab.label,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? colorScheme.onPrimary
                              : unselectedColor ??
                                  colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                      if (tab.badge != null) ...[
                        const SizedBox(width: 4),
                        tab.badge!,
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void _handleTap(BuildContext context, int index) {
    if (index != currentIndex) {
      onTap?.call(index);
      Navigator.pushNamed(context, tabs[index].route);
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import './custom_bottom_bar.dart';
import './custom_sidebar_navigation.dart';

/// Responsive layout wrapper that switches between sidebar and bottom navigation
/// based on screen size and platform
class ResponsiveLayoutWrapper extends StatefulWidget {
  final Widget body;
  final int currentIndex;
  final ValueChanged<int>? onNavigationTap;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final String title;

  const ResponsiveLayoutWrapper({
    super.key,
    required this.body,
    required this.currentIndex,
    this.onNavigationTap,
    this.appBar,
    this.floatingActionButton,
    this.title = 'Dashboard',
  });

  @override
  State<ResponsiveLayoutWrapper> createState() =>
      _ResponsiveLayoutWrapperState();
}

class _ResponsiveLayoutWrapperState extends State<ResponsiveLayoutWrapper> {
  bool _isSidebarExpanded = true;

  // Responsive breakpoints
  bool get isMobile => 100.w < 600;
  bool get isTablet => 100.w >= 600 && 100.w < 1200;
  bool get isDesktop => 100.w >= 1200;
  bool get isWeb => kIsWeb;

  // Navigation layout decision
  bool get shouldUseSidebar => (isWeb && 100.w > 900) || isDesktop;
  bool get shouldUseBottomNav => isMobile || (!isWeb && 100.w <= 900);

  @override
  Widget build(BuildContext context) {
    if (shouldUseSidebar) {
      return _buildSidebarLayout();
    } else {
      return _buildBottomNavLayout();
    }
  }

  Widget _buildSidebarLayout() {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Row(
        children: [
          // Sidebar Navigation
          CustomSidebarNavigation(
            currentIndex: widget.currentIndex,
            onTap: widget.onNavigationTap,
            isExpanded: _isSidebarExpanded,
            onToggleExpanded: () {
              setState(() {
                _isSidebarExpanded = !_isSidebarExpanded;
              });
            },
          ),

          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Custom App Bar for web
                if (widget.appBar != null || widget.title.isNotEmpty)
                  _buildWebAppBar(),

                // Body Content
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isDesktop ? 24.0 : 16.0),
                    child: widget.body,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }

  Widget _buildBottomNavLayout() {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: widget.appBar,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16.0 : 24.0,
            vertical: 16.0,
          ),
          child: widget.body,
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onNavigationTap,
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }

  Widget _buildWebAppBar() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          // Page Title
          Expanded(
            child: Text(
              widget.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Action Buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search Button
              IconButton(
                onPressed: () {
                  // Global search functionality
                },
                icon: Icon(
                  Icons.search,
                  color: colorScheme.onSurfaceVariant,
                ),
                tooltip: 'Search',
              ),

              // Notifications Button
              IconButton(
                onPressed: () {
                  // Notifications
                },
                icon: Badge(
                  smallSize: 8,
                  backgroundColor: colorScheme.error,
                  child: Icon(
                    Icons.notifications_outlined,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                tooltip: 'Notifications',
              ),

              // Settings Button
              IconButton(
                onPressed: () {
                  // Settings
                },
                icon: Icon(
                  Icons.settings_outlined,
                  color: colorScheme.onSurfaceVariant,
                ),
                tooltip: 'Settings',
              ),

              const SizedBox(width: 16),

              // User Avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: colorScheme.primaryContainer,
                child: Text(
                  'U',
                  style: TextStyle(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Extension to provide responsive utilities
extension ResponsiveExtensions on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 600;
  bool get isTablet =>
      MediaQuery.of(this).size.width >= 600 &&
      MediaQuery.of(this).size.width < 1200;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1200;
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  double get responsivePadding => isMobile
      ? 16.0
      : isTablet
          ? 24.0
          : 32.0;
  double get responsiveRadius => isMobile ? 8.0 : 12.0;
  double get responsiveSpacing => isMobile ? 16.0 : 24.0;
}

/// Responsive sizing utilities
class ResponsiveSize {
  static double width(BuildContext context, double mobileWidth,
      double tabletWidth, double desktopWidth) {
    if (context.isMobile) return mobileWidth;
    if (context.isTablet) return tabletWidth;
    return desktopWidth;
  }

  static double height(BuildContext context, double mobileHeight,
      double tabletHeight, double desktopHeight) {
    if (context.isMobile) return mobileHeight;
    if (context.isTablet) return tabletHeight;
    return desktopHeight;
  }

  static EdgeInsets padding(BuildContext context) {
    if (context.isMobile) {
      return const EdgeInsets.all(16.0);
    } else if (context.isTablet) {
      return const EdgeInsets.all(24.0);
    } else {
      return const EdgeInsets.all(32.0);
    }
  }

  static double fontSize(BuildContext context, double mobileFontSize,
      double tabletFontSize, double desktopFontSize) {
    if (context.isMobile) return mobileFontSize;
    if (context.isTablet) return tabletFontSize;
    return desktopFontSize;
  }
}

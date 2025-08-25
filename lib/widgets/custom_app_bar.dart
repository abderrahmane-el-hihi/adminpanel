import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom app bar widget optimized for business intelligence applications
/// Provides executive-level authority with contextual actions and offline indicators
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final bool isConnected;
  final VoidCallback? onBackPressed;
  final double elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.isConnected = true,
    this.onBackPressed,
    this.elevation = 2.0,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: foregroundColor ?? theme.appBarTheme.foregroundColor,
          letterSpacing: 0.15,
        ),
      ),
      backgroundColor: backgroundColor ?? theme.appBarTheme.backgroundColor,
      foregroundColor: foregroundColor ?? theme.appBarTheme.foregroundColor,
      elevation: elevation,
      shadowColor: theme.appBarTheme.shadowColor,
      surfaceTintColor: Colors.transparent,
      leading: leading ??
          (showBackButton && Navigator.canPop(context)
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  onPressed: onBackPressed ?? () => Navigator.pop(context),
                  tooltip: 'Back',
                )
              : null),
      actions: [
        // Offline indicator with subtle connectivity status
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: !isConnected
              ? Container(
                  key: const ValueKey('offline'),
                  margin: const EdgeInsets.only(right: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.colorScheme.error.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cloud_off_outlined,
                        size: 16,
                        color: theme.colorScheme.error,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Offline',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  key: const ValueKey('online'),
                  margin: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.cloud_done_outlined,
                    size: 20,
                    color: colorScheme.primary.withValues(alpha: 0.6),
                  ),
                ),
        ),
        // Custom actions
        if (actions != null) ...actions!,
        // Default menu action for dashboard navigation
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, size: 24),
          tooltip: 'More options',
          onSelected: (value) => _handleMenuSelection(context, value),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: '/executive-overview-dashboard',
              child: Row(
                children: [
                  Icon(
                    Icons.dashboard_outlined,
                    size: 20,
                    color: theme.colorScheme.onSurface,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Executive Overview',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: '/hr-management-dashboard',
              child: Row(
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 20,
                    color: theme.colorScheme.onSurface,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'HR Management',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: '/sales-performance-dashboard',
              child: Row(
                children: [
                  Icon(
                    Icons.trending_up_outlined,
                    size: 20,
                    color: theme.colorScheme.onSurface,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Sales Performance',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: '/operations-monitoring-dashboard',
              child: Row(
                children: [
                  Icon(
                    Icons.monitor_heart_outlined,
                    size: 20,
                    color: theme.colorScheme.onSurface,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Operations Monitoring',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 8,
        ),
      ],
    );
  }

  void _handleMenuSelection(BuildContext context, String route) {
    // Navigate to selected dashboard
    Navigator.pushNamed(context, route);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Variant of CustomAppBar with search functionality for data exploration
class CustomSearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String hintText;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchSubmitted;
  final bool isConnected;
  final List<Widget>? actions;

  const CustomSearchAppBar({
    super.key,
    required this.title,
    this.hintText = 'Search data...',
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.isConnected = true,
    this.actions,
  });

  @override
  State<CustomSearchAppBar> createState() => _CustomSearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomSearchAppBarState extends State<CustomSearchAppBar>
    with SingleTickerProviderStateMixin {
  bool _isSearching = false;
  late TextEditingController _searchController;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        _animationController.forward();
      } else {
        _animationController.reverse();
        _searchController.clear();
        widget.onSearchChanged?.call('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _isSearching
            ? TextField(
                key: const ValueKey('search'),
                controller: _searchController,
                autofocus: true,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: theme.appBarTheme.foregroundColor,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: theme.appBarTheme.foregroundColor
                        ?.withValues(alpha: 0.6),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: widget.onSearchChanged,
                onSubmitted: (_) => widget.onSearchSubmitted?.call(),
              )
            : Text(
                widget.title,
                key: const ValueKey('title'),
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.15,
                ),
              ),
      ),
      backgroundColor: theme.appBarTheme.backgroundColor,
      foregroundColor: theme.appBarTheme.foregroundColor,
      elevation: 2.0,
      surfaceTintColor: Colors.transparent,
      actions: [
        // Search toggle button
        IconButton(
          icon: AnimatedRotation(
            turns: _animation.value * 0.5,
            duration: Duration(milliseconds: 200),
            child: Icon(_isSearching ? Icons.close : Icons.search),
          ),
          onPressed: _toggleSearch,
          tooltip: _isSearching ? 'Close search' : 'Search',
        ),
        // Connectivity indicator
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: !widget.isConnected
              ? Container(
                  key: const ValueKey('offline'),
                  margin: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.cloud_off_outlined,
                    size: 20,
                    color: theme.colorScheme.error,
                  ),
                )
              : const SizedBox.shrink(),
        ),
        // Additional actions
        if (widget.actions != null) ...widget.actions!,
      ],
    );
  }
}
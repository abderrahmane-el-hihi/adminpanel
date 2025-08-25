import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/responsive_layout_wrapper.dart';
import './widgets/attendance_heatmap_widget.dart';
import './widgets/employee_performance_grid_widget.dart';
import './widgets/hr_global_controls_widget.dart';
import './widgets/hr_metrics_row_widget.dart';
import './widgets/pending_approvals_widget.dart';

class HrManagementDashboard extends StatefulWidget {
  const HrManagementDashboard({super.key});

  @override
  State<HrManagementDashboard> createState() => _HrManagementDashboardState();
}

class _HrManagementDashboardState extends State<HrManagementDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentNavIndex = 1; // HR Management Dashboard index
  String selectedEmployeeGroup = 'All Employees';
  String selectedPayPeriod = 'Current Month';
  String selectedLocation = 'All Locations';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleEmployeeGroupChange(String group) {
    setState(() {
      selectedEmployeeGroup = group;
    });
  }

  void _handlePayPeriodChange(String period) {
    setState(() {
      selectedPayPeriod = period;
    });
  }

  void _handleLocationChange(String location) {
    setState(() {
      selectedLocation = location;
    });
  }

  void _handleMetricTapped(String metricKey) {
    switch (metricKey) {
      case 'attendance':
        break;
      case 'leave_requests':
        break;
      case 'new_hires':
        break;
      case 'turnover':
        break;
    }
  }

  void _handleDateSelected(DateTime date) {
    // Handle attendance heatmap date selection
  }

  void _handleApprovalAction(Map<String, dynamic> approval, String action) {
    setState(() {
      // Update approval status
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          action == 'approve'
              ? 'Request approved successfully'
              : 'Request rejected',
        ),
        backgroundColor: action == 'approve'
            ? AppTheme.lightTheme.colorScheme.primary
            : AppTheme.lightTheme.colorScheme.error,
      ),
    );
  }

  void _handleEmployeeSelected(Map<String, dynamic> employee) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildEmployeeDetailsSheet(employee),
    );
  }

  void _handleNavigationTap(int index) {
    setState(() {
      _currentNavIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(
            context, '/executive-overview-dashboard');
        break;
      case 1:
        // Current screen - HR Management Dashboard
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/sales-performance-dashboard');
        break;
      case 3:
        Navigator.pushReplacementNamed(
            context, '/operations-monitoring-dashboard');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWrapper(
      currentIndex: _currentNavIndex,
      onNavigationTap: _handleNavigationTap,
      title: 'HR Management Dashboard',
      body: _buildDashboardBody(),
      floatingActionButton: _buildFloatingActionButton(),
      appBar: context.isMobile ? _buildMobileAppBar() : null,
    );
  }

  PreferredSizeWidget _buildMobileAppBar() {
    return AppBar(
      title: Text(
        'HR Management',
        style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      elevation: 2,
      actions: [
        IconButton(
          onPressed: () {},
          icon: CustomIconWidget(
            iconName: 'mic',
            size: ResponsiveSize.width(context, 6.w, 5.w, 4.w),
            color: AppTheme.lightTheme.colorScheme.primary,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Stack(
            children: [
              CustomIconWidget(
                iconName: 'notifications',
                size: ResponsiveSize.width(context, 6.w, 5.w, 4.w),
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: ResponsiveSize.width(context, 2.w, 1.5.w, 1.w),
                  height: ResponsiveSize.width(context, 2.w, 1.5.w, 1.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: context.responsivePadding / 2),
      ],
    );
  }

  Widget _buildDashboardBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Global Controls
          HrGlobalControlsWidget(
            onEmployeeGroupChanged: _handleEmployeeGroupChange,
            onPayPeriodChanged: _handlePayPeriodChange,
            onLocationChanged: _handleLocationChange,
          ),
          SizedBox(height: context.responsiveSpacing),

          // Primary Metrics Row
          HrMetricsRowWidget(
            onMetricTapped: _handleMetricTapped,
          ),
          SizedBox(height: context.responsiveSpacing),

          // Main Content Area - Responsive Layout
          _buildResponsiveContent(),
          SizedBox(height: context.responsiveSpacing),
        ],
      ),
    );
  }

  Widget _buildResponsiveContent() {
    if (context.isDesktop) {
      return _buildDesktopLayout();
    } else if (context.isTablet) {
      return _buildTabletLayout();
    } else {
      return _buildMobileLayout();
    }
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 8,
          child: Column(
            children: [
              AttendanceHeatmapWidget(
                onDateSelected: _handleDateSelected,
              ),
              SizedBox(height: context.responsiveSpacing),
              EmployeePerformanceGridWidget(
                onEmployeeSelected: _handleEmployeeSelected,
              ),
            ],
          ),
        ),
        SizedBox(width: context.responsiveSpacing),
        Expanded(
          flex: 4,
          child: PendingApprovalsWidget(
            onApprovalAction: _handleApprovalAction,
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: AttendanceHeatmapWidget(
                onDateSelected: _handleDateSelected,
              ),
            ),
            SizedBox(width: context.responsiveSpacing * 0.75),
            Expanded(
              flex: 5,
              child: PendingApprovalsWidget(
                onApprovalAction: _handleApprovalAction,
              ),
            ),
          ],
        ),
        SizedBox(height: context.responsiveSpacing),
        EmployeePerformanceGridWidget(
          onEmployeeSelected: _handleEmployeeSelected,
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        PendingApprovalsWidget(
          onApprovalAction: _handleApprovalAction,
        ),
        SizedBox(height: context.responsiveSpacing),
        AttendanceHeatmapWidget(
          onDateSelected: _handleDateSelected,
        ),
        SizedBox(height: context.responsiveSpacing),
        EmployeePerformanceGridWidget(
          onEmployeeSelected: _handleEmployeeSelected,
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _showQuickActionMenu,
      backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      child: CustomIconWidget(
        iconName: 'add',
        size: ResponsiveSize.width(context, 6.w, 5.w, 4.w),
        color: AppTheme.lightTheme.colorScheme.onPrimary,
      ),
    );
  }

  Widget _buildEmployeeDetailsSheet(Map<String, dynamic> employee) {
    return Container(
      height: ResponsiveSize.height(context, 80.h, 70.h, 60.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.responsiveRadius * 2),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: ResponsiveSize.width(context, 10.w, 8.w, 6.w),
            height: ResponsiveSize.height(context, 1.h, 0.8.h, 0.5.h),
            margin: EdgeInsets.symmetric(vertical: context.responsivePadding),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(context.responsiveRadius),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(context.responsivePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: ResponsiveSize.width(context, 20.w, 15.w, 12.w),
                        height: ResponsiveSize.width(context, 20.w, 15.w, 12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              context.responsiveRadius * 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              context.responsiveRadius * 2),
                          child: CustomImageWidget(
                            imageUrl: employee['photo'] as String,
                            width:
                                ResponsiveSize.width(context, 20.w, 15.w, 12.w),
                            height:
                                ResponsiveSize.width(context, 20.w, 15.w, 12.w),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: context.responsivePadding),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              employee['name'] as String,
                              style: AppTheme.lightTheme.textTheme.headlineSmall
                                  ?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: ResponsiveSize.fontSize(
                                    context, 20, 22, 24),
                              ),
                            ),
                            Text(
                              employee['position'] as String,
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                color: AppTheme.lightTheme.colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: ResponsiveSize.fontSize(
                                    context, 16, 18, 18),
                              ),
                            ),
                            Text(
                              employee['department'] as String,
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: AppTheme.lightTheme.colorScheme.onSurface
                                    .withValues(alpha: 0.7),
                                fontSize: ResponsiveSize.fontSize(
                                    context, 14, 15, 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.responsiveSpacing),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: CustomIconWidget(
                            iconName: 'phone',
                            size: ResponsiveSize.width(context, 4.w, 3.w, 2.w),
                            color: AppTheme.lightTheme.colorScheme.onPrimary,
                          ),
                          label: Text('Call'),
                        ),
                      ),
                      SizedBox(width: context.responsivePadding / 2),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: CustomIconWidget(
                            iconName: 'email',
                            size: ResponsiveSize.width(context, 4.w, 3.w, 2.w),
                            color: AppTheme.lightTheme.colorScheme.primary,
                          ),
                          label: Text('Email'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showQuickActionMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(context.responsivePadding),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(context.responsiveRadius * 2),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quick Actions',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: ResponsiveSize.fontSize(context, 20, 22, 24),
              ),
            ),
            SizedBox(height: context.responsiveSpacing),
            Row(
              children: [
                Expanded(
                    child: _buildQuickActionButton('Add Employee', 'person_add',
                        () => Navigator.pop(context))),
                SizedBox(width: context.responsivePadding / 2),
                Expanded(
                    child: _buildQuickActionButton('Leave Request',
                        'event_busy', () => Navigator.pop(context))),
              ],
            ),
            SizedBox(height: context.responsivePadding / 2),
            Row(
              children: [
                Expanded(
                    child: _buildQuickActionButton('Attendance', 'check_circle',
                        () => Navigator.pop(context))),
                SizedBox(width: context.responsivePadding / 2),
                Expanded(
                    child: _buildQuickActionButton(
                        'Reports', 'assessment', () => Navigator.pop(context))),
              ],
            ),
            SizedBox(height: context.responsivePadding / 2),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(
      String title, String icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.responsivePadding),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(context.responsiveRadius),
          border: Border.all(
            color:
                AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            CustomIconWidget(
              iconName: icon,
              size: ResponsiveSize.width(context, 8.w, 6.w, 4.w),
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
            SizedBox(height: context.responsivePadding / 4),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.primary,
                fontSize: ResponsiveSize.fontSize(context, 12, 13, 14),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

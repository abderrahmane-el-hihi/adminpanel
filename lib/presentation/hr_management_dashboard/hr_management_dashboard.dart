import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
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
  int _currentBottomNavIndex = 1; // HR Management Dashboard index
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
    // Refresh data based on selected group
  }

  void _handlePayPeriodChange(String period) {
    setState(() {
      selectedPayPeriod = period;
    });
    // Refresh data based on selected period
  }

  void _handleLocationChange(String location) {
    setState(() {
      selectedLocation = location;
    });
    // Refresh data based on selected location
  }

  void _handleMetricTapped(String metricKey) {
    // Navigate to detailed view or show drill-down
    switch (metricKey) {
      case 'attendance':
        // Show attendance details
        break;
      case 'leave_requests':
        // Show leave requests details
        break;
      case 'new_hires':
        // Show new hires details
        break;
      case 'turnover':
        // Show turnover analysis
        break;
    }
  }

  void _handleDateSelected(DateTime date) {
    // Handle attendance heatmap date selection
    // Show detailed attendance for selected date
  }

  void _handleApprovalAction(Map<String, dynamic> approval, String action) {
    // Handle approval/rejection actions
    setState(() {
      // Update approval status
    });

    // Show confirmation
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
    // Navigate to employee details or show employee profile
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildEmployeeDetailsSheet(employee),
    );
  }

  void _handleBottomNavTap(int index) {
    setState(() {
      _currentBottomNavIndex = index;
    });

    // Navigate to different dashboards
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
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
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
            onPressed: () {
              // Voice search functionality
            },
            icon: CustomIconWidget(
              iconName: 'mic',
              size: 6.w,
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: () {
              // Notifications
            },
            icon: Stack(
              children: [
                CustomIconWidget(
                  iconName: 'notifications',
                  size: 6.w,
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 2.w,
                    height: 2.w,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 2.h),
              // Global Controls
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: HrGlobalControlsWidget(
                  onEmployeeGroupChanged: _handleEmployeeGroupChange,
                  onPayPeriodChanged: _handlePayPeriodChange,
                  onLocationChanged: _handleLocationChange,
                ),
              ),
              SizedBox(height: 3.h),
              // Primary Metrics Row
              HrMetricsRowWidget(
                onMetricTapped: _handleMetricTapped,
              ),
              SizedBox(height: 3.h),
              // Main Content Area - Responsive Layout
              100.w > 900
                  ? _buildDesktopLayout()
                  : 100.w > 600
                      ? _buildTabletLayout()
                      : _buildMobileLayout(),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        onTap: _handleBottomNavTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        selectedItemColor: AppTheme.lightTheme.colorScheme.primary,
        unselectedItemColor:
            AppTheme.lightTheme.colorScheme.onSurface.withValues(alpha: 0.6),
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'dashboard',
              size: 6.w,
              color: _currentBottomNavIndex == 0
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.6),
            ),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'people',
              size: 6.w,
              color: _currentBottomNavIndex == 1
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.6),
            ),
            label: 'HR',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'trending_up',
              size: 6.w,
              color: _currentBottomNavIndex == 2
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.6),
            ),
            label: 'Sales',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'monitor_heart',
              size: 6.w,
              color: _currentBottomNavIndex == 3
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.6),
            ),
            label: 'Operations',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Quick add employee or quick action
          _showQuickActionMenu();
        },
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        child: CustomIconWidget(
          iconName: 'add',
          size: 6.w,
          color: AppTheme.lightTheme.colorScheme.onPrimary,
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main content area (10 columns)
          Expanded(
            flex: 10,
            child: Column(
              children: [
                AttendanceHeatmapWidget(
                  onDateSelected: _handleDateSelected,
                ),
                SizedBox(height: 3.h),
                EmployeePerformanceGridWidget(
                  onEmployeeSelected: _handleEmployeeSelected,
                ),
              ],
            ),
          ),
          SizedBox(width: 4.w),
          // Right panel (6 columns)
          Expanded(
            flex: 6,
            child: PendingApprovalsWidget(
              onApprovalAction: _handleApprovalAction,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
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
              SizedBox(width: 3.w),
              Expanded(
                flex: 5,
                child: PendingApprovalsWidget(
                  onApprovalAction: _handleApprovalAction,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          EmployeePerformanceGridWidget(
            onEmployeeSelected: _handleEmployeeSelected,
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          // Priority: Pending Approvals first on mobile
          PendingApprovalsWidget(
            onApprovalAction: _handleApprovalAction,
          ),
          SizedBox(height: 3.h),
          AttendanceHeatmapWidget(
            onDateSelected: _handleDateSelected,
          ),
          SizedBox(height: 3.h),
          EmployeePerformanceGridWidget(
            onEmployeeSelected: _handleEmployeeSelected,
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeDetailsSheet(Map<String, dynamic> employee) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(5.w)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 10.w,
            height: 1.h,
            margin: EdgeInsets.symmetric(vertical: 2.h),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(0.5.h),
            ),
          ),
          // Employee details content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.w),
                          child: CustomImageWidget(
                            imageUrl: employee['photo'] as String,
                            width: 20.w,
                            height: 20.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              employee['name'] as String,
                              style: AppTheme.lightTheme.textTheme.headlineSmall
                                  ?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              employee['position'] as String,
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                color: AppTheme.lightTheme.colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              employee['department'] as String,
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: AppTheme.lightTheme.colorScheme.onSurface
                                    .withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  // Contact information and quick actions
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Call employee
                          },
                          icon: CustomIconWidget(
                            iconName: 'phone',
                            size: 4.w,
                            color: AppTheme.lightTheme.colorScheme.onPrimary,
                          ),
                          label: Text('Call'),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Email employee
                          },
                          icon: CustomIconWidget(
                            iconName: 'email',
                            size: 4.w,
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
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(5.w)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quick Actions',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                Expanded(
                  child: _buildQuickActionButton(
                    'Add Employee',
                    'person_add',
                    () {
                      Navigator.pop(context);
                      // Navigate to add employee screen
                    },
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _buildQuickActionButton(
                    'Leave Request',
                    'event_busy',
                    () {
                      Navigator.pop(context);
                      // Navigate to leave request screen
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _buildQuickActionButton(
                    'Attendance',
                    'check_circle',
                    () {
                      Navigator.pop(context);
                      // Navigate to attendance screen
                    },
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _buildQuickActionButton(
                    'Reports',
                    'assessment',
                    () {
                      Navigator.pop(context);
                      // Navigate to reports screen
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
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
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(3.w),
          border: Border.all(
            color:
                AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            CustomIconWidget(
              iconName: icon,
              size: 8.w,
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
            SizedBox(height: 1.h),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

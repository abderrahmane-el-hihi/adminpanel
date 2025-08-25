import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import './widgets/alert_feed_widget.dart';
import './widgets/date_filter_widget.dart';
import './widgets/department_performance_widget.dart';
import './widgets/kpi_card_widget.dart';
import './widgets/revenue_chart_widget.dart';

class ExecutiveOverviewDashboard extends StatefulWidget {
  const ExecutiveOverviewDashboard({super.key});

  @override
  State<ExecutiveOverviewDashboard> createState() =>
      _ExecutiveOverviewDashboardState();
}

class _ExecutiveOverviewDashboardState
    extends State<ExecutiveOverviewDashboard> {
  String _selectedPeriod = 'MTD';
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedDepartment = 'All Departments';
  bool _showComparison = false;
  int _currentNavIndex = 0;

  // Mock data for KPIs
  final List<Map<String, dynamic>> _kpiData = [
    {
      "title": "Total Revenue",
      "value": "\$2.4M",
      "change": "+12.5% vs last month",
      "isPositive": true,
      "icon": Icons.attach_money,
    },
    {
      "title": "Employee Headcount",
      "value": "1,247",
      "change": "+3.2% vs last month",
      "isPositive": true,
      "icon": Icons.people,
    },
    {
      "title": "Attendance Rate",
      "value": "94.8%",
      "change": "-1.2% vs last month",
      "isPositive": false,
      "icon": Icons.schedule,
    },
    {
      "title": "Active Projects",
      "value": "156",
      "change": "+8.7% vs last month",
      "isPositive": true,
      "icon": Icons.work,
    },
    {
      "title": "Customer Satisfaction",
      "value": "4.7/5",
      "change": "+0.3 vs last month",
      "isPositive": true,
      "icon": Icons.star,
    },
    {
      "title": "Cash Flow",
      "value": "\$890K",
      "change": "+15.8% vs last month",
      "isPositive": true,
      "icon": Icons.account_balance_wallet,
    },
  ];

  // Mock data for revenue chart
  final List<Map<String, dynamic>> _revenueData = [
    {"month": "Jan", "amount": 180000},
    {"month": "Feb", "amount": 220000},
    {"month": "Mar", "amount": 280000},
    {"month": "Apr", "amount": 320000},
    {"month": "May", "amount": 380000},
    {"month": "Jun", "amount": 420000},
  ];

  // Mock data for productivity
  final List<Map<String, dynamic>> _productivityData = [
    {"month": "Jan", "score": 78},
    {"month": "Feb", "score": 82},
    {"month": "Mar", "score": 85},
    {"month": "Apr", "score": 88},
    {"month": "May", "score": 91},
    {"month": "Jun", "score": 94},
  ];

  // Mock data for alerts
  final List<Map<String, dynamic>> _alertsData = [
    {
      "id": 1,
      "type": "leave_approval",
      "title": "Leave Approval Required",
      "message":
          "Sarah Johnson has requested 3 days of vacation leave starting tomorrow.",
      "priority": "urgent",
      "timestamp": DateTime.now().subtract(const Duration(minutes: 15)),
    },
    {
      "id": 2,
      "type": "budget_alert",
      "title": "Budget Threshold Exceeded",
      "message":
          "Marketing department has exceeded 90% of monthly budget allocation.",
      "priority": "high",
      "timestamp": DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      "id": 3,
      "type": "sales_milestone",
      "title": "Sales Milestone Achieved",
      "message":
          "Q2 sales target of \$2M has been reached 2 weeks ahead of schedule.",
      "priority": "medium",
      "timestamp": DateTime.now().subtract(const Duration(hours: 4)),
    },
    {
      "id": 4,
      "type": "system_alert",
      "title": "System Maintenance",
      "message": "Scheduled maintenance window tonight from 11 PM to 2 AM EST.",
      "priority": "low",
      "timestamp": DateTime.now().subtract(const Duration(hours: 6)),
    },
  ];

  // Mock data for department performance
  final List<Map<String, dynamic>> _departmentData = [
    {
      "name": "Sales",
      "performance": 94,
      "budget": "\$450K",
      "budgetUsed": 78,
      "employees": 45,
      "trendData": [85.0, 88.0, 90.0, 92.0, 94.0],
    },
    {
      "name": "Marketing",
      "performance": 87,
      "budget": "\$320K",
      "budgetUsed": 92,
      "employees": 28,
      "trendData": [82.0, 84.0, 85.0, 86.0, 87.0],
    },
    {
      "name": "Engineering",
      "performance": 91,
      "budget": "\$680K",
      "budgetUsed": 65,
      "employees": 78,
      "trendData": [88.0, 89.0, 90.0, 91.0, 91.0],
    },
    {
      "name": "HR",
      "performance": 89,
      "budget": "\$180K",
      "budgetUsed": 54,
      "employees": 12,
      "trendData": [86.0, 87.0, 88.0, 89.0, 89.0],
    },
    {
      "name": "Operations",
      "performance": 85,
      "budget": "\$290K",
      "budgetUsed": 71,
      "employees": 34,
      "trendData": [83.0, 84.0, 84.0, 85.0, 85.0],
    },
  ];

  final List<String> _departments = [
    'All Departments',
    'Sales',
    'Marketing',
    'Engineering',
    'HR',
    'Operations',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Executive Overview',
        isConnected: true,
        actions: [
          PopupMenuButton<String>(
            icon: CustomIconWidget(
              iconName: 'more_vert',
              color: colorScheme.onSurface,
              size: 24,
            ),
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'refresh',
                child: Row(
                  children: [
                    Icon(Icons.refresh, size: 20),
                    SizedBox(width: 12),
                    Text('Refresh Data'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.file_download, size: 20),
                    SizedBox(width: 12),
                    Text('Export Dashboard'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings, size: 20),
                    SizedBox(width: 12),
                    Text('Dashboard Settings'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: colorScheme.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Global Filters Section
              _buildFiltersSection(),
              SizedBox(height: 4.h),

              // KPI Cards Section
              _buildKpiSection(),
              SizedBox(height: 4.h),

              // Main Content Section (Chart + Alerts)
              _buildMainContentSection(),
              SizedBox(height: 4.h),

              // Department Performance Section
              DepartmentPerformanceWidget(
                departmentData: _departmentData,
                onExport: _exportDepartmentData,
              ),
              SizedBox(height: 8.h), // Extra space for bottom navigation
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentNavIndex,
        onTap: _handleBottomNavTap,
      ),
    );
  }

  Widget _buildFiltersSection() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard Filters',
            style: theme.textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),

          // Date Filter
          DateFilterWidget(
            selectedPeriod: _selectedPeriod,
            onPeriodChanged: (period) {
              setState(() {
                _selectedPeriod = period;
              });
            },
            startDate: _startDate,
            endDate: _endDate,
            onDateRangeChanged: (range) {
              setState(() {
                _startDate = range?.start;
                _endDate = range?.end;
              });
            },
          ),
          SizedBox(height: 3.h),

          // Department and Comparison Filters
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: colorScheme.outline.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedDepartment,
                      isExpanded: true,
                      icon: CustomIconWidget(
                        iconName: 'keyboard_arrow_down',
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                        size: 20,
                      ),
                      items: _departments.map((department) {
                        return DropdownMenuItem(
                          value: department,
                          child: Text(
                            department,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedDepartment = value;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showComparison = !_showComparison;
                  });
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                  decoration: BoxDecoration(
                    color: _showComparison
                        ? colorScheme.primary
                        : colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _showComparison
                          ? colorScheme.primary
                          : colorScheme.outline.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'compare_arrows',
                        color: _showComparison
                            ? colorScheme.onPrimary
                            : colorScheme.onSurface.withValues(alpha: 0.6),
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        'Compare',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: _showComparison
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface.withValues(alpha: 0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKpiSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Performance Indicators',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 2.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3.w,
            mainAxisSpacing: 3.w,
            childAspectRatio: 1.2,
          ),
          itemCount: _kpiData.length,
          itemBuilder: (context, index) {
            final kpi = _kpiData[index];
            return KpiCardWidget(
              title: kpi['title'] as String,
              value: kpi['value'] as String,
              change: kpi['change'] as String,
              isPositive: kpi['isPositive'] as bool,
              icon: kpi['icon'] as IconData,
              onTap: () => _handleKpiTap(kpi['title'] as String),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMainContentSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // For mobile, stack vertically
        if (constraints.maxWidth < 768) {
          return Column(
            children: [
              RevenueChartWidget(
                revenueData: _revenueData,
                productivityData: _productivityData,
                onExport: _exportChartData,
              ),
              SizedBox(height: 4.h),
              AlertFeedWidget(
                alerts: _alertsData,
                onViewAll: _viewAllAlerts,
              ),
            ],
          );
        }

        // For tablet and larger, use row layout
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: RevenueChartWidget(
                revenueData: _revenueData,
                productivityData: _productivityData,
                onExport: _exportChartData,
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              flex: 1,
              child: AlertFeedWidget(
                alerts: _alertsData,
                onViewAll: _viewAllAlerts,
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'refresh':
        _refreshData();
        break;
      case 'export':
        _exportDashboard();
        break;
      case 'settings':
        _showDashboardSettings();
        break;
    }
  }

  void _handleBottomNavTap(int index) {
    setState(() {
      _currentNavIndex = index;
    });
  }

  void _handleKpiTap(String kpiTitle) {
    // Navigate to detailed view based on KPI
    switch (kpiTitle) {
      case 'Total Revenue':
      case 'Cash Flow':
        Navigator.pushNamed(context, '/sales-performance-dashboard');
        break;
      case 'Employee Headcount':
      case 'Attendance Rate':
        Navigator.pushNamed(context, '/hr-management-dashboard');
        break;
      case 'Active Projects':
      case 'Customer Satisfaction':
        Navigator.pushNamed(context, '/operations-monitoring-dashboard');
        break;
    }
  }

  Future<void> _refreshData() async {
    // Simulate data refresh
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Dashboard data refreshed successfully'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _exportChartData() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Chart data exported successfully'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _exportDepartmentData() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Department data exported successfully'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _exportDashboard() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Dashboard exported to PDF successfully'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _viewAllAlerts() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .outline
                        .withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All Alerts',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    itemCount: _alertsData.length,
                    separatorBuilder: (context, index) => SizedBox(height: 2.h),
                    itemBuilder: (context, index) {
                      final alert = _alertsData[index];
                      return Container(
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              alert['title'] as String,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              alert['message'] as String,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                                  ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDashboardSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dashboard Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('Auto Refresh'),
              subtitle: const Text('Refresh data every 30 minutes'),
              value: true,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: const Text('Push Notifications'),
              subtitle: const Text('Receive alerts on mobile'),
              value: true,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Use dark theme'),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

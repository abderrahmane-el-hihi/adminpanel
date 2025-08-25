import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import './widgets/inventory_flow_chart_widget.dart';
import './widgets/operations_metrics_widget.dart';
import './widgets/operations_table_widget.dart';
import './widgets/task_management_widget.dart';

class OperationsMonitoringDashboard extends StatefulWidget {
  const OperationsMonitoringDashboard({super.key});

  @override
  State<OperationsMonitoringDashboard> createState() =>
      _OperationsMonitoringDashboardState();
}

class _OperationsMonitoringDashboardState
    extends State<OperationsMonitoringDashboard> with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentBottomNavIndex = 3; // Operations tab
  bool _isConnected = true;
  String _selectedLocation = "All Locations";
  String _operationalStatus = "All Status";
  int _autoRefreshInterval = 15; // minutes

  final List<String> _locations = [
    "All Locations",
    "Headquarters - NYC",
    "Warehouse - LA",
    "Distribution - Chicago",
    "Manufacturing - Detroit",
  ];

  final List<String> _statusFilters = [
    "All Status",
    "Active",
    "Pending",
    "Critical",
    "Maintenance",
  ];

  final List<int> _refreshIntervals = [5, 15, 30]; // minutes

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _simulateConnectivityChanges();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _simulateConnectivityChanges() {
    // Simulate occasional connectivity changes for demo
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted) {
        setState(() {
          _isConnected = !_isConnected;
        });
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) {
            setState(() {
              _isConnected = true;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: CustomAppBar(
        title: 'Operations Monitoring',
        isConnected: _isConnected,
        actions: [
          GestureDetector(
            onTap: () => _showLocationSelector(),
            child: Container(
              margin: EdgeInsets.only(right: 2.w),
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'location_on',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 16,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    _selectedLocation.split(' - ').first,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildGlobalControls(),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive layout based on screen width
                if (constraints.maxWidth > 1200) {
                  return _buildDesktopLayout();
                } else if (constraints.maxWidth > 768) {
                  return _buildTabletLayout();
                } else {
                  return _buildMobileLayout();
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentBottomNavIndex,
        onTap: (index) {
          setState(() {
            _currentBottomNavIndex = index;
          });
        },
      ),
      floatingActionButton: _buildQuickActionFAB(),
    );
  }

  Widget _buildGlobalControls() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildControlDropdown(
                  "Location",
                  _selectedLocation,
                  _locations,
                  (value) => setState(() => _selectedLocation = value),
                  Icons.location_on,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildControlDropdown(
                  "Status",
                  _operationalStatus,
                  _statusFilters,
                  (value) => setState(() => _operationalStatus = value),
                  Icons.filter_list,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildRefreshControl(),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _buildQuickStats(),
        ],
      ),
    );
  }

  Widget _buildControlDropdown(
    String label,
    String value,
    List<String> options,
    Function(String) onChanged,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.borderLight,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: icon.toString().split('.').last,
                color: AppTheme.textSecondaryLight,
                size: 16,
              ),
              SizedBox(width: 1.w),
              Text(
                label,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondaryLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 0.5.h),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              isDense: true,
              items: options.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  onChanged(newValue);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefreshControl() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.borderLight,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'autorenew',
                color: AppTheme.textSecondaryLight,
                size: 16,
              ),
              SizedBox(width: 1.w),
              Text(
                'Auto Refresh',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondaryLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => _manualRefresh(),
                child: CustomIconWidget(
                  iconName: 'refresh',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 0.5.h),
          Row(
            children: _refreshIntervals.map((interval) {
              final isSelected = _autoRefreshInterval == interval;
              return GestureDetector(
                onTap: () => setState(() => _autoRefreshInterval = interval),
                child: Container(
                  margin: EdgeInsets.only(right: 1.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${interval}m',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.onPrimary
                          : AppTheme.textSecondaryLight,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    final stats = [
      {
        "label": "Active Operations",
        "value": "47",
        "color": AppTheme.successLight
      },
      {
        "label": "Pending Approvals",
        "value": "12",
        "color": AppTheme.accentLight
      },
      {"label": "Critical Alerts", "value": "3", "color": AppTheme.errorLight},
      {
        "label": "System Health",
        "value": "98%",
        "color": AppTheme.lightTheme.colorScheme.primary
      },
    ];

    return Row(
      children: stats.map((stat) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.w),
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: (stat["color"] as Color).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  stat["value"] as String,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: stat["color"] as Color,
                  ),
                ),
                Text(
                  stat["label"] as String,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondaryLight,
                    fontSize: 10.sp,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: EdgeInsets.all(2.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main content area (8 columns)
          Expanded(
            flex: 8,
            child: Column(
              children: [
                const OperationsMetricsWidget(),
                SizedBox(height: 2.h),
                const Expanded(
                  child: InventoryFlowChartWidget(),
                ),
              ],
            ),
          ),
          SizedBox(width: 2.w),
          // Right sidebar (4 columns)
          Expanded(
            flex: 4,
            child: Column(
              children: [
                const Expanded(
                  flex: 3,
                  child: TaskManagementWidget(),
                ),
                SizedBox(height: 2.h),
                const Expanded(
                  flex: 2,
                  child: OperationsTableWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Container(
            color: AppTheme.lightTheme.colorScheme.surface,
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Overview', icon: Icon(Icons.dashboard_outlined)),
                Tab(text: 'Inventory', icon: Icon(Icons.inventory_outlined)),
                Tab(text: 'Tasks', icon: Icon(Icons.task_outlined)),
                Tab(text: 'Operations', icon: Icon(Icons.list_alt_outlined)),
              ],
              isScrollable: false,
              labelStyle: AppTheme.lightTheme.textTheme.bodySmall,
              unselectedLabelStyle: AppTheme.lightTheme.textTheme.bodySmall,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: EdgeInsets.all(2.w),
                  child: const OperationsMetricsWidget(),
                ),
                Padding(
                  padding: EdgeInsets.all(2.w),
                  child: const InventoryFlowChartWidget(),
                ),
                Padding(
                  padding: EdgeInsets.all(2.w),
                  child: const TaskManagementWidget(),
                ),
                Padding(
                  padding: EdgeInsets.all(2.w),
                  child: const OperationsTableWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          const OperationsMetricsWidget(),
          SizedBox(height: 3.h),
          _buildMobileQuickActions(),
          SizedBox(height: 3.h),
          SizedBox(
            height: 50.h,
            child: const InventoryFlowChartWidget(),
          ),
          SizedBox(height: 3.h),
          SizedBox(
            height: 60.h,
            child: const TaskManagementWidget(),
          ),
          SizedBox(height: 3.h),
          SizedBox(
            height: 70.h,
            child: const OperationsTableWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileQuickActions() {
    final actions = [
      {
        "icon": "qr_code_scanner",
        "label": "Scan Barcode",
        "color": AppTheme.lightTheme.colorScheme.primary
      },
      {
        "icon": "mic",
        "label": "Voice Search",
        "color": AppTheme.lightTheme.colorScheme.secondary
      },
      {
        "icon": "camera_alt",
        "label": "Capture Receipt",
        "color": AppTheme.accentLight
      },
      {
        "icon": "location_on",
        "label": "GPS Check-in",
        "color": AppTheme.successLight
      },
    ];

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
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
            'Quick Actions',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: actions.map((action) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => _handleQuickAction(action["label"] as String),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.w),
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: (action["color"] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        CustomIconWidget(
                          iconName: action["icon"] as String,
                          color: action["color"] as Color,
                          size: 24,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          action["label"] as String,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionFAB() {
    return FloatingActionButton(
      onPressed: () => _showQuickActionMenu(),
      backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      child: CustomIconWidget(
        iconName: 'add',
        color: AppTheme.lightTheme.colorScheme.onPrimary,
        size: 24,
      ),
    );
  }

  void _showLocationSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Location',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            ..._locations.map((location) {
              return ListTile(
                title: Text(location),
                leading: Radio<String>(
                  value: location,
                  groupValue: _selectedLocation,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedLocation = value;
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showQuickActionMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quick Actions',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'add_shopping_cart',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: const Text('Create Purchase Order'),
              onTap: () {
                Navigator.pop(context);
                _handleQuickAction('Create Purchase Order');
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'assignment',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 24,
              ),
              title: const Text('Add Task'),
              onTap: () {
                Navigator.pop(context);
                _handleQuickAction('Add Task');
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'inventory',
                color: AppTheme.accentLight,
                size: 24,
              ),
              title: const Text('Inventory Audit'),
              onTap: () {
                Navigator.pop(context);
                _handleQuickAction('Inventory Audit');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _manualRefresh() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Refreshing operations data...'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleQuickAction(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action functionality would be implemented here'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

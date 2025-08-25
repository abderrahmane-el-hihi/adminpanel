import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OperationsMetricsWidget extends StatefulWidget {
  const OperationsMetricsWidget({super.key});

  @override
  State<OperationsMetricsWidget> createState() =>
      _OperationsMetricsWidgetState();
}

class _OperationsMetricsWidgetState extends State<OperationsMetricsWidget> {
  final List<Map<String, dynamic>> metricsData = [
    {
      "title": "Inventory Levels",
      "value": "2,847",
      "unit": "items",
      "change": "+12.5%",
      "isPositive": true,
      "icon": "inventory",
      "color": AppTheme.lightTheme.colorScheme.primary,
      "threshold": "Normal",
      "details": "Total items across all categories",
    },
    {
      "title": "Pending Purchase Orders",
      "value": "23",
      "unit": "orders",
      "change": "-8.2%",
      "isPositive": true,
      "icon": "shopping_cart",
      "color": AppTheme.lightTheme.colorScheme.secondary,
      "threshold": "Low",
      "details": "Awaiting approval and processing",
    },
    {
      "title": "Active Projects",
      "value": "15",
      "unit": "projects",
      "change": "+3.1%",
      "isPositive": true,
      "icon": "work",
      "color": AppTheme.accentLight,
      "threshold": "Normal",
      "details": "Currently in progress",
    },
    {
      "title": "System Uptime",
      "value": "99.8%",
      "unit": "uptime",
      "change": "+0.2%",
      "isPositive": true,
      "icon": "monitor_heart",
      "color": AppTheme.successLight,
      "threshold": "Excellent",
      "details": "Last 30 days average",
    },
  ];

  bool isAutoRefresh = true;
  String selectedTimeframe = "24h";
  final List<String> timeframes = ["1h", "6h", "24h", "7d", "30d"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          _buildHeader(),
          SizedBox(height: 3.h),
          _buildMetricsGrid(),
          SizedBox(height: 3.h),
          _buildSystemStatus(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Operations Overview',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Real-time operational metrics',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondaryLight,
              ),
            ),
          ],
        ),
        Row(
          children: [
            _buildTimeframeSelector(),
            SizedBox(width: 2.w),
            _buildAutoRefreshToggle(),
            SizedBox(width: 2.w),
            _buildRefreshButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeframeSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.borderLight,
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedTimeframe,
          isDense: true,
          items: timeframes.map((timeframe) {
            return DropdownMenuItem<String>(
              value: timeframe,
              child: Text(
                timeframe,
                style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedTimeframe = value;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildAutoRefreshToggle() {
    return GestureDetector(
      onTap: () => setState(() => isAutoRefresh = !isAutoRefresh),
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: isAutoRefresh
              ? AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1)
              : AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isAutoRefresh
                ? AppTheme.lightTheme.colorScheme.primary
                : AppTheme.borderLight,
            width: 1,
          ),
        ),
        child: CustomIconWidget(
          iconName: 'autorenew',
          color: isAutoRefresh
              ? AppTheme.lightTheme.colorScheme.primary
              : AppTheme.textSecondaryLight,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildRefreshButton() {
    return GestureDetector(
      onTap: () => _refreshMetrics(),
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color:
              AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CustomIconWidget(
          iconName: 'refresh',
          color: AppTheme.lightTheme.colorScheme.secondary,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildMetricsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 2.h,
        childAspectRatio: 1.2,
      ),
      itemCount: metricsData.length,
      itemBuilder: (context, index) {
        final metric = metricsData[index];
        return _buildMetricCard(metric);
      },
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    final thresholdColor = _getThresholdColor(metric["threshold"] as String);

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderLight.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight.withValues(alpha: 0.5),
            offset: const Offset(0, 1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: (metric["color"] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: metric["icon"] as String,
                  color: metric["color"] as Color,
                  size: 24,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: thresholdColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  metric["threshold"] as String,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: thresholdColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            metric["title"] as String,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondaryLight,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 1.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  metric["value"] as String,
                  style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: metric["color"] as Color,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.5.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: (metric["isPositive"] as bool)
                          ? AppTheme.successLight.withValues(alpha: 0.1)
                          : AppTheme.errorLight.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: (metric["isPositive"] as bool)
                              ? 'trending_up'
                              : 'trending_down',
                          color: (metric["isPositive"] as bool)
                              ? AppTheme.successLight
                              : AppTheme.errorLight,
                          size: 12,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          metric["change"] as String,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: (metric["isPositive"] as bool)
                                ? AppTheme.successLight
                                : AppTheme.errorLight,
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    metric["unit"] as String,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryLight,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            metric["details"] as String,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondaryLight,
              fontSize: 10.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSystemStatus() {
    final systemAlerts = [
      {
        "type": "warning",
        "message": "Low stock alert: 3 items below minimum threshold",
        "timestamp": DateTime.now().subtract(const Duration(minutes: 15)),
        "action": "Review Inventory",
      },
      {
        "type": "info",
        "message": "Scheduled maintenance completed successfully",
        "timestamp": DateTime.now().subtract(const Duration(hours: 2)),
        "action": "View Report",
      },
      {
        "type": "success",
        "message": "Purchase order PO-2024-0891 approved and processed",
        "timestamp": DateTime.now().subtract(const Duration(hours: 4)),
        "action": "Track Order",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'System Alerts',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () => _viewAllAlerts(),
              child: Text(
                'View All',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        ...systemAlerts.take(3).map((alert) {
          final alertColor = _getAlertColor(alert["type"] as String);
          final alertIcon = _getAlertIcon(alert["type"] as String);

          return Container(
            margin: EdgeInsets.only(bottom: 1.h),
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: alertColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: alertColor.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: alertIcon,
                  color: alertColor,
                  size: 20,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert["message"] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        _formatTimestamp(alert["timestamp"] as DateTime),
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _handleAlertAction(alert["action"] as String),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: alertColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      alert["action"] as String,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Color _getThresholdColor(String threshold) {
    switch (threshold) {
      case 'Excellent':
        return AppTheme.successLight;
      case 'Normal':
        return AppTheme.lightTheme.colorScheme.primary;
      case 'Low':
        return AppTheme.accentLight;
      case 'Critical':
        return AppTheme.errorLight;
      default:
        return AppTheme.textSecondaryLight;
    }
  }

  Color _getAlertColor(String type) {
    switch (type) {
      case 'warning':
        return AppTheme.accentLight;
      case 'error':
        return AppTheme.errorLight;
      case 'success':
        return AppTheme.successLight;
      case 'info':
        return AppTheme.lightTheme.colorScheme.secondary;
      default:
        return AppTheme.textSecondaryLight;
    }
  }

  String _getAlertIcon(String type) {
    switch (type) {
      case 'warning':
        return 'warning';
      case 'error':
        return 'error';
      case 'success':
        return 'check_circle';
      case 'info':
        return 'info';
      default:
        return 'notifications';
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  void _refreshMetrics() {
    setState(() {
      // Simulate metrics refresh
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Metrics refreshed'),
        backgroundColor: AppTheme.successLight,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _viewAllAlerts() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening alerts dashboard...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleAlertAction(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Executing: $action'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

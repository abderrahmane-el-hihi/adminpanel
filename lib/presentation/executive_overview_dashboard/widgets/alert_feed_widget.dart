import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class AlertFeedWidget extends StatelessWidget {
  final List<Map<String, dynamic>> alerts;
  final VoidCallback? onViewAll;

  const AlertFeedWidget({
    super.key,
    required this.alerts,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 35.h,
        maxHeight: 50.h,
      ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Real-time Alerts',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Urgent notifications & approvals',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onViewAll,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                    vertical: 1.h,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View All',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 1.w),
                      CustomIconWidget(
                        iconName: 'arrow_forward',
                        color: colorScheme.primary,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Expanded(
            child: alerts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'notifications_none',
                          color: colorScheme.onSurface.withValues(alpha: 0.3),
                          size: 48,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'No alerts at the moment',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: alerts.length,
                    separatorBuilder: (context, index) => SizedBox(height: 2.h),
                    itemBuilder: (context, index) {
                      final alert = alerts[index];
                      return _AlertItem(
                        alert: alert,
                        onTap: () => _handleAlertTap(context, alert),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _handleAlertTap(BuildContext context, Map<String, dynamic> alert) {
    // Handle alert tap - navigate to relevant screen or show details
    final alertType = alert['type'] as String;
    switch (alertType) {
      case 'leave_approval':
        Navigator.pushNamed(context, '/hr-management-dashboard');
        break;
      case 'budget_alert':
        Navigator.pushNamed(context, '/operations-monitoring-dashboard');
        break;
      case 'sales_milestone':
        Navigator.pushNamed(context, '/sales-performance-dashboard');
        break;
      default:
        // Show alert details in a dialog
        _showAlertDetails(context, alert);
        break;
    }
  }

  void _showAlertDetails(BuildContext context, Map<String, dynamic> alert) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(alert['title'] as String),
        content: Text(alert['message'] as String),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _AlertItem extends StatelessWidget {
  final Map<String, dynamic> alert;
  final VoidCallback onTap;

  const _AlertItem({
    required this.alert,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final priority = alert['priority'] as String;
    final isUrgent = priority == 'urgent';
    final isHigh = priority == 'high';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: isUrgent
              ? colorScheme.error.withValues(alpha: 0.05)
              : isHigh
                  ? colorScheme.tertiary.withValues(alpha: 0.05)
                  : colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isUrgent
                ? colorScheme.error.withValues(alpha: 0.3)
                : isHigh
                    ? colorScheme.tertiary.withValues(alpha: 0.3)
                    : colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: _getPriorityColor(priority, colorScheme)
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: CustomIconWidget(
                iconName: _getPriorityIcon(priority),
                color: _getPriorityColor(priority, colorScheme),
                size: 20,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          alert['title'] as String,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(priority, colorScheme)
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          priority.toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: _getPriorityColor(priority, colorScheme),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    alert['message'] as String,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'access_time',
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                        size: 14,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        _formatTime(alert['timestamp'] as DateTime),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CustomIconWidget(
              iconName: 'chevron_right',
              color: colorScheme.onSurface.withValues(alpha: 0.4),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority, ColorScheme colorScheme) {
    switch (priority) {
      case 'urgent':
        return colorScheme.error;
      case 'high':
        return colorScheme.tertiary;
      case 'medium':
        return colorScheme.primary;
      default:
        return colorScheme.onSurface.withValues(alpha: 0.6);
    }
  }

  String _getPriorityIcon(String priority) {
    switch (priority) {
      case 'urgent':
        return 'priority_high';
      case 'high':
        return 'warning';
      case 'medium':
        return 'info';
      default:
        return 'notifications';
    }
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

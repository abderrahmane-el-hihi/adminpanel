import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class HrMetricsRowWidget extends StatelessWidget {
  final Function(String)? onMetricTapped;

  const HrMetricsRowWidget({
    super.key,
    this.onMetricTapped,
  });

  @override
  Widget build(BuildContext context) {
    final metrics = [
      {
        'title': 'Attendance Rate',
        'value': '94.2%',
        'change': '+2.1%',
        'isPositive': true,
        'icon': 'check_circle',
        'color': AppTheme.lightTheme.colorScheme.primary,
        'subtitle': 'This month',
        'key': 'attendance',
      },
      {
        'title': 'Leave Requests',
        'value': '23',
        'change': '+5',
        'isPositive': false,
        'icon': 'pending_actions',
        'color': AppTheme.lightTheme.colorScheme.tertiary,
        'subtitle': 'Pending approval',
        'key': 'leave_requests',
      },
      {
        'title': 'New Hires',
        'value': '12',
        'change': '+3',
        'isPositive': true,
        'icon': 'person_add',
        'color': AppTheme.lightTheme.colorScheme.secondary,
        'subtitle': 'This month',
        'key': 'new_hires',
      },
      {
        'title': 'Turnover Rate',
        'value': '3.8%',
        'change': '-0.5%',
        'isPositive': true,
        'icon': 'trending_down',
        'color': AppTheme.lightTheme.colorScheme.error,
        'subtitle': 'Last 3 months',
        'key': 'turnover',
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        children: metrics.map((metric) => _buildMetricCard(metric)).toList(),
      ),
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    return Container(
      width: 80.w,
      margin: EdgeInsets.only(right: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => onMetricTapped?.call(metric['key'] as String),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: (metric['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: CustomIconWidget(
                    iconName: metric['icon'] as String,
                    size: 6.w,
                    color: metric['color'] as Color,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: (metric['isPositive'] as bool)
                        ? AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.1)
                        : AppTheme.lightTheme.colorScheme.error
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(1.w),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: (metric['isPositive'] as bool)
                            ? 'trending_up'
                            : 'trending_down',
                        size: 3.w,
                        color: (metric['isPositive'] as bool)
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.error,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        metric['change'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: (metric['isPositive'] as bool)
                              ? AppTheme.lightTheme.colorScheme.primary
                              : AppTheme.lightTheme.colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Text(
              metric['value'] as String,
              style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              metric['title'] as String,
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              metric['subtitle'] as String,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: 2.h),
            // Progress indicator for visual appeal
            _buildProgressIndicator(metric),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(Map<String, dynamic> metric) {
    double progress = 0.0;
    String key = metric['key'] as String;

    switch (key) {
      case 'attendance':
        progress = 0.942; // 94.2%
        break;
      case 'leave_requests':
        progress = 0.23; // 23 out of 100 scale
        break;
      case 'new_hires':
        progress = 0.6; // 12 out of 20 target
        break;
      case 'turnover':
        progress = 0.38; // 3.8% out of 10% scale
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _getProgressLabel(key),
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              _getProgressValue(key, progress),
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.7),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Container(
          height: 1.h,
          decoration: BoxDecoration(
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(0.5.h),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: metric['color'] as Color,
                borderRadius: BorderRadius.circular(0.5.h),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getProgressLabel(String key) {
    switch (key) {
      case 'attendance':
        return 'Target: 95%';
      case 'leave_requests':
        return 'Capacity: 50';
      case 'new_hires':
        return 'Target: 20';
      case 'turnover':
        return 'Benchmark: 10%';
      default:
        return 'Progress';
    }
  }

  String _getProgressValue(String key, double progress) {
    switch (key) {
      case 'attendance':
        return '${(progress * 100).toStringAsFixed(1)}%';
      case 'leave_requests':
        return '${(progress * 100).toInt()}/50';
      case 'new_hires':
        return '${(progress * 20).toInt()}/20';
      case 'turnover':
        return '${(progress * 10).toStringAsFixed(1)}%';
      default:
        return '${(progress * 100).toStringAsFixed(0)}%';
    }
  }
}

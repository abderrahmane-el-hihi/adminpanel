import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class DepartmentPerformanceWidget extends StatefulWidget {
  final List<Map<String, dynamic>> departmentData;
  final VoidCallback? onExport;

  const DepartmentPerformanceWidget({
    super.key,
    required this.departmentData,
    this.onExport,
  });

  @override
  State<DepartmentPerformanceWidget> createState() =>
      _DepartmentPerformanceWidgetState();
}

class _DepartmentPerformanceWidgetState
    extends State<DepartmentPerformanceWidget> {
  String _sortBy = 'performance';
  bool _sortAscending = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final sortedData = _getSortedData();

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 40.h,
        maxHeight: 60.h,
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
                      'Department Performance',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Comparative metrics with trends',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  PopupMenuButton<String>(
                    initialValue: _sortBy,
                    onSelected: (value) {
                      setState(() {
                        if (_sortBy == value) {
                          _sortAscending = !_sortAscending;
                        } else {
                          _sortBy = value;
                          _sortAscending = false;
                        }
                      });
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'performance',
                        child: Text('Sort by Performance'),
                      ),
                      const PopupMenuItem(
                        value: 'budget',
                        child: Text('Sort by Budget'),
                      ),
                      const PopupMenuItem(
                        value: 'employees',
                        child: Text('Sort by Employees'),
                      ),
                    ],
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: colorScheme.outline.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: 'sort',
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                            size: 16,
                          ),
                          SizedBox(width: 1.w),
                          CustomIconWidget(
                            iconName: _sortAscending
                                ? 'keyboard_arrow_up'
                                : 'keyboard_arrow_down',
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  GestureDetector(
                    onTap: widget.onExport,
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: CustomIconWidget(
                        iconName: 'file_download',
                        color: colorScheme.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header row
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.05),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Department',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Performance',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Budget',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Trend',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Data rows
                  ...sortedData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final department = entry.value;
                    final isEven = index % 2 == 0;

                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: isEven
                            ? colorScheme.surface
                            : colorScheme.primary.withValues(alpha: 0.02),
                        border: Border(
                          bottom: BorderSide(
                            color: colorScheme.outline.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  department['name'] as String,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  '${department['employees']} employees',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text(
                                  '${department['performance']}%',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: _getPerformanceColor(
                                      department['performance'] as int,
                                      colorScheme,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                LinearProgressIndicator(
                                  value:
                                      (department['performance'] as int) / 100,
                                  backgroundColor: colorScheme.outline
                                      .withValues(alpha: 0.2),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    _getPerformanceColor(
                                      department['performance'] as int,
                                      colorScheme,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text(
                                  department['budget'] as String,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  '${department['budgetUsed']}% used',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 4.h,
                              child: _buildSparkline(
                                department['trendData'] as List<double>,
                                colorScheme,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getSortedData() {
    final data = List<Map<String, dynamic>>.from(widget.departmentData);

    data.sort((a, b) {
      dynamic aValue, bValue;

      switch (_sortBy) {
        case 'performance':
          aValue = a['performance'] as int;
          bValue = b['performance'] as int;
          break;
        case 'budget':
          aValue = a['budgetUsed'] as int;
          bValue = b['budgetUsed'] as int;
          break;
        case 'employees':
          aValue = a['employees'] as int;
          bValue = b['employees'] as int;
          break;
        default:
          aValue = a['name'] as String;
          bValue = b['name'] as String;
      }

      final comparison =
          _sortAscending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);

      return comparison;
    });

    return data;
  }

  Color _getPerformanceColor(int performance, ColorScheme colorScheme) {
    if (performance >= 90) {
      return colorScheme.primary;
    } else if (performance >= 70) {
      return colorScheme.tertiary;
    } else {
      return colorScheme.error;
    }
  }

  Widget _buildSparkline(List<double> data, ColorScheme colorScheme) {
    if (data.isEmpty) return const SizedBox.shrink();

    final isPositiveTrend = data.last > data.first;

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (data.length - 1).toDouble(),
        minY: data.reduce((a, b) => a < b ? a : b),
        maxY: data.reduce((a, b) => a > b ? a : b),
        lineBarsData: [
          LineChartBarData(
            spots: data.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value);
            }).toList(),
            isCurved: true,
            color: isPositiveTrend ? colorScheme.primary : colorScheme.error,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
          ),
        ],
        lineTouchData: const LineTouchData(enabled: false),
      ),
    );
  }
}

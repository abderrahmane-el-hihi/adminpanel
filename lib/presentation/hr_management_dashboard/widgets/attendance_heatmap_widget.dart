import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AttendanceHeatmapWidget extends StatefulWidget {
  final Function(DateTime)? onDateSelected;

  const AttendanceHeatmapWidget({
    super.key,
    this.onDateSelected,
  });

  @override
  State<AttendanceHeatmapWidget> createState() =>
      _AttendanceHeatmapWidgetState();
}

class _AttendanceHeatmapWidgetState extends State<AttendanceHeatmapWidget> {
  DateTime selectedDate = DateTime.now();
  late DateTime currentMonth;

  final List<Map<String, dynamic>> attendanceData = [
    {"date": DateTime(2025, 8, 1), "attendance": 95, "absent": 5, "late": 2},
    {"date": DateTime(2025, 8, 2), "attendance": 92, "absent": 8, "late": 4},
    {"date": DateTime(2025, 8, 3), "attendance": 88, "absent": 12, "late": 6},
    {"date": DateTime(2025, 8, 4), "attendance": 90, "absent": 10, "late": 3},
    {"date": DateTime(2025, 8, 5), "attendance": 94, "absent": 6, "late": 2},
    {"date": DateTime(2025, 8, 6), "attendance": 89, "absent": 11, "late": 5},
    {"date": DateTime(2025, 8, 7), "attendance": 96, "absent": 4, "late": 1},
    {"date": DateTime(2025, 8, 8), "attendance": 91, "absent": 9, "late": 4},
    {"date": DateTime(2025, 8, 9), "attendance": 93, "absent": 7, "late": 3},
    {"date": DateTime(2025, 8, 10), "attendance": 87, "absent": 13, "late": 7},
    {"date": DateTime(2025, 8, 11), "attendance": 95, "absent": 5, "late": 2},
    {"date": DateTime(2025, 8, 12), "attendance": 92, "absent": 8, "late": 4},
    {"date": DateTime(2025, 8, 13), "attendance": 90, "absent": 10, "late": 3},
    {"date": DateTime(2025, 8, 14), "attendance": 94, "absent": 6, "late": 2},
    {"date": DateTime(2025, 8, 15), "attendance": 88, "absent": 12, "late": 6},
    {"date": DateTime(2025, 8, 16), "attendance": 96, "absent": 4, "late": 1},
    {"date": DateTime(2025, 8, 17), "attendance": 91, "absent": 9, "late": 4},
    {"date": DateTime(2025, 8, 18), "attendance": 93, "absent": 7, "late": 3},
    {"date": DateTime(2025, 8, 19), "attendance": 89, "absent": 11, "late": 5},
    {"date": DateTime(2025, 8, 20), "attendance": 95, "absent": 5, "late": 2},
  ];

  @override
  void initState() {
    super.initState();
    currentMonth = DateTime(selectedDate.year, selectedDate.month);
  }

  Color _getAttendanceColor(int attendance) {
    if (attendance >= 95) return AppTheme.lightTheme.colorScheme.primary;
    if (attendance >= 90)
      return AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.7);
    if (attendance >= 85)
      return AppTheme.lightTheme.colorScheme.tertiary.withValues(alpha: 0.6);
    return AppTheme.lightTheme.colorScheme.error.withValues(alpha: 0.5);
  }

  void _navigateMonth(bool isNext) {
    setState(() {
      currentMonth = DateTime(
        currentMonth.year,
        currentMonth.month + (isNext ? 1 : -1),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 2.h),
          _buildCalendarGrid(),
          SizedBox(height: 2.h),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Attendance Heatmap',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => _navigateMonth(false),
              icon: CustomIconWidget(
                iconName: 'chevron_left',
                size: 6.w,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            Text(
              '${_getMonthName(currentMonth.month)} ${currentMonth.year}',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              onPressed: () => _navigateMonth(true),
              icon: CustomIconWidget(
                iconName: 'chevron_right',
                size: 6.w,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    final firstDayOfWeek =
        DateTime(currentMonth.year, currentMonth.month, 1).weekday;

    return Column(
      children: [
        // Week day headers
        Row(
          children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
              .map((day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.lightTheme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 1.h),
        // Calendar grid
        ...List.generate(6, (weekIndex) {
          return Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Row(
              children: List.generate(7, (dayIndex) {
                final dayNumber = weekIndex * 7 + dayIndex - firstDayOfWeek + 2;

                if (dayNumber <= 0 || dayNumber > daysInMonth) {
                  return Expanded(child: Container());
                }

                final date =
                    DateTime(currentMonth.year, currentMonth.month, dayNumber);
                final attendanceInfo = attendanceData.firstWhere(
                  (data) =>
                      (data['date'] as DateTime).day == dayNumber &&
                      (data['date'] as DateTime).month == currentMonth.month,
                  orElse: () => {"attendance": 0, "absent": 0, "late": 0},
                );

                final attendance = attendanceInfo['attendance'] as int;
                final isSelected = selectedDate.day == dayNumber &&
                    selectedDate.month == currentMonth.month &&
                    selectedDate.year == currentMonth.year;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                      widget.onDateSelected?.call(date);
                    },
                    child: Container(
                      height: 8.w,
                      margin: EdgeInsets.all(0.5.w),
                      decoration: BoxDecoration(
                        color: attendance > 0
                            ? _getAttendanceColor(attendance)
                            : AppTheme.lightTheme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(1.w),
                        border: isSelected
                            ? Border.all(
                                color: AppTheme.lightTheme.colorScheme.primary,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          dayNumber.toString(),
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: attendance > 0
                                ? Colors.white
                                : AppTheme.lightTheme.colorScheme.onSurface,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Less',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface
                .withValues(alpha: 0.6),
          ),
        ),
        Row(
          children: [
            _buildLegendItem(AppTheme.lightTheme.colorScheme.surface, '< 85%'),
            SizedBox(width: 1.w),
            _buildLegendItem(
                AppTheme.lightTheme.colorScheme.error.withValues(alpha: 0.5),
                '85-89%'),
            SizedBox(width: 1.w),
            _buildLegendItem(
                AppTheme.lightTheme.colorScheme.tertiary.withValues(alpha: 0.6),
                '90-94%'),
            SizedBox(width: 1.w),
            _buildLegendItem(
                AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.7),
                '95-99%'),
            SizedBox(width: 1.w),
            _buildLegendItem(AppTheme.lightTheme.colorScheme.primary, '100%'),
          ],
        ),
        Text(
          'More',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface
                .withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 3.w,
        height: 3.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(0.5.w),
          border: Border.all(
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class HrGlobalControlsWidget extends StatefulWidget {
  final Function(String)? onEmployeeGroupChanged;
  final Function(String)? onPayPeriodChanged;
  final Function(String)? onLocationChanged;

  const HrGlobalControlsWidget({
    super.key,
    this.onEmployeeGroupChanged,
    this.onPayPeriodChanged,
    this.onLocationChanged,
  });

  @override
  State<HrGlobalControlsWidget> createState() => _HrGlobalControlsWidgetState();
}

class _HrGlobalControlsWidgetState extends State<HrGlobalControlsWidget> {
  String selectedEmployeeGroup = 'All Employees';
  String selectedPayPeriod = 'Current Month';
  String selectedLocation = 'All Locations';

  final List<String> employeeGroups = [
    'All Employees',
    'Full-time',
    'Part-time',
    'Contractors',
    'Interns',
    'Remote Workers',
  ];

  final List<String> payPeriods = [
    'Current Month',
    'Last Month',
    'Current Quarter',
    'Last Quarter',
    'Current Year',
    'Custom Range',
  ];

  final List<String> locations = [
    'All Locations',
    'New York Office',
    'San Francisco Office',
    'London Office',
    'Remote',
    'Chicago Office',
  ];

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
          SizedBox(height: 3.h),
          _buildControlsRow(),
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
              'HR Management Dashboard',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              'Comprehensive workforce analytics and monitoring',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                // Refresh data
              },
              icon: CustomIconWidget(
                iconName: 'refresh',
                size: 6.w,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: () {
                // Export data
              },
              icon: CustomIconWidget(
                iconName: 'download',
                size: 6.w,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: () {
                // Settings
              },
              icon: CustomIconWidget(
                iconName: 'settings',
                size: 6.w,
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildControlsRow() {
    return 100.w > 600
        ? Row(
            children: [
              Expanded(child: _buildEmployeeGroupFilter()),
              SizedBox(width: 3.w),
              Expanded(child: _buildPayPeriodFilter()),
              SizedBox(width: 3.w),
              Expanded(child: _buildLocationFilter()),
            ],
          )
        : Column(
            children: [
              _buildEmployeeGroupFilter(),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(child: _buildPayPeriodFilter()),
                  SizedBox(width: 3.w),
                  Expanded(child: _buildLocationFilter()),
                ],
              ),
            ],
          );
  }

  Widget _buildEmployeeGroupFilter() {
    return _buildFilterDropdown(
      title: 'Employee Group',
      value: selectedEmployeeGroup,
      items: employeeGroups,
      icon: 'group',
      onChanged: (value) {
        setState(() {
          selectedEmployeeGroup = value;
        });
        widget.onEmployeeGroupChanged?.call(value);
      },
    );
  }

  Widget _buildPayPeriodFilter() {
    return _buildFilterDropdown(
      title: 'Pay Period',
      value: selectedPayPeriod,
      items: payPeriods,
      icon: 'calendar_today',
      onChanged: (value) {
        setState(() {
          selectedPayPeriod = value;
        });
        widget.onPayPeriodChanged?.call(value);
      },
    );
  }

  Widget _buildLocationFilter() {
    return _buildFilterDropdown(
      title: 'Location',
      value: selectedLocation,
      items: locations,
      icon: 'location_on',
      onChanged: (value) {
        setState(() {
          selectedLocation = value;
        });
        widget.onLocationChanged?.call(value);
      },
    );
  }

  Widget _buildFilterDropdown({
    required String title,
    required String value,
    required List<String> items,
    required String icon,
    required Function(String) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: icon,
                size: 4.w,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
              SizedBox(width: 2.w),
              Text(
                title,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: CustomIconWidget(
                iconName: 'keyboard_arrow_down',
                size: 5.w,
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.6),
              ),
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
              dropdownColor: AppTheme.lightTheme.colorScheme.surface,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
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
}

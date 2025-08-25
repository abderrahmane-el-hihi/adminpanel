import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmployeePerformanceGridWidget extends StatefulWidget {
  final Function(Map<String, dynamic>)? onEmployeeSelected;

  const EmployeePerformanceGridWidget({
    super.key,
    this.onEmployeeSelected,
  });

  @override
  State<EmployeePerformanceGridWidget> createState() =>
      _EmployeePerformanceGridWidgetState();
}

class _EmployeePerformanceGridWidgetState
    extends State<EmployeePerformanceGridWidget> {
  String selectedFilter = 'All';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> employeeData = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "position": "Senior Developer",
      "department": "Engineering",
      "photo":
          "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face",
      "performance": 95,
      "attendance": 98,
      "projects": 12,
      "status": "Active",
      "lastActive": "2 hours ago",
      "email": "sarah.johnson@company.com",
      "phone": "+1 (555) 123-4567",
    },
    {
      "id": 2,
      "name": "Michael Chen",
      "position": "Product Manager",
      "department": "Product",
      "photo":
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face",
      "performance": 92,
      "attendance": 95,
      "projects": 8,
      "status": "Active",
      "lastActive": "1 hour ago",
      "email": "michael.chen@company.com",
      "phone": "+1 (555) 234-5678",
    },
    {
      "id": 3,
      "name": "Emily Rodriguez",
      "position": "UX Designer",
      "department": "Design",
      "photo":
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face",
      "performance": 88,
      "attendance": 92,
      "projects": 15,
      "status": "Active",
      "lastActive": "30 minutes ago",
      "email": "emily.rodriguez@company.com",
      "phone": "+1 (555) 345-6789",
    },
    {
      "id": 4,
      "name": "David Thompson",
      "position": "Sales Manager",
      "department": "Sales",
      "photo":
          "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face",
      "performance": 94,
      "attendance": 89,
      "projects": 6,
      "status": "On Leave",
      "lastActive": "2 days ago",
      "email": "david.thompson@company.com",
      "phone": "+1 (555) 456-7890",
    },
    {
      "id": 5,
      "name": "Lisa Wang",
      "position": "HR Specialist",
      "department": "Human Resources",
      "photo":
          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face",
      "performance": 90,
      "attendance": 96,
      "projects": 10,
      "status": "Active",
      "lastActive": "15 minutes ago",
      "email": "lisa.wang@company.com",
      "phone": "+1 (555) 567-8901",
    },
    {
      "id": 6,
      "name": "James Wilson",
      "position": "Marketing Director",
      "department": "Marketing",
      "photo":
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face",
      "performance": 87,
      "attendance": 93,
      "projects": 9,
      "status": "Active",
      "lastActive": "45 minutes ago",
      "email": "james.wilson@company.com",
      "phone": "+1 (555) 678-9012",
    },
  ];

  List<Map<String, dynamic>> get filteredEmployees {
    List<Map<String, dynamic>> filtered = employeeData;

    if (selectedFilter != 'All') {
      filtered = filtered
          .where((employee) =>
              (employee['department'] as String) == selectedFilter)
          .toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((employee) =>
              (employee['name'] as String)
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              (employee['position'] as String)
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    }

    return filtered;
  }

  Color _getPerformanceColor(int performance) {
    if (performance >= 90) return AppTheme.lightTheme.colorScheme.primary;
    if (performance >= 80) return AppTheme.lightTheme.colorScheme.tertiary;
    return AppTheme.lightTheme.colorScheme.error;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return AppTheme.lightTheme.colorScheme.primary;
      case 'On Leave':
        return AppTheme.lightTheme.colorScheme.tertiary;
      default:
        return AppTheme.lightTheme.colorScheme.error;
    }
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
          _buildFilters(),
          SizedBox(height: 2.h),
          _buildEmployeeGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Employee Performance',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                // Export functionality
              },
              icon: CustomIconWidget(
                iconName: 'download',
                size: 6.w,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: () {
                // Add employee functionality
              },
              icon: CustomIconWidget(
                iconName: 'person_add',
                size: 6.w,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilters() {
    final departments = [
      'All',
      'Engineering',
      'Product',
      'Design',
      'Sales',
      'Human Resources',
      'Marketing'
    ];

    return Column(
      children: [
        // Search bar
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(2.w),
            border: Border.all(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.3),
            ),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search employees...',
              border: InputBorder.none,
              prefixIcon: CustomIconWidget(
                iconName: 'search',
                size: 5.w,
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.6),
              ),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          searchQuery = '';
                        });
                      },
                      icon: CustomIconWidget(
                        iconName: 'clear',
                        size: 5.w,
                        color: AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.6),
                      ),
                    )
                  : null,
            ),
          ),
        ),
        SizedBox(height: 2.h),
        // Department filters
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: departments.map((department) {
              final isSelected = selectedFilter == department;
              return Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilter = department;
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(5.w),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.outline
                                .withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      department,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? AppTheme.lightTheme.colorScheme.onPrimary
                            : AppTheme.lightTheme.colorScheme.onSurface,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeeGrid() {
    final employees = filteredEmployees;

    return employees.isEmpty
        ? _buildEmptyState()
        : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 100.w > 600 ? 2 : 1,
              childAspectRatio: 100.w > 600 ? 1.2 : 2.5,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 2.h,
            ),
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employee = employees[index];
              return _buildEmployeeCard(employee);
            },
          );
  }

  Widget _buildEmployeeCard(Map<String, dynamic> employee) {
    return GestureDetector(
      onTap: () => widget.onEmployeeSelected?.call(employee),
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(3.w),
          border: Border.all(
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.shadow
                  .withValues(alpha: 0.05),
              offset: const Offset(0, 1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Employee photo
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.w),
                    border: Border.all(
                      color: _getStatusColor(employee['status'] as String),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.w),
                    child: CustomImageWidget(
                      imageUrl: employee['photo'] as String,
                      width: 12.w,
                      height: 12.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee['name'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        employee['position'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onSurface
                              .withValues(alpha: 0.7),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        employee['department'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: _getStatusColor(employee['status'] as String)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(1.w),
                  ),
                  child: Text(
                    employee['status'] as String,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: _getStatusColor(employee['status'] as String),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            // Performance metrics
            Row(
              children: [
                Expanded(
                  child: _buildMetricItem(
                    'Performance',
                    '${employee['performance']}%',
                    _getPerformanceColor(employee['performance'] as int),
                  ),
                ),
                Expanded(
                  child: _buildMetricItem(
                    'Attendance',
                    '${employee['attendance']}%',
                    _getPerformanceColor(employee['attendance'] as int),
                  ),
                ),
                Expanded(
                  child: _buildMetricItem(
                    'Projects',
                    '${employee['projects']}',
                    AppTheme.lightTheme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            // Quick actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Last active: ${employee['lastActive']}',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.6),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Call employee
                      },
                      icon: CustomIconWidget(
                        iconName: 'phone',
                        size: 5.w,
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Email employee
                      },
                      icon: CustomIconWidget(
                        iconName: 'email',
                        size: 5.w,
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // More options
                      },
                      icon: CustomIconWidget(
                        iconName: 'more_vert',
                        size: 5.w,
                        color: AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface
                .withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 30.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'search_off',
              size: 15.w,
              color: AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.3),
            ),
            SizedBox(height: 2.h),
            Text(
              'No employees found',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Try adjusting your search or filters',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

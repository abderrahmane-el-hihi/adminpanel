import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OperationsTableWidget extends StatefulWidget {
  const OperationsTableWidget({super.key});

  @override
  State<OperationsTableWidget> createState() => _OperationsTableWidgetState();
}

class _OperationsTableWidgetState extends State<OperationsTableWidget> {
  final List<Map<String, dynamic>> operationsData = [
    {
      "id": "PO-2024-0892",
      "type": "Purchase Order",
      "description": "Office supplies and equipment procurement",
      "status": "Pending Approval",
      "priority": "High",
      "assignee": "Michael Chen",
      "amount": "\$12,450.00",
      "dueDate": DateTime.now().add(const Duration(hours: 6)),
      "vendor": "Office Solutions Inc.",
      "category": "Purchasing",
      "progress": 0.75,
    },
    {
      "id": "PRJ-2024-0156",
      "type": "Project Milestone",
      "description": "Q4 inventory system upgrade completion",
      "status": "In Progress",
      "priority": "Medium",
      "assignee": "Sarah Johnson",
      "amount": "\$45,000.00",
      "dueDate": DateTime.now().add(const Duration(days: 3)),
      "vendor": "TechSolutions Ltd.",
      "category": "IT Operations",
      "progress": 0.60,
    },
    {
      "id": "VR-2024-0089",
      "type": "Vendor Review",
      "description": "Quarterly performance evaluation",
      "status": "Scheduled",
      "priority": "Medium",
      "assignee": "Emily Rodriguez",
      "amount": "-",
      "dueDate": DateTime.now().add(const Duration(days: 5)),
      "vendor": "Global Supplies Co.",
      "category": "Vendor Management",
      "progress": 0.25,
    },
    {
      "id": "INV-2024-0234",
      "type": "Inventory Audit",
      "description": "Electronics department stock verification",
      "status": "Completed",
      "priority": "Low",
      "assignee": "David Kim",
      "amount": "-",
      "dueDate": DateTime.now().subtract(const Duration(days: 1)),
      "vendor": "-",
      "category": "Inventory",
      "progress": 1.0,
    },
    {
      "id": "PO-2024-0893",
      "type": "Purchase Order",
      "description": "Raw materials for production line",
      "status": "Urgent Review",
      "priority": "Urgent",
      "assignee": "Lisa Wang",
      "amount": "\$28,750.00",
      "dueDate": DateTime.now().add(const Duration(hours: 2)),
      "vendor": "Industrial Materials Corp.",
      "category": "Purchasing",
      "progress": 0.90,
    },
    {
      "id": "QC-2024-0067",
      "type": "Quality Check",
      "description": "Incoming shipment quality verification",
      "status": "In Progress",
      "priority": "High",
      "assignee": "Robert Taylor",
      "amount": "-",
      "dueDate": DateTime.now().add(const Duration(hours: 8)),
      "vendor": "Quality First Suppliers",
      "category": "Quality Assurance",
      "progress": 0.40,
    },
  ];

  String selectedFilter = "All";
  String sortBy = "dueDate";
  bool sortAscending = true;
  final List<String> filterOptions = [
    "All",
    "Pending Approval",
    "In Progress",
    "Urgent Review",
    "Completed"
  ];
  final List<String> sortOptions = ["dueDate", "priority", "status", "amount"];

  @override
  Widget build(BuildContext context) {
    final filteredData = _getFilteredAndSortedData();

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
          SizedBox(height: 2.h),
          _buildFiltersAndSort(),
          SizedBox(height: 2.h),
          _buildTableHeader(),
          SizedBox(height: 1.h),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                return _buildTableRow(filteredData[index], index);
              },
            ),
          ),
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
              'Operations Management',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Purchase orders, projects, and vendor status',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondaryLight,
              ),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () => _exportData(),
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.secondary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: 'download',
                  color: AppTheme.lightTheme.colorScheme.secondary,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: 2.w),
            GestureDetector(
              onTap: () => _refreshData(),
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: 'refresh',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFiltersAndSort() {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filterOptions.map((filter) {
                final isSelected = selectedFilter == filter;
                return GestureDetector(
                  onTap: () => setState(() => selectedFilter = filter),
                  child: Container(
                    margin: EdgeInsets.only(right: 2.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.borderLight,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      filter,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: isSelected
                            ? AppTheme.lightTheme.colorScheme.onPrimary
                            : AppTheme.textSecondaryLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(width: 2.w),
        GestureDetector(
          onTap: () => _showSortOptions(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.borderLight,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconWidget(
                  iconName: sortAscending ? 'arrow_upward' : 'arrow_downward',
                  color: AppTheme.textSecondaryLight,
                  size: 16,
                ),
                SizedBox(width: 1.w),
                Text(
                  'Sort',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Operation',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondaryLight,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Status',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondaryLight,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Assignee',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondaryLight,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Actions',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(Map<String, dynamic> operation, int index) {
    final statusColor = _getStatusColor(operation["status"] as String);
    final priorityColor = _getPriorityColor(operation["priority"] as String);
    final dueDate = operation["dueDate"] as DateTime;
    final isOverdue =
        dueDate.isBefore(DateTime.now()) && operation["status"] != "Completed";
    final progress = operation["progress"] as double;

    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isOverdue
              ? AppTheme.errorLight
              : AppTheme.borderLight.withValues(alpha: 0.3),
          width: isOverdue ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: priorityColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            operation["priority"] as String,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: priorityColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          operation["id"] as String,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      operation["type"] as String,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      operation["description"] as String,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondaryLight,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (operation["amount"] != "-") ...[
                      SizedBox(height: 0.5.h),
                      Text(
                        operation["amount"] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.lightTheme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        operation["status"] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    if (progress > 0 && progress < 1) ...[
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: AppTheme.borderLight,
                        valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                        minHeight: 0.5.h,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        '${(progress * 100).toInt()}% Complete',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondaryLight,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      operation["assignee"] as String,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'schedule',
                          color: isOverdue
                              ? AppTheme.errorLight
                              : AppTheme.textSecondaryLight,
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          _formatDueDate(dueDate),
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: isOverdue
                                ? AppTheme.errorLight
                                : AppTheme.textSecondaryLight,
                            fontWeight:
                                isOverdue ? FontWeight.w600 : FontWeight.w400,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    if (operation["vendor"] != "-") ...[
                      SizedBox(height: 0.5.h),
                      Text(
                        operation["vendor"] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondaryLight,
                          fontSize: 10.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _handleAction(operation),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _getActionText(operation["status"] as String),
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    GestureDetector(
                      onTap: () => _viewDetails(operation),
                      child: CustomIconWidget(
                        iconName: 'visibility',
                        color: AppTheme.textSecondaryLight,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredAndSortedData() {
    var filtered = selectedFilter == "All"
        ? operationsData
        : operationsData
            .where((item) => item["status"] == selectedFilter)
            .toList();

    filtered.sort((a, b) {
      dynamic aValue = a[sortBy];
      dynamic bValue = b[sortBy];

      if (sortBy == "dueDate") {
        aValue = (aValue as DateTime).millisecondsSinceEpoch;
        bValue = (bValue as DateTime).millisecondsSinceEpoch;
      } else if (sortBy == "amount") {
        aValue = aValue == "-"
            ? 0
            : double.tryParse(
                    (aValue as String).replaceAll(RegExp(r'[^\d.]'), '')) ??
                0;
        bValue = bValue == "-"
            ? 0
            : double.tryParse(
                    (bValue as String).replaceAll(RegExp(r'[^\d.]'), '')) ??
                0;
      }

      return sortAscending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return AppTheme.successLight;
      case 'In Progress':
        return AppTheme.lightTheme.colorScheme.primary;
      case 'Pending Approval':
        return AppTheme.accentLight;
      case 'Urgent Review':
        return AppTheme.errorLight;
      case 'Scheduled':
        return AppTheme.lightTheme.colorScheme.secondary;
      default:
        return AppTheme.textSecondaryLight;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Urgent':
        return AppTheme.errorLight;
      case 'High':
        return AppTheme.accentLight;
      case 'Medium':
        return AppTheme.lightTheme.colorScheme.secondary;
      case 'Low':
        return AppTheme.successLight;
      default:
        return AppTheme.textSecondaryLight;
    }
  }

  String _formatDueDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.isNegative) {
      return 'Overdue';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return '${date.month}/${date.day}';
    }
  }

  String _getActionText(String status) {
    switch (status) {
      case 'Pending Approval':
        return 'Approve';
      case 'In Progress':
        return 'Update';
      case 'Urgent Review':
        return 'Review';
      case 'Scheduled':
        return 'Start';
      case 'Completed':
        return 'View';
      default:
        return 'Action';
    }
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sort Options',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            ...sortOptions.map((option) {
              return ListTile(
                title: Text(_getSortOptionLabel(option)),
                leading: Radio<String>(
                  value: option,
                  groupValue: sortBy,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        sortBy = value;
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
              );
            }).toList(),
            SizedBox(height: 1.h),
            SwitchListTile(
              title: const Text('Ascending Order'),
              value: sortAscending,
              onChanged: (value) {
                setState(() {
                  sortAscending = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getSortOptionLabel(String option) {
    switch (option) {
      case 'dueDate':
        return 'Due Date';
      case 'priority':
        return 'Priority';
      case 'status':
        return 'Status';
      case 'amount':
        return 'Amount';
      default:
        return option;
    }
  }

  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Exporting operations data...'),
        backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _refreshData() {
    setState(() {
      // Simulate data refresh
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Operations data refreshed'),
        backgroundColor: AppTheme.successLight,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleAction(Map<String, dynamic> operation) {
    final action = _getActionText(operation["status"] as String);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action action for ${operation["id"]}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _viewDetails(Map<String, dynamic> operation) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 10.w,
              height: 0.5.h,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.borderLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Operation Details',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.textSecondaryLight,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      operation["id"] as String,
                      style:
                          AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      operation["description"] as String,
                      style: AppTheme.lightTheme.textTheme.bodyLarge,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Detailed information and actions would be displayed here.',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

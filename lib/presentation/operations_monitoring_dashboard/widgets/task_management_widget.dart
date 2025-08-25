import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TaskManagementWidget extends StatefulWidget {
  const TaskManagementWidget({super.key});

  @override
  State<TaskManagementWidget> createState() => _TaskManagementWidgetState();
}

class _TaskManagementWidgetState extends State<TaskManagementWidget> {
  List<Map<String, dynamic>> tasks = [
    {
      "id": 1,
      "title": "Inventory Audit - Electronics",
      "description": "Complete quarterly audit of electronics inventory",
      "priority": "High",
      "status": "In Progress",
      "assignee": "Sarah Johnson",
      "dueDate": DateTime.now().add(const Duration(days: 2)),
      "progress": 0.65,
      "category": "Inventory",
    },
    {
      "id": 2,
      "title": "Purchase Order Approval",
      "description": "Review and approve PO #2024-0892 for office supplies",
      "priority": "Urgent",
      "status": "Pending",
      "assignee": "Michael Chen",
      "dueDate": DateTime.now().add(const Duration(hours: 4)),
      "progress": 0.0,
      "category": "Purchasing",
    },
    {
      "id": 3,
      "title": "Vendor Performance Review",
      "description": "Quarterly review of top 5 vendors performance metrics",
      "priority": "Medium",
      "status": "Not Started",
      "assignee": "Emily Rodriguez",
      "dueDate": DateTime.now().add(const Duration(days: 7)),
      "progress": 0.0,
      "category": "Vendor Management",
    },
    {
      "id": 4,
      "title": "System Maintenance",
      "description": "Scheduled maintenance for inventory management system",
      "priority": "High",
      "status": "Scheduled",
      "assignee": "David Kim",
      "dueDate": DateTime.now().add(const Duration(days: 1)),
      "progress": 0.25,
      "category": "IT Operations",
    },
    {
      "id": 5,
      "title": "Quality Control Check",
      "description": "Random quality check on incoming raw materials",
      "priority": "Medium",
      "status": "Completed",
      "assignee": "Lisa Wang",
      "dueDate": DateTime.now().subtract(const Duration(days: 1)),
      "progress": 1.0,
      "category": "Quality Assurance",
    },
  ];

  String selectedFilter = "All";
  final List<String> filterOptions = ["All", "High", "Urgent", "Medium", "Low"];

  @override
  Widget build(BuildContext context) {
    final filteredTasks = selectedFilter == "All"
        ? tasks
        : tasks.where((task) => task["priority"] == selectedFilter).toList();

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Task Management',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => _showAddTaskDialog(context),
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName: 'add',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _buildFilterChips(),
          SizedBox(height: 2.h),
          _buildTaskStats(filteredTasks),
          SizedBox(height: 2.h),
          Expanded(
            child: ReorderableListView.builder(
              itemCount: filteredTasks.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final item = filteredTasks.removeAt(oldIndex);
                  filteredTasks.insert(newIndex, item);
                });
              },
              itemBuilder: (context, index) {
                final task = filteredTasks[index];
                return _buildTaskCard(task, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filterOptions.map((filter) {
          final isSelected = selectedFilter == filter;
          return GestureDetector(
            onTap: () => setState(() => selectedFilter = filter),
            child: Container(
              margin: EdgeInsets.only(right: 2.w),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
    );
  }

  Widget _buildTaskStats(List<Map<String, dynamic>> filteredTasks) {
    final totalTasks = filteredTasks.length;
    final completedTasks =
        filteredTasks.where((task) => task["status"] == "Completed").length;
    final inProgressTasks =
        filteredTasks.where((task) => task["status"] == "In Progress").length;
    final pendingTasks =
        filteredTasks.where((task) => task["status"] == "Pending").length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
              "Total", totalTasks, AppTheme.lightTheme.colorScheme.primary),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: _buildStatCard(
              "Completed", completedTasks, AppTheme.successLight),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: _buildStatCard(
              "In Progress", inProgressTasks, AppTheme.accentLight),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: _buildStatCard("Pending", pendingTasks, AppTheme.errorLight),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task, int index) {
    final priorityColor = _getPriorityColor(task["priority"] as String);
    final statusColor = _getStatusColor(task["status"] as String);
    final progress = task["progress"] as double;
    final dueDate = task["dueDate"] as DateTime;
    final isOverdue =
        dueDate.isBefore(DateTime.now()) && task["status"] != "Completed";

    return Card(
      key: ValueKey(task["id"]),
      margin: EdgeInsets.only(bottom: 2.h),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isOverdue ? AppTheme.errorLight : Colors.transparent,
          width: isOverdue ? 2 : 0,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
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
                              task["priority"] as String,
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: priorityColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              task["status"] as String,
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                          if (isOverdue) ...[
                            SizedBox(width: 2.w),
                            CustomIconWidget(
                              iconName: 'warning',
                              color: AppTheme.errorLight,
                              size: 16,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        task["title"] as String,
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        task["description"] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondaryLight,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                CustomIconWidget(
                  iconName: 'drag_handle',
                  color: AppTheme.textSecondaryLight,
                  size: 20,
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'person',
                  color: AppTheme.textSecondaryLight,
                  size: 16,
                ),
                SizedBox(width: 1.w),
                Text(
                  task["assignee"] as String,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondaryLight,
                  ),
                ),
                const Spacer(),
                CustomIconWidget(
                  iconName: 'schedule',
                  color: isOverdue
                      ? AppTheme.errorLight
                      : AppTheme.textSecondaryLight,
                  size: 16,
                ),
                SizedBox(width: 1.w),
                Text(
                  _formatDueDate(dueDate),
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: isOverdue
                        ? AppTheme.errorLight
                        : AppTheme.textSecondaryLight,
                    fontWeight: isOverdue ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
            if (progress > 0) ...[
              SizedBox(height: 1.h),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: AppTheme.borderLight,
                      valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                      minHeight: 0.5.h,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: 1.h),
            Row(
              children: [
                Text(
                  task["category"] as String,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => _updateTaskStatus(task),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Update',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return AppTheme.successLight;
      case 'In Progress':
        return AppTheme.lightTheme.colorScheme.primary;
      case 'Pending':
        return AppTheme.accentLight;
      case 'Scheduled':
        return AppTheme.lightTheme.colorScheme.secondary;
      case 'Not Started':
        return AppTheme.textSecondaryLight;
      default:
        return AppTheme.textSecondaryLight;
    }
  }

  String _formatDueDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.isNegative) {
      return 'Overdue';
    } else if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Tomorrow';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
        content: const Text(
            'Task creation functionality would be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }

  void _updateTaskStatus(Map<String, dynamic> task) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Update Task Status',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            const Text(
                'Status update functionality would be implemented here.'),
            SizedBox(height: 2.h),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}

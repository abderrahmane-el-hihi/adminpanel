import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PendingApprovalsWidget extends StatefulWidget {
  final Function(Map<String, dynamic>, String)? onApprovalAction;

  const PendingApprovalsWidget({
    super.key,
    this.onApprovalAction,
  });

  @override
  State<PendingApprovalsWidget> createState() => _PendingApprovalsWidgetState();
}

class _PendingApprovalsWidgetState extends State<PendingApprovalsWidget> {
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> pendingApprovals = [
    {
      "id": 1,
      "type": "Leave Request",
      "employee": "Sarah Johnson",
      "employeePhoto":
          "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face",
      "department": "Engineering",
      "requestDate": "Aug 18, 2025",
      "startDate": "Aug 25, 2025",
      "endDate": "Aug 29, 2025",
      "duration": "5 days",
      "reason": "Family vacation",
      "priority": "Medium",
      "status": "Pending",
      "description":
          "Annual family vacation to Hawaii. All project deliverables will be completed before departure.",
    },
    {
      "id": 2,
      "type": "Overtime Request",
      "employee": "Michael Chen",
      "employeePhoto":
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face",
      "department": "Product",
      "requestDate": "Aug 19, 2025",
      "startDate": "Aug 21, 2025",
      "endDate": "Aug 21, 2025",
      "duration": "4 hours",
      "reason": "Product launch preparation",
      "priority": "High",
      "status": "Pending",
      "description":
          "Need to complete final testing and documentation for product launch scheduled for next week.",
    },
    {
      "id": 3,
      "type": "Training Request",
      "employee": "Emily Rodriguez",
      "employeePhoto":
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face",
      "department": "Design",
      "requestDate": "Aug 17, 2025",
      "startDate": "Sep 2, 2025",
      "endDate": "Sep 6, 2025",
      "duration": "5 days",
      "reason": "UX Design Certification",
      "priority": "Medium",
      "status": "Pending",
      "description":
          "Advanced UX Design certification course to enhance skills in user research and prototyping.",
    },
    {
      "id": 4,
      "type": "Remote Work",
      "employee": "David Thompson",
      "employeePhoto":
          "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face",
      "department": "Sales",
      "requestDate": "Aug 20, 2025",
      "startDate": "Aug 22, 2025",
      "endDate": "Aug 26, 2025",
      "duration": "5 days",
      "reason": "Client meetings in different city",
      "priority": "High",
      "status": "Pending",
      "description":
          "Important client meetings scheduled in Chicago. Remote work will allow for better client service.",
    },
    {
      "id": 5,
      "type": "Equipment Request",
      "employee": "Lisa Wang",
      "employeePhoto":
          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face",
      "department": "Human Resources",
      "requestDate": "Aug 16, 2025",
      "startDate": "Aug 23, 2025",
      "endDate": "Aug 23, 2025",
      "duration": "1 day",
      "reason": "New laptop for presentations",
      "priority": "Low",
      "status": "Pending",
      "description":
          "Current laptop is outdated and causing issues during client presentations and video calls.",
    },
  ];

  List<Map<String, dynamic>> get filteredApprovals {
    if (selectedFilter == 'All') {
      return pendingApprovals;
    }
    return pendingApprovals
        .where((approval) => (approval['type'] as String) == selectedFilter)
        .toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return AppTheme.lightTheme.colorScheme.error;
      case 'Medium':
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 'Low':
        return AppTheme.lightTheme.colorScheme.primary;
      default:
        return AppTheme.lightTheme.colorScheme.onSurface;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'Leave Request':
        return Icons.event_busy;
      case 'Overtime Request':
        return Icons.access_time;
      case 'Training Request':
        return Icons.school;
      case 'Remote Work':
        return Icons.home_work;
      case 'Equipment Request':
        return Icons.computer;
      default:
        return Icons.pending_actions;
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
          _buildApprovalsList(),
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
              'Pending Approvals',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${filteredApprovals.length} items require attention',
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
                // Sort functionality
              },
              icon: CustomIconWidget(
                iconName: 'sort',
                size: 6.w,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: () {
                // Filter functionality
              },
              icon: CustomIconWidget(
                iconName: 'filter_list',
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
    final filters = [
      'All',
      'Leave Request',
      'Overtime Request',
      'Training Request',
      'Remote Work',
      'Equipment Request'
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter;
          return Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilter = filter;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
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
                  filter,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.onPrimary
                        : AppTheme.lightTheme.colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildApprovalsList() {
    final approvals = filteredApprovals;

    return approvals.isEmpty
        ? _buildEmptyState()
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: approvals.length,
            separatorBuilder: (context, index) => SizedBox(height: 2.h),
            itemBuilder: (context, index) {
              final approval = approvals[index];
              return _buildApprovalCard(approval);
            },
          );
  }

  Widget _buildApprovalCard(Map<String, dynamic> approval) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.05),
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
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.w),
                  child: CustomImageWidget(
                    imageUrl: approval['employeePhoto'] as String,
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            approval['employee'] as String,
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(
                                    approval['priority'] as String)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(1.w),
                          ),
                          child: Text(
                            approval['priority'] as String,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: _getPriorityColor(
                                  approval['priority'] as String),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      approval['department'] as String,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          // Request details
          Row(
            children: [
              CustomIconWidget(
                iconName: _getTypeIcon(approval['type'] as String)
                    .codePoint
                    .toString(),
                size: 5.w,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      approval['type'] as String,
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                    Text(
                      approval['reason'] as String,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          // Duration and dates
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(2.w),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                      'Duration', approval['duration'] as String),
                ),
                Container(
                  width: 1,
                  height: 4.h,
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                ),
                Expanded(
                  child: _buildDetailItem(
                      'Start Date', approval['startDate'] as String),
                ),
                Container(
                  width: 1,
                  height: 4.h,
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                ),
                Expanded(
                  child: _buildDetailItem(
                      'Requested', approval['requestDate'] as String),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          // Description
          Text(
            approval['description'] as String,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.8),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () =>
                      widget.onApprovalAction?.call(approval, 'approve'),
                  icon: CustomIconWidget(
                    iconName: 'check',
                    size: 4.w,
                    color: AppTheme.lightTheme.colorScheme.onPrimary,
                  ),
                  label: Text('Approve'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.lightTheme.colorScheme.primary,
                    foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () =>
                      widget.onApprovalAction?.call(approval, 'reject'),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    size: 4.w,
                    color: AppTheme.lightTheme.colorScheme.error,
                  ),
                  label: Text('Reject'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.lightTheme.colorScheme.error,
                    side: BorderSide(
                        color: AppTheme.lightTheme.colorScheme.error),
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              IconButton(
                onPressed: () {
                  // View details
                },
                icon: CustomIconWidget(
                  iconName: 'visibility',
                  size: 6.w,
                  color: AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface
                .withValues(alpha: 0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          value,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
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
              iconName: 'check_circle',
              size: 15.w,
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.3),
            ),
            SizedBox(height: 2.h),
            Text(
              'All caught up!',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'No pending approvals at the moment',
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

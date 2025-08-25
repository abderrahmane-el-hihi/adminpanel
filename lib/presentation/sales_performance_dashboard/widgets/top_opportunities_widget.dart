import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TopOpportunitiesWidget extends StatefulWidget {
  final List<Map<String, dynamic>> opportunities;
  final Function(Map<String, dynamic> opportunity)? onOpportunityTapped;

  const TopOpportunitiesWidget({
    super.key,
    required this.opportunities,
    this.onOpportunityTapped,
  });

  @override
  State<TopOpportunitiesWidget> createState() => _TopOpportunitiesWidgetState();
}

class _TopOpportunitiesWidgetState extends State<TopOpportunitiesWidget> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredOpportunities {
    if (_searchQuery.isEmpty) {
      return widget.opportunities;
    }
    return widget.opportunities.where((opportunity) {
      final client = (opportunity['client'] as String).toLowerCase();
      final company = (opportunity['company'] as String).toLowerCase();
      final query = _searchQuery.toLowerCase();
      return client.contains(query) || company.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      height: 50.h,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with search
          Row(
            children: [
              Expanded(
                child: Text(
                  'Top Opportunities',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: 35.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search clients...',
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(2.w),
                      child: CustomIconWidget(
                        iconName: 'search',
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                        size: 20,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          // Opportunities list
          Expanded(
            child: _filteredOpportunities.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
                    itemCount: _filteredOpportunities.length,
                    separatorBuilder: (context, index) => SizedBox(height: 1.h),
                    itemBuilder: (context, index) {
                      final opportunity = _filteredOpportunities[index];
                      return _buildOpportunityCard(context, opportunity);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpportunityCard(
      BuildContext context, Map<String, dynamic> opportunity) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () => widget.onOpportunityTapped?.call(opportunity),
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Client photo
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary.withValues(alpha: 0.1),
              ),
              child: opportunity['photo'] != null
                  ? ClipOval(
                      child: CustomImageWidget(
                        imageUrl: opportunity['photo'] as String,
                        width: 12.w,
                        height: 12.w,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Center(
                      child: Text(
                        (opportunity['client'] as String)
                            .substring(0, 1)
                            .toUpperCase(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            ),
            SizedBox(width: 3.w),
            // Client details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    opportunity['client'] as String,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    opportunity['company'] as String,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'schedule',
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                        size: 14,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        opportunity['lastContact'] as String,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Value and probability
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${opportunity['value']}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color:
                        _getProbabilityColor(opportunity['probability'] as int)
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${opportunity['probability']}%',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _getProbabilityColor(
                          opportunity['probability'] as int),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => _makeCall(opportunity['phone'] as String),
                      child: Container(
                        padding: EdgeInsets.all(1.5.w),
                        decoration: BoxDecoration(
                          color: AppTheme.successLight.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomIconWidget(
                          iconName: 'call',
                          color: AppTheme.successLight,
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    GestureDetector(
                      onTap: () => _sendEmail(opportunity['email'] as String),
                      child: Container(
                        padding: EdgeInsets.all(1.5.w),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomIconWidget(
                          iconName: 'email',
                          color: colorScheme.primary,
                          size: 16,
                        ),
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

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'search_off',
            color: colorScheme.onSurface.withValues(alpha: 0.3),
            size: 48,
          ),
          SizedBox(height: 2.h),
          Text(
            'No opportunities found',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Try adjusting your search criteria',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Color _getProbabilityColor(int probability) {
    if (probability >= 80) return AppTheme.successLight;
    if (probability >= 60) return AppTheme.accentLight;
    if (probability >= 40) return AppTheme.secondaryLight;
    return AppTheme.errorLight;
  }

  void _makeCall(String phoneNumber) {
    // In a real app, this would use url_launcher to make a phone call
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Calling $phoneNumber...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _sendEmail(String email) {
    // In a real app, this would use url_launcher to open email client
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening email to $email...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

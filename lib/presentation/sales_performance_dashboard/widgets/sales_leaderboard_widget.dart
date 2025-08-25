import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SalesLeaderboardWidget extends StatefulWidget {
  final List<Map<String, dynamic>> salesReps;
  final String selectedPeriod;
  final Function(String period)? onPeriodChanged;

  const SalesLeaderboardWidget({
    super.key,
    required this.salesReps,
    required this.selectedPeriod,
    this.onPeriodChanged,
  });

  @override
  State<SalesLeaderboardWidget> createState() => _SalesLeaderboardWidgetState();
}

class _SalesLeaderboardWidgetState extends State<SalesLeaderboardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<String> _periods = ['This Month', 'This Quarter', 'This Year'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
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
          // Header with period selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sales Leaderboard',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: widget.selectedPeriod,
                    onChanged: (value) {
                      if (value != null) {
                        widget.onPeriodChanged?.call(value);
                      }
                    },
                    items: _periods.map((period) {
                      return DropdownMenuItem<String>(
                        value: period,
                        child: Text(
                          period,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                    icon: CustomIconWidget(
                      iconName: 'keyboard_arrow_down',
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                      size: 20,
                    ),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          // Leaderboard list
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Column(
                children: List.generate(
                  widget.salesReps.length,
                  (index) => _buildLeaderboardItem(context, index),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(BuildContext context, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final rep = widget.salesReps[index];
    final rank = index + 1;
    final isTopThree = rank <= 3;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200 + (index * 100)),
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: isTopThree
            ? _getRankColor(rank).withValues(alpha: 0.05)
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isTopThree
              ? _getRankColor(rank).withValues(alpha: 0.2)
              : colorScheme.outline.withValues(alpha: 0.1),
          width: isTopThree ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Rank badge
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: isTopThree
                  ? _getRankColor(rank)
                  : colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isTopThree && rank <= 3
                  ? CustomIconWidget(
                      iconName: rank == 1
                          ? 'emoji_events'
                          : rank == 2
                              ? 'military_tech'
                              : 'workspace_premium',
                      color: Colors.white,
                      size: 20,
                    )
                  : Text(
                      '$rank',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isTopThree ? Colors.white : colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
          SizedBox(width: 3.w),
          // Rep photo
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withValues(alpha: 0.1),
            ),
            child: rep['photo'] != null
                ? ClipOval(
                    child: CustomImageWidget(
                      imageUrl: rep['photo'] as String,
                      width: 12.w,
                      height: 12.w,
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(
                    child: Text(
                      (rep['name'] as String).substring(0, 1).toUpperCase(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
          SizedBox(width: 3.w),
          // Rep details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rep['name'] as String,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                Text(
                  rep['territory'] as String,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 1.h),
                // Achievement badges
                Row(
                  children: [
                    if (rep['achievements'] != null)
                      ...(rep['achievements'] as List)
                          .take(2)
                          .map((achievement) {
                        return Container(
                          margin: EdgeInsets.only(right: 1.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: _getAchievementColor(achievement as String)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            achievement,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: _getAchievementColor(achievement),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                  ],
                ),
              ],
            ),
          ),
          // Performance metrics
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${rep['revenue']}',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                '${rep['deals']} deals',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(height: 1.h),
              // Progress bar
              Container(
                width: 20.w,
                height: 0.8.h,
                decoration: BoxDecoration(
                  color: colorScheme.outline.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (rep['targetProgress'] as double) / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _getProgressColor(rep['targetProgress'] as double),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                '${rep['targetProgress'].toInt()}% to target',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return AppTheme.primaryLight;
    }
  }

  Color _getAchievementColor(String achievement) {
    switch (achievement.toLowerCase()) {
      case 'top performer':
        return AppTheme.successLight;
      case 'deal closer':
        return AppTheme.primaryLight;
      case 'new client':
        return AppTheme.secondaryLight;
      case 'quota crusher':
        return AppTheme.accentLight;
      default:
        return AppTheme.primaryLight;
    }
  }

  Color _getProgressColor(double progress) {
    if (progress >= 100) return AppTheme.successLight;
    if (progress >= 80) return AppTheme.accentLight;
    if (progress >= 60) return AppTheme.secondaryLight;
    return AppTheme.errorLight;
  }
}

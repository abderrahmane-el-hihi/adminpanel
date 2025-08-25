import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PipelineFunnelWidget extends StatefulWidget {
  final List<Map<String, dynamic>> funnelData;
  final Function(int stageIndex, Map<String, dynamic> deal)? onDealMoved;

  const PipelineFunnelWidget({
    super.key,
    required this.funnelData,
    this.onDealMoved,
  });

  @override
  State<PipelineFunnelWidget> createState() => _PipelineFunnelWidgetState();
}

class _PipelineFunnelWidgetState extends State<PipelineFunnelWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int? _selectedStageIndex;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
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
      height: 45.h,
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
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sales Pipeline',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Total: \$${_calculateTotalValue()}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          // Funnel visualization
          Expanded(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      widget.funnelData.length,
                      (index) => _buildFunnelStage(context, index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFunnelStage(BuildContext context, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final stage = widget.funnelData[index];
    final isSelected = _selectedStageIndex == index;
    final stageColor = _getStageColor(index);
    final deals = (stage['deals'] as List).cast<Map<String, dynamic>>();

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStageIndex = isSelected ? null : index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 2.h),
        child: Column(
          children: [
            // Stage header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: stageColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? stageColor : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: stageColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stage['stage'] as String,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          '${deals.length} deals • \$${stage['value']}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomIconWidget(
                    iconName: isSelected ? 'expand_less' : 'expand_more',
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                    size: 24,
                  ),
                ],
              ),
            ),
            // Expanded deals list
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isSelected ? null : 0,
              child: isSelected
                  ? Container(
                      margin: EdgeInsets.only(top: 1.h),
                      child: Column(
                        children: deals
                            .map((deal) => _buildDealCard(context, deal, index))
                            .toList(),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDealCard(
      BuildContext context, Map<String, dynamic> deal, int stageIndex) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Client avatar
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withValues(alpha: 0.1),
            ),
            child: deal['clientPhoto'] != null
                ? ClipOval(
                    child: CustomImageWidget(
                      imageUrl: deal['clientPhoto'] as String,
                      width: 10.w,
                      height: 10.w,
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(
                    child: Text(
                      (deal['client'] as String).substring(0, 1).toUpperCase(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
          SizedBox(width: 3.w),
          // Deal details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deal['client'] as String,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                Row(
                  children: [
                    Text(
                      '\$${deal['value']}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: _getProbabilityColor(deal['probability'] as int)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${deal['probability']}%',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color:
                              _getProbabilityColor(deal['probability'] as int),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Action buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (stageIndex > 0)
                GestureDetector(
                  onTap: () => widget.onDealMoved?.call(stageIndex - 1, deal),
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: CustomIconWidget(
                      iconName: 'arrow_back',
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                      size: 16,
                    ),
                  ),
                ),
              SizedBox(width: 2.w),
              if (stageIndex < widget.funnelData.length - 1)
                GestureDetector(
                  onTap: () => widget.onDealMoved?.call(stageIndex + 1, deal),
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomIconWidget(
                      iconName: 'arrow_forward',
                      color: colorScheme.primary,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStageColor(int index) {
    final colors = [
      AppTheme.primaryLight,
      AppTheme.secondaryLight,
      AppTheme.accentLight,
      AppTheme.successLight,
      AppTheme.errorLight,
    ];
    return colors[index % colors.length];
  }

  Color _getProbabilityColor(int probability) {
    if (probability >= 80) return AppTheme.successLight;
    if (probability >= 60) return AppTheme.accentLight;
    if (probability >= 40) return AppTheme.secondaryLight;
    return AppTheme.errorLight;
  }

  String _calculateTotalValue() {
    double total = 0;
    for (final stage in widget.funnelData) {
      final deals = (stage['deals'] as List).cast<Map<String, dynamic>>();
      for (final deal in deals) {
        total +=
            double.tryParse(deal['value'].toString().replaceAll(',', '')) ?? 0;
      }
    }
    return total.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}

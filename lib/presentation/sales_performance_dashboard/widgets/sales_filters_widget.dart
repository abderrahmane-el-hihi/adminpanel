import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class SalesFiltersWidget extends StatefulWidget {
  final String selectedTerritory;
  final String selectedRep;
  final String selectedPeriod;
  final List<String> territories;
  final List<String> salesReps;
  final List<String> periods;
  final Function(String territory)? onTerritoryChanged;
  final Function(String rep)? onRepChanged;
  final Function(String period)? onPeriodChanged;
  final VoidCallback? onResetFilters;

  const SalesFiltersWidget({
    super.key,
    required this.selectedTerritory,
    required this.selectedRep,
    required this.selectedPeriod,
    required this.territories,
    required this.salesReps,
    required this.periods,
    this.onTerritoryChanged,
    this.onRepChanged,
    this.onPeriodChanged,
    this.onResetFilters,
  });

  @override
  State<SalesFiltersWidget> createState() => _SalesFiltersWidgetState();
}

class _SalesFiltersWidgetState extends State<SalesFiltersWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
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
        children: [
          // Header with expand/collapse
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'filter_list',
                    color: colorScheme.primary,
                    size: 24,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      'Filters',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Active filters indicator
                  if (_hasActiveFilters())
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      margin: EdgeInsets.only(right: 2.w),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_getActiveFiltersCount()}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  CustomIconWidget(
                    iconName: _isExpanded ? 'expand_less' : 'expand_more',
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          // Expandable filters content
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isExpanded ? null : 0,
            child: _isExpanded
                ? Container(
                    padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
                    child: Column(
                      children: [
                        // Quick filters row
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildQuickFilter(
                                context,
                                'Territory',
                                widget.selectedTerritory,
                                widget.territories,
                                widget.onTerritoryChanged,
                              ),
                              SizedBox(width: 3.w),
                              _buildQuickFilter(
                                context,
                                'Sales Rep',
                                widget.selectedRep,
                                widget.salesReps,
                                widget.onRepChanged,
                              ),
                              SizedBox(width: 3.w),
                              _buildQuickFilter(
                                context,
                                'Period',
                                widget.selectedPeriod,
                                widget.periods,
                                widget.onPeriodChanged,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 3.h),
                        // Reset filters button
                        if (_hasActiveFilters())
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: widget.onResetFilters,
                              icon: CustomIconWidget(
                                iconName: 'refresh',
                                color: colorScheme.primary,
                                size: 20,
                              ),
                              label: Text(
                                'Reset Filters',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                side: BorderSide(
                                  color: colorScheme.primary
                                      .withValues(alpha: 0.3),
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilter(
    BuildContext context,
    String label,
    String selectedValue,
    List<String> options,
    Function(String)? onChanged,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isActive = selectedValue != 'All';

    return Container(
      constraints: BoxConstraints(minWidth: 25.w),
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: isActive
            ? colorScheme.primary.withValues(alpha: 0.1)
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive
              ? colorScheme.primary.withValues(alpha: 0.3)
              : colorScheme.outline.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 0.5.h),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              onChanged: onChanged != null ? (String? value) {
                if (value != null) onChanged(value);
              } : null,
              isExpanded: true,
              isDense: true,
              items: options.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              icon: CustomIconWidget(
                iconName: 'keyboard_arrow_down',
                color: colorScheme.onSurface.withValues(alpha: 0.6),
                size: 20,
              ),
              dropdownColor: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              menuMaxHeight: 30.h,
            ),
          ),
        ],
      ),
    );
  }

  bool _hasActiveFilters() {
    return widget.selectedTerritory != 'All' ||
        widget.selectedRep != 'All' ||
        widget.selectedPeriod != 'This Month';
  }

  int _getActiveFiltersCount() {
    int count = 0;
    if (widget.selectedTerritory != 'All') count++;
    if (widget.selectedRep != 'All') count++;
    if (widget.selectedPeriod != 'This Month') count++;
    return count;
  }
}
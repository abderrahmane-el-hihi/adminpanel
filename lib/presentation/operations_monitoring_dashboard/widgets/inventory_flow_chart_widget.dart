import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class InventoryFlowChartWidget extends StatefulWidget {
  const InventoryFlowChartWidget({super.key});

  @override
  State<InventoryFlowChartWidget> createState() =>
      _InventoryFlowChartWidgetState();
}

class _InventoryFlowChartWidgetState extends State<InventoryFlowChartWidget> {
  final List<Map<String, dynamic>> inventoryData = [
    {
      "category": "Electronics",
      "inStock": 450,
      "lowStock": 25,
      "outOfStock": 8,
      "incoming": 120,
      "color": AppTheme.lightTheme.colorScheme.primary,
    },
    {
      "category": "Office Supplies",
      "inStock": 320,
      "lowStock": 45,
      "outOfStock": 12,
      "incoming": 80,
      "color": AppTheme.lightTheme.colorScheme.secondary,
    },
    {
      "category": "Furniture",
      "inStock": 180,
      "lowStock": 15,
      "outOfStock": 5,
      "incoming": 35,
      "color": AppTheme.lightTheme.colorScheme.tertiary,
    },
    {
      "category": "Raw Materials",
      "inStock": 680,
      "lowStock": 85,
      "outOfStock": 20,
      "incoming": 200,
      "color": AppTheme.successLight,
    },
  ];

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
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
                  spreadRadius: 0),
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Inventory Flow Analysis',
                style: AppTheme.lightTheme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600)),
            Row(children: [
              GestureDetector(
                  onTap: () => _showBarcodeScanner(context),
                  child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.primary
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8)),
                      child: CustomIconWidget(
                          iconName: 'qr_code_scanner',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 20))),
              SizedBox(width: 2.w),
              GestureDetector(
                  onTap: () => _refreshData(),
                  child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.secondary
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8)),
                      child: CustomIconWidget(
                          iconName: 'refresh',
                          color: AppTheme.lightTheme.colorScheme.secondary,
                          size: 20))),
            ]),
          ]),
          SizedBox(height: 3.h),
          Container(
              height: 35.h,
              child: BarChart(BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 800,
                  barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                          tooltipBorder:
                              BorderSide(color: AppTheme.borderLight, width: 1),
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final category = inventoryData[group.x.toInt()]
                                ["category"] as String;
                            final value = rod.toY.round();
                            final labels = [
                              'In Stock',
                              'Low Stock',
                              'Out of Stock',
                              'Incoming'
                            ];
                            return BarTooltipItem(
                                '$category\n${labels[rodIndex]}: $value',
                                AppTheme.lightTheme.textTheme.bodySmall!);
                          }),
                      touchCallback: (FlTouchEvent event, barTouchResponse) {
                        setState(() {
                          if (barTouchResponse != null &&
                              barTouchResponse.spot != null) {
                            selectedIndex =
                                barTouchResponse.spot!.touchedBarGroupIndex;
                          } else {
                            selectedIndex = -1;
                          }
                        });
                      }),
                  titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                final index = value.toInt();
                                if (index >= 0 &&
                                    index < inventoryData.length) {
                                  return Padding(
                                      padding: EdgeInsets.only(top: 1.h),
                                      child: Text(
                                          inventoryData[index]["category"]
                                              as String,
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall
                                              ?.copyWith(fontSize: 10.sp),
                                          textAlign: TextAlign.center));
                                }
                                return const SizedBox.shrink();
                              },
                              reservedSize: 6.h)),
                      leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 10.w,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                return Text(value.toInt().toString(),
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(fontSize: 10.sp));
                              }))),
                  borderData: FlBorderData(show: false),
                  barGroups: inventoryData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    final isSelected = selectedIndex == index;

                    return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                              toY: (data["inStock"] as int).toDouble(),
                              color: (data["color"] as Color)
                                  .withValues(alpha: isSelected ? 1.0 : 0.8),
                              width: 3.w,
                              borderRadius: BorderRadius.circular(2)),
                          BarChartRodData(
                              toY: (data["lowStock"] as int).toDouble(),
                              color: AppTheme.accentLight
                                  .withValues(alpha: isSelected ? 1.0 : 0.8),
                              width: 3.w,
                              borderRadius: BorderRadius.circular(2)),
                          BarChartRodData(
                              toY: (data["outOfStock"] as int).toDouble(),
                              color: AppTheme.errorLight
                                  .withValues(alpha: isSelected ? 1.0 : 0.8),
                              width: 3.w,
                              borderRadius: BorderRadius.circular(2)),
                          BarChartRodData(
                              toY: (data["incoming"] as int).toDouble(),
                              color: AppTheme.successLight
                                  .withValues(alpha: isSelected ? 1.0 : 0.8),
                              width: 3.w,
                              borderRadius: BorderRadius.circular(2)),
                        ],
                        barsSpace: 1.w);
                  }).toList(),
                  gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 100,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                            color: AppTheme.borderLight.withValues(alpha: 0.3),
                            strokeWidth: 1);
                      })))),
          SizedBox(height: 2.h),
          _buildLegend(),
          SizedBox(height: 2.h),
          _buildLowStockAlerts(),
        ]));
  }

  Widget _buildLegend() {
    final legendItems = [
      {'label': 'In Stock', 'color': AppTheme.lightTheme.colorScheme.primary},
      {'label': 'Low Stock', 'color': AppTheme.accentLight},
      {'label': 'Out of Stock', 'color': AppTheme.errorLight},
      {'label': 'Incoming', 'color': AppTheme.successLight},
    ];

    return Wrap(
        spacing: 4.w,
        runSpacing: 1.h,
        children: legendItems.map((item) {
          return Row(mainAxisSize: MainAxisSize.min, children: [
            Container(
                width: 3.w,
                height: 3.w,
                decoration: BoxDecoration(
                    color: item['color'] as Color,
                    borderRadius: BorderRadius.circular(2))),
            SizedBox(width: 1.w),
            Text(item['label'] as String,
                style: AppTheme.lightTheme.textTheme.bodySmall),
          ]);
        }).toList());
  }

  Widget _buildLowStockAlerts() {
    final lowStockItems = [
      {
        'name': 'Wireless Headphones',
        'current': 5,
        'minimum': 20,
        'category': 'Electronics'
      },
      {
        'name': 'Office Chairs',
        'current': 3,
        'minimum': 10,
        'category': 'Furniture'
      },
      {
        'name': 'Printer Paper',
        'current': 12,
        'minimum': 50,
        'category': 'Office Supplies'
      },
    ];

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        CustomIconWidget(
            iconName: 'warning', color: AppTheme.accentLight, size: 20),
        SizedBox(width: 2.w),
        Text('Low Stock Alerts',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600, color: AppTheme.accentLight)),
      ]),
      SizedBox(height: 1.h),
      ...lowStockItems.map((item) {
        return Container(
            margin: EdgeInsets.only(bottom: 1.h),
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
                color: AppTheme.accentLight.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: AppTheme.accentLight.withValues(alpha: 0.3),
                    width: 1)),
            child: Row(children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(item['name'] as String,
                        style: AppTheme.lightTheme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500)),
                    Text(
                        '${item['category']} • Current: ${item['current']} • Min: ${item['minimum']}',
                        style: AppTheme.lightTheme.textTheme.bodySmall
                            ?.copyWith(color: AppTheme.textSecondaryLight)),
                  ])),
              GestureDetector(
                  onTap: () => _reorderItem(item['name'] as String),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(6)),
                      child: Text('Reorder',
                          style: AppTheme.lightTheme.textTheme.bodySmall
                              ?.copyWith(
                                  color:
                                      AppTheme.lightTheme.colorScheme.onPrimary,
                                  fontWeight: FontWeight.w500)))),
            ]));
      }).toList(),
    ]);
  }

  void _showBarcodeScanner(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
            height: 70.h,
            decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20))),
            child: Column(children: [
              Container(
                  width: 10.w,
                  height: 0.5.h,
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: BoxDecoration(
                      color: AppTheme.borderLight,
                      borderRadius: BorderRadius.circular(2))),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Scan Barcode',
                            style: AppTheme.lightTheme.textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: CustomIconWidget(
                                iconName: 'close',
                                color: AppTheme.textSecondaryLight,
                                size: 24)),
                      ])),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                          color: AppTheme.backgroundLight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppTheme.borderLight, width: 2)),
                      child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            CustomIconWidget(
                                iconName: 'qr_code_scanner',
                                color: AppTheme.lightTheme.colorScheme.primary,
                                size: 80),
                            SizedBox(height: 2.h),
                            Text('Position barcode within the frame',
                                style: AppTheme.lightTheme.textTheme.bodyLarge,
                                textAlign: TextAlign.center),
                            SizedBox(height: 1.h),
                            Text('Camera will automatically scan when detected',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                        color: AppTheme.textSecondaryLight),
                                textAlign: TextAlign.center),
                          ])))),
            ])));
  }

  void _refreshData() {
    setState(() {
      // Simulate data refresh
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Inventory data refreshed'),
        backgroundColor: AppTheme.successLight,
        duration: const Duration(seconds: 2)));
  }

  void _reorderItem(String itemName) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Reorder request sent for $itemName'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        duration: const Duration(seconds: 2)));
  }
}
